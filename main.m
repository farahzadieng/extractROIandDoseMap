%% main application 
clear; close all 

CurrentAddress = pwd;
% addpath(CurrentAddress) 

%% Get DICOMLIST
[dicomlist] = GetDicomList(CurrentAddress);

[CTList,RSList,RDList] = GetRT(dicomlist);

%% Get Lists 
[RS,RD] = VerifyUID(RSList,RDList);
[CT] = GetCTImage(CTList,RS);
[MR_T1,MR_T1_info,MR_T2,MR_T2_info] = GetMRs(dicomlist);

%% MASK DATA
[CT_Image,CT_Header,MaskData,ROIList] = MaskStructures(CT,RS);

%% Regist DOSE
[RD_Image] = RegistRD(RD,CT_Header,CT_Image);

%% Structure Image 
[Struct_Image] = RSImage(CT_Image,MaskData,ROIList);

writeNiftiFiles(CT_Image,CT_Header,MR_T1,MR_T2,MR_T1_info,MR_T2_info,RD_Image,Struct_Image)
