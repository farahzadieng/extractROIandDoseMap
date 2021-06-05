import os
import nibabel as nib
import numpy as np 

# Edit folder_path
folder_path = 'D:\\Python\\Projects\\fixProstateSeeding\\dset'

######
subdirectories = os.listdir(folder_path)
counter = 0
for i in subdirectories: 
  counter += 1
  print('%',int(counter/len(subdirectories)*100),' of dataset is processed.')
  if os.path.isdir(os.path.join(folder_path,i)):	
    if len(os.listdir(os.path.join(folder_path,i))) != 0:
      rs = nib.load(os.path.join(os.path.join(folder_path,i),'Structure.nii')).get_fdata()
      ct = nib.load(os.path.join(os.path.join(folder_path,i),'CT.nii')).get_fdata()
      ctAffine = nib.load(os.path.join(os.path.join(folder_path,i),'CT.nii')).affine
      ctFixed = np.zeros(ct.shape)
      II = np.where(rs == 1)[0]
      JJ = np.where(rs == 1)[1]
      ZZ = np.where(rs == 1)[2]
      prostateMeanVal = np.mean(ct[II,JJ,ZZ])
      for x in range(len(II)):
        if ct[II[x],JJ[x],ZZ[x]] > prostateMeanVal+50:
          ct[II[x],JJ[x],ZZ[x]] = prostateMeanVal
      niftiImg = nib.Nifti1Image(ct,ctAffine) 
      folderAddress = os.path.join(folder_path,i)
      nib.save(niftiImg,folderAddress+'\\CT_Fixed6.nii')