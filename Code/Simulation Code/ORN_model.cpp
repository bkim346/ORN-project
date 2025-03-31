#include <stdio.h> 
#include <stdlib.h> 
#include <math.h>
#include <map>
#include <ctime>
#include <fstream>
#include <string>
#include <iostream>

using namespace std;

#define	nORN	10000
#define nITER	110000
#define nCLUST	4
//#define nPULSES	100


//-- Regular spiking neuron cell---------------------------------------
class RS{
  double y, xp, sigma_n, beta_n;   //Bazh 05, eq.1; xp==xn,xpp==x_(n-1),y==yn
  double Xi, I_n, Ip_n, Id_n, Im_n, hp_n;
public:
  double x;
  double alpha, mu, sigma;			//Main params
  double sigma_e, beta_e, tau_c, d, h, q, p; 	//Noise params
  double S_CX_DEND; 				//Is this necessary?!
  double beta_I, sigma_I;			//Input params
  double gamma_s, a_s, gamma_d,a_d,L, gamma_h;				//Stimulus Response-Determined by class
  int spike;                              	//spike triggered
  int type;					//Type of ORN - Class

  RS(){ }

  void init(int type_in, double sig){	
    spike=0;
    //Main parameters
    mu		= 0.00005;          //Bazh 05
    alpha	= 3.65;         //Bazh 05
    sigma	= sig;

    //Input Parameters
//    beta_I      = 0.1;
    sigma_I	= 1;         

    //Noise Parameters
    tau_c       = 3;
    d           = 0.01;
    beta_e      = 0.1;
    sigma_e	= 1.0;        //Bazh 05
    h		= 0.5;
    q 		= exp(-h/tau_c);
    p		= d*sqrt(1-(q*q));

    hp_n = 0;
    //Stimulus Parameters
    type = type_in;
	switch(type_in) {
		case 0: //Strongly responding and adapting 0: delayed
			gamma_s = 0.999; 
	 	 	a_s 	= 0.08;
			gamma_d = 0.99;
			a_d 	= 0.8;
			beta_I  = 0.01;
			L	= 0.04;
			gamma_h = 0.99985;
		break;
		case 1: //Weakly responding and adapting 1:excitatory
        	  	gamma_s	= 0.995;
			a_s	= 0.039;
			beta_I 	= 0.1;
          	break;
       		case 2: //Inhibitory with offset 2: Offset
          		gamma_s	= 0.998;
	  		a_s	= -0.02;
			beta_I  = 0.1;
          	break;
       		case 3: //Inhibitory without offset 3: Inhibitory
          		gamma_s	= 0.998;
	  		a_s	= -0.04;
			beta_I  = 0.2;
          	break;
	}

    //area of the cell
    S_CX_DEND 	= 165.0e-6; 

    //initial conditions
    xp=-1+sigma;
    x=-1+sigma;
    y= x - alpha/(1-x);


  }

  void calc(double,double);
};

//x is the fast variable between (0,1)
//y is slow variable
void RS::calc(double s_n,double s_p){
  double r1, r2, w_n;
  const double pi = 3.14159265359;
  //Calc Noise
  r1 = rand()/(RAND_MAX + 1.0);
  r2 = rand()/(RAND_MAX + 1.0);
  w_n = sqrt(-2*log(r1))*cos(2*pi*r2); 
  
  Xi = q*Xi - p*w_n;

  //Stimulus
  if (type==0) {
	Id_n = gamma_d*Id_n + a_d*(s_n-s_p);
	hp_n = gamma_h * hp_n + (s_n - s_p);
	Ip_n = gamma_s*Ip_n + (1.0-gamma_s)*a_s*hp_n;
	Im_n = Ip_n - Id_n * (Id_n>0);
	I_n  = Im_n * ((Im_n+L)>0);

  }
  else
  	I_n = gamma_s*I_n + (1-gamma_s)*a_s*s_n;


  //Input Variables
  beta_n = beta_e * Xi + beta_I * I_n; 
  sigma_n = sigma_e * Xi + sigma_I*I_n; 

  //Dynamic Variables
  if(xp < -0.5) {
    x = alpha / (1.0 - xp) + y +beta_n;
    spike = 0;
  }
  else{
    if(xp < 1.0) {
      x = 1;
      spike = 1;
    }
    else {
      x = -1;
      spike = 0;
    }
  }
  //Bazh 05, eq.1
  y = y - mu* (xp +1.0 - sigma - sigma_n);
  xp = x;
}








//------------------------------
// --------- MAIN CODE ---------
//------------------------------

int main(int argc, char **argv)
{
	int i, j, k, i_tmp;					//Ints
	RS ORNs[nORN];						//ORNs	
	double h = 0.5;						//TIME STEP		
	double a_x[nORN];					//Stimulus
	double p_clust[nCLUST] = {0.136,0.258,0.222,0.384};	//Prob of being in clust
//        double p_clust[nCLUST] = {0.25,0.25,0.25,0.35};     //Prob of being in clust

	double p_sum=p_clust[0]+p_clust[1]+p_clust[2]+p_clust[3];
	for (i=0;i<4;i++) p_clust[i]/=p_sum;
	double p_clust_sum[nCLUST] = {p_clust[0],p_clust[0]+p_clust[1],p_clust[0]+p_clust[1]+p_clust[2], 1};	//Sum of above
	double r1[nORN], r2, z;					//Random numbers
	double sig_min = 0.02, sig_max = 0.11, sig[nORN];		//Sigma - Intra-class hetero.
	double sf=2000;						//Sampling Freq. Hz
	double IPI_d;
	double p_switch;
	// int type;						//Class
	int type;
	int i_stim_idx = 0, IPI;			//Current Pulse, durantion, interval
	int i_st, i_en;						//Pulse Counters
	int iTrial, iOdor, iStim, w_plume, w_odor,rOdors,w_a;				//Trial number, Odor, Stim type
	int i_total_iters, tt_act;					//Simulation length dep. on IPI
	int tstim, tinter,tfirstpulse,tfin;
	int *i_stim_start, *i_stim_end, nTruePulses=0; //this vectors keep the stimilus info
	char DIR_STR[100], ORN_Output[200], Classes_Output[200], CORE_DIR_STR[200], ORN_typ[200];
	char input_str[100], stim_str[100];
	time_t tstart, tend;
	double mangle, dist;
	FILE *fOutput, *f_typ;

	cout<<"Get data"<<endl;
	//Get info from CMD LINE
	iTrial = atoi(argv[1]);
	iStim = atoi(argv[2]); // 0: periodic, 1: plume
	if (iStim == 0) {
		nTruePulses = atoi(argv[3]);
		tfirstpulse = atoi(argv[4]);
		tstim = atoi(argv[5]); // pulse duration
		tinter = atoi(argv[6]); //interval between pulses
		tfin = tfirstpulse+nTruePulses*(tstim+tinter);	
	}
	else if (iStim ==1) {
		w_plume = atoi(argv[3]); //in case we want to try different plumes in the future
		tt_act = atoi(argv[4]); //tiempo UP que queremos
		tfin = atoi(argv[5]);
	}
	w_odor = atoi(argv[7]); // 0 for a_x=1, 1 reads from file
	if (w_odor ==1) {
		iOdor = atoi(argv[8]); // which of the odors
		rOdors = atoi(argv[9]);
		sscanf(argv[10],"%lf",&mangle);
		dist = atof(argv[11]);
	}
	else iOdor=rOdors=0;
	p_switch = atof(argv[12]);
	cout<<"tfin "<<tfin<<endl;
	cout<<mangle<<endl;

	sprintf(CORE_DIR_STR, "/bazhlab/sjoshi/ORN_temporal_features/PID_stim");

////////////////////////// ********************* Load Input to ORNs   ********************
	if (w_odor==1) {
		sprintf(input_str, "%s/Odors/affinity_amax20_odor%d_%d.txt", 
				CORE_DIR_STR,iOdor,rOdors);
		printf("Reading from Input file %s\n", input_str);
		ifstream fodor(input_str);
		if (!fodor) cout<<"NO ODOR"<<endl;
		double aux_max=0.0,auxm=0.0;
		for (i=0; i<nORN; i++) {
			fodor>>a_x[i];
			if (a_x[i]<1E-5) a_x[i]=0.0;
		}
		fodor.close();
	}
	else for (i=0;i<nORN;i++) a_x[i]=1.0;


///////////////******************** Load Stim times   ******************** 

	cout<<"Get stimulus"<<endl;

	sprintf(stim_str,"Pulse_inp_1s.dat");
	printf("Reading from Input file %s\n", stim_str);
	ifstream fStim (stim_str);
//first: number of lines
	string line;
	int nlines=0;
	while (getline(fStim,line)) if (!line.empty()) nlines++;
	fStim.clear();
	fStim.seekg(0, ios::beg); //con esto vuelvo al principio del documento
//Now we can allocate memory and read data
	i_stim_start = new int [nlines];
	i_stim_end = new int [nlines];
	double b_n[nlines];
	for (i=0;i<nlines;i++) {
		fStim>>b_n[i];
	}
	fStim.close();
	i_total_iters=nlines;



	sprintf(DIR_STR,"Output/p_switch_%.1f", p_switch);
	// cout<<"Saving data in "<<DIR_STR<<endl;
	// sprintf(DIR_STR,"Output_random/p_switch_1.0");


	sprintf(Classes_Output, "%s/Classes_N%d_odor%d_OP_pulse.out", DIR_STR,nORN, iOdor);
////////////////////*********************   Files      ************************
	sprintf(ORN_Output,"%s/ORN_odor_%d_%d_trial_%d_pulse.out",DIR_STR, iOdor,rOdors, iTrial);
	// printf("\n%s\n", ORN_Output);
	// ofstream fOutput(ORN_Output);
	fOutput = fopen(ORN_Output, "w");

	// cout<<"Saving data in "<<ORN_Output<<endl;
	cout<<"Saving data in "<<DIR_STR<<endl;


///////////////******************   CREATE ORNS    ***************************
	// srand(100);

	// cout<<"Creating typ vector "<<endl;
	// for (i=0;i<nORN;i++){
	// 	r1[i] = rand()/(1.0+RAND_MAX);
	// }

	srand(100);
	cout<<"Creating sig vector "<<endl;
	for (i=0;i<nORN;i++){
		sig[i] = sig_min + (sig_max-sig_min)*(rand()/(1.0+RAND_MAX));
	}
	
	// int xx;
	cout<<"Creating typ vector "<<endl;
	
	sprintf(ORN_typ, "ORN_classes/Types_odour_%d_p_switch_%.1f.txt", iOdor, p_switch);
	// sprintf(ORN_typ, "ORN_classes/Types_odour_%d_p_switch_1.0.txt", iOdor);

	cout<<"Creating ORNs..."<<endl;
	
	f_typ = fopen(ORN_typ, "r");
	
	if(f_typ == NULL) printf("oops\n");

	for (k=0;k<nORN;k++){
		fscanf(f_typ, "%d", &type);
		ORNs[k].init(type,sig[k]);
		// printf("ORNtyp = %d\n", ORNs[k].type);
		// type[i] = xx;
	}

	fclose(f_typ);

	
	// // make different arrays for typ and sig and and seed them separately
	// for (i=0;i<nORN;i++){
	// 	// Determine Cluster
	// 	cout<<i<<endl;
	// 	r1 = rand()/(1.0+RAND_MAX);
	// 	type = 0;
	// 	while (r1[i]>p_clust_sum[type]) type++;
	// 	//Determine Sig - Intra-class heterogeneity
	// 	// sig = sig_min + (sig_max-sig_min)*(rand()/(1.0+RAND_MAX));
		
	// 	//Initialize ORNs
		
	// 	//sig is 
	// 	fClasses<<i<<" "<<type<<endl;

	// }
	if (iTrial==1 ){//&& iOdor==1) {
		ofstream fClasses(Classes_Output);
		for (i=0;i<nORN;i++) fClasses<<i<<" "<<ORNs[i].type<<endl;
		fClasses.close();
	}
//	fclose(fClasses);
//	fClasses.close();

	// Re-seed rand for trial-to-trial variation
	srand(iTrial+1000*iOdor+200);

	cout<<"Done"<<endl;



	
 
//***********************************    MAIN SIMULATION   *********************
 
	tstart = time(0);
	printf("Starting simulation...\n");
	int imark=0, jmark=0; 
	double b_p;
	for (i=0;i<i_total_iters;i++){
		if (i%1000==0) printf("t = %i\n", i);

		if (i==0) {b_p  = 0;} else{ b_p = b_n[i-1];}

		//Main calculation
		for (j=0;j<nORN;j++){
//			ORNs[j].calc(b_n[i]);
			ORNs[j].calc(a_x[j]*b_n[i],a_x[j]*b_p);
			if(ORNs[j].spike==1) {
				// fOutput<<i<<" "<<j<<endl;
				fprintf(fOutput, "%d %d\n", i,j);

				// printf("%d %d\n", i,j);
			}
		}
	}
	printf("Done.\n");
	tend = time(0); 
	printf("Simulation took %lf seconds.\n", difftime(tend,tstart));

	fclose(fOutput);
	// fOutput.close();

	return 0;
}	//END OF MAIN

	
