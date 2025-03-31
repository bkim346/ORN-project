#!/bin/python 

import subprocess
import os
import numpy as np
 
FNULL = open(os.devnull, 'w')
NDist = 4; NTrials=10; NODS = 10;
MAX_CNT = 30
ps = []
# p_list = np.arange(0,11)
switch_probs = 11

for i_odor in range(NODS):
	for i_trial in range(NTrials):
		for p_switch in range(len(switch_probs)):
	    # cmd_str = './c.out %d 0 1 1000 4000 1000 1 %d 0 0.4 %g &'%(i_trial+1,i_odor+1,-1)
		    cmd_str = './4_class_1s.out %d 1 -1 50000 8000 -1 1 %d 1 0.4 %g %.1f &'%(i_trial+1,i_odor+1,-1, p_switch/10.0)
		    cmd_str = './c.out %d %d %d %d %d %d %d %d %d %d %g &' %(i_trial+1, iStim, nTruePulses, tfirstpulse, tstim, tinter, w_odor, iOdor, rOdors, 0.4,-1)

		    if len(ps)>=MAX_CNT:
		        for _p in ps:
		            _p.wait()
		        print('Waiting...')
		        ps = []

		    _p = subprocess.Popen(cmd_str.split(), stdout=FNULL, stderr=subprocess.STDOUT)
		    ps.append(_p)
		    print(cmd_str)

# _p.wait()
print("Done")

