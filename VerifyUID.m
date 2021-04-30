function [RS,RD] = VerifyUID(RSList,RDList)

%Report Findings 
disp(['>>> Found ',num2str(length(RSList)),' structure sets'])
disp(['>>> Found ',num2str(length(RDList)),' dose maps'])
disp(['>>> RTSTRUCTURE INFORMATION'])
disp(' ')

warning('error', 'images:dicominfo:fileVRDoesNotMatchDictionary')

[RDUIDList] = GetRDFrameUID(RDList);

for i=1:length(RSList)
    [Info] = readDCM(RSList(i).FullDir);
    disp('****************************')
    fprintf(2,'** RS %d Contains following Structures:\n',i)
    GetSturctures(Info)
    disp(['    Frame Of ReferenceUID: "',Info.ReferencedFrameOfReferenceSequence.Item_1.FrameOfReferenceUID,'"'])
    Check = 0;
    for j=1:length(RDUIDList)
        if strcmp(RDUIDList{j},Info.ReferencedFrameOfReferenceSequence.Item_1.FrameOfReferenceUID)
            disp(['        ','RS ',num2str(i),' corresponds with RD ',num2str(j)])
            RDinfo = dicominfo(RDList(j).FullDir);
            disp(['            ','Dose Unit: ',RDinfo.DoseUnits])
            disp(['            ','Number of Frames: ',num2str(RDinfo.NumberOfFrames)])
            disp(['            ','Size: ',num2str(RDinfo.Rows),'x',num2str(RDinfo.Columns)])
            Check = 1;
        end
        if Check == 0
            disp(['        ','RS ',num2str(i),' corresponds with none of RD files'])
        end
    end
end

disp('*************************')
RSinput = input('Input desired RT Struct file index: \n');
RDinput = input('Input desired RT Dose file index: ');

RS = readDCM(RSList(RSinput).FullDir);
RD = readDCM(RDList(RDinput).FullDir);

end

function GetSturctures(info)
for j=1:length(fieldnames(info.ROIContourSequence))
    disp(['        ',num2str(j),') ',eval(['info.StructureSetROISequence.Item_',num2str(j),'.ROIName'])])
end
end

function [RDUIDList] = GetRDFrameUID(RDList)

for l=1:length(RDList)
   RDUIDList{l} = dicominfo(RDList(l).FullDir).FrameOfReferenceUID; 
end

end

function [Info] = readDCM(name)
try
    Info = dicominfo(name);
catch
    Info = dicominfo(name,'UseVRHeuristic',false);
end
end