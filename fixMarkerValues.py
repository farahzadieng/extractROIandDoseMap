import os
import nibabel as nib
import numpy as np 

def cropScenes(scene):
  aboveCut = 33
  belowCut = 369
  leftCut = 48
  rightCut = 472
  return scene[aboveCut:belowCut,leftCut:rightCut,:]

def neighbourMatrix(matrix,mean):
  Ux = np.where(matrix>mean+50)[0]
  Uy = np.where(matrix>mean+50)[1]
  for s in range(len(Ux)):
    matrix[Ux[s],Uy[s]] = mean
  return matrix


# Edit folder_path
folder_path = 'D:\\Python\\Projects\\fixProstateSeeding\\dset'

subdirectories = os.listdir(folder_path)
counter = 0
for i in subdirectories: 
  counter += 1
  print('%',int(counter/len(subdirectories)*100),' of dataset is processed.')
  if os.path.isdir(os.path.join(folder_path,i)):	
    if len(os.listdir(os.path.join(folder_path,i))) != 0:
      rd = cropScenes(nib.load(os.path.join(os.path.join(folder_path,i),'RD.nii')).get_fdata())
      rs = cropScenes(nib.load(os.path.join(os.path.join(folder_path,i),'Structure.nii')).get_fdata())
      ct = cropScenes(nib.load(os.path.join(os.path.join(folder_path,i),'CT.nii')).get_fdata())
      ctAffine = nib.load(os.path.join(os.path.join(folder_path,i),'CT.nii')).affine
      II = np.where(rs == 1)[0]
      JJ = np.where(rs == 1)[1]
      ZZ = np.where(rs == 1)[2]
      prostateMeanVal = np.mean(ct[II,JJ,ZZ])
      for x in range(len(II)):
        if ct[II[x],JJ[x],ZZ[x]] > 3000:
          ct[II[x],JJ[x],ZZ[x]] = prostateMeanVal
          ct[II[x]-5:II[x]+5,JJ[x]-5:JJ[x]+5,ZZ[x]] = neighbourMatrix(ct[II[x]-5:II[x]+5,JJ[x]-5:JJ[x]+5,ZZ[x]],prostateMeanVal)
      II2 = np.where(ct>2500)[0]
      JJ2 = np.where(ct>2500)[1]
      ZZ2 = np.where(ct>2500)[2]
      for x in range(len(II2)):
        ct[II2[x],JJ2[x],ZZ2[x]] = 2500

      niftiImg = nib.Nifti1Image(ct,ctAffine) 
      folderAddress = os.path.join(folder_path,i)
      nib.save(niftiImg,folderAddress+'\\CT_modified.nii')