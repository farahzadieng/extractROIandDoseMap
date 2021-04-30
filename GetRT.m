function [CTList,RSList,RDList] = GetRT(dicomlist1)
warning('off')

n1 = 1; n2 = 1; n3 = 1;
pBar = waitbar(0,'Scanning DICOM directory ...');
    for i=1:length(dicomlist1)
        pCount = i / length(dicomlist1);
        waitbar(pCount,pBar,'Scanning DICOM directory ...');
        if dicomlist1(i).bytes > 0
            try 
                modalityString = dicominfo(dicomlist1(i).FullDir).Modality;
            catch 
                disp(['Modality for file ',num2str(i),' has problems'])
            end
            if modalityString == "CT"
                CTList(n1) = dicomlist1(i);
                n1 = n1+1;
            elseif modalityString == "RTSTRUCT"
                RSList(n2) = dicomlist1(i); 
                n2 = n2+1;
            elseif modalityString == "RTDOSE"
                RDList(n3) = dicomlist1(i);
                n3=n3+1;
            end
        end
    end
    close(pBar)

end



