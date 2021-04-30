function [strucMat] = RSImage(CTRefrenceImage,MaskData,ROIList)

printROIList(ROIList)
[ROI,ptvNumber] = GetROIInputs;
strucMat = zeros(size(CTRefrenceImage));

PTVdata = MaskData{ptvNumber};
for PTVindex=1:length(PTVdata)
        SliceofPTVdata = PTVdata{PTVindex};
        [I,J] = find(SliceofPTVdata == 1);
        if length(I)>0
            for i=1:length(I)
                strucMat(I(i),J(i),PTVindex) = 1;
            end
        end
end

for ROIindex=1:length(ROI)
    ROIdata = MaskData{ROI(ROIindex)};
    for k=1:size(strucMat,3)
        SliceofROIdata = ROIdata{k};

        [I,J] = find(SliceofROIdata == 1);
        if length(I)>0
            for i=1:length(I)
                if strucMat(I(i),J(i),k) == 1
                    strucMat(I(i),J(i),k) = ROIindex + 1.5;
                else 
                    strucMat(I(i),J(i),k) = ROIindex + 1;
                end
            end
        end
        clear SliceofROIdata
    end
    clear ROIdata
end




end

function [ROI,ptvNumber] = GetROIInputs()
    roiList = ["Bladder","Rectum","L Femur","R Femur"];
    ROI = zeros(size(roiList));
    for m=1:size(roiList,2)
        message = sprintf('Please Input ROI Number refered to %s :',roiList(m));
        ROI(m) = input([message,'\n']);      
    end
    ptvNumber = input('Please Enter ROI number refered to PTV\n');
end

function printROIList(s)
    disp('ROI numbers and names are stored as :')
    for i=1:size(s,1)
       fprintf('%d)\t%s\n',s{i,1},s{i,3}) 
    end
end