function writeNiftiFiles(CT_Image,CT_Header,MR_T1,MR_T2,MR_T1_info,MR_T2_info,RD_Image,Struct_Image)

OutputAddress = input('Input folder address to store Output files (Press ENTER to set Default Dir. = D:\\Output)\n','s');
if isempty(OutputAddress)
    OutputAddress = 'D:\Output';
    mkdir(OutputAddress)
end
if ~isfolder(OutputAddress)
    mkdir(OutputAddress)
    cd(OutputAddress)
else
    cd(OutputAddress)
end


saveCT(CT_Image,CT_Header.SliceSpacing,CT_Header.PixelSpacing)
if ~isempty(MR_T1)
    saveMR(MR_T1,MR_T1_info,"MR_T1")
end
if ~isempty(MR_T2)
    saveMR(MR_T2,MR_T2_info,"MR_T2")
end
saveStruct(Struct_Image,CT_Header.SliceSpacing,CT_Header.PixelSpacing)
saveRD(RD_Image,CT_Header.SliceSpacing,CT_Header.PixelSpacing)

end

function saveCT(CTRefrenceImage,CTSliceSpacing,CTPixelSpacing)
	niftiwrite(CTRefrenceImage,'CT.nii')
	niiInfo = niftiinfo('CT.nii');
	niiInfo.PixelDimensions = [CTPixelSpacing(1) CTPixelSpacing(2) CTSliceSpacing];
	niftiwrite(CTRefrenceImage,'CT.nii',niiInfo)
end

function saveMR(MRRefrenceImage,MRinfo,filename)
	niftiwrite(MRRefrenceImage,filename)
	niiInfo = niftiinfo(filename);
	niiInfo.PixelDimensions = [MRinfo.PixelSpacing(1) MRinfo.PixelSpacing(2) MRinfo.SliceThickness];
	niftiwrite(MRRefrenceImage,filename,niiInfo)
end

function saveStruct(structuresMatrix,CTSliceSpacing,CTPixelSpacing)
	niftiwrite(structuresMatrix,'Structure.nii')
	niiInfo = niftiinfo('Structure.nii');
	niiInfo.PixelDimensions = [CTPixelSpacing(1) CTPixelSpacing(2) CTSliceSpacing];
	niftiwrite(structuresMatrix,'Structure.nii',niiInfo)
end

function saveRD(fixedRDImage,CTSliceSpacing,CTPixelSpacing)
	niftiwrite(fixedRDImage,'RD.nii')
	niiInfo = niftiinfo('RD.nii');
	niiInfo.PixelDimensions = [CTPixelSpacing(1) CTPixelSpacing(2) CTSliceSpacing];
	niftiwrite(fixedRDImage,'RD.nii',niiInfo)
end
