# -*- coding: utf-8 -*-
###################################
        ################
# Program to perform SpoTyping using assembled contigs given in a folder
# Written by Dr. Reema Singh. Date: 31 September 2021
        ################
####################################

import os,sys
import shutil
import re

parent_dir = 'AssembledContigs/ALL-Contigs'

for csv in os.listdir(parent_dir):
    if csv.endswith("fasta"):
        fasta = os.path.join(parent_dir,csv)
        out = re.sub('fasta','out',fasta)
        cmd = "python SpoTyping.py --seq " + fasta + " -o " + out 
        #os.system(cmd)
        print(cmd)
       

