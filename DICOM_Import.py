#Read Dicom program

import dicom
import os
#currpath=os.getcwd()
#print 'Current Path is:',currpath
dicompath= "/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/2014_01_27/140127_m_FDGF18_001/histo_1/ct/CTImage_00001.dcm"
f = open(dicompath)
print 'Open Path:Success!'
ds = dicom.read_file(dicompath)
print 'Import:Success!!'
f.close()

from numpy import *
pixval = ds.pixel_array
newpixval = 
