%I need one giant script to manage all of the other guys. 

%AnalysisChoice = menu('Which part of the Analysis would you like to run?','Select and Prep T1 Images','Draw ROIs and Generate the Image Mask',
%Step Zero:Select and Prep Images. 
%Load/Prep GRE Images
    %Pre Contrast GRE Images
Getdir = uigetdir('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/','Choose Pre-Contrast T2-GRE images');
dicomdir_Pre = cd(Getdir);
dicomlist_Pre = dir('*');
for i = 3:numel(dicomlist_Pre)
   index = i-2;
   GREPix.Pre(index).Data = dicomread(dicomlist_Pre(i).name);
   GREPix.Pre(index).Name = dicomlist_Pre(i).name;
   GREPix.Pre(index).Info = dicominfo(dicomlist_Pre(i).name);
end

    %Post-Contrast GRE Images
Getdir2 = uigetdir('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/','Choose Post-Contrast T2-GRE images');
dicomdir_Post = cd(Getdir2);
dicomlist_Post = dir('*');
for i = 3:numel(dicomlist_Post)
   GREPix.Post(i-2).Data = dicomread(dicomlist_Post(i).name);
   GREPix.Post(i-2).Name = dicomlist_Post(i).name;
   GREPix.Post(i-2).Info = dicominfo(dicomlist_Post(i).name);
end

    %Pre-Contrast MSME Images
Getdir = uigetdir('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/','Choose Pre-Contrast T2-MSME images');
dicomdir_Pre = cd(Getdir);
dicomlist_Pre = dir('*');
for i = 3:numel(dicomlist_Pre)
   SEPix.Pre(i-2).Data = dicomread(dicomlist_Pre(i).name);
   SEPix.Pre(i-2).Name = dicomlist_Pre(i).name;
   SEPix.Pre(i-2).Info = dicominfo(dicomlist_Pre(i).name);
end

    %Post-Contrast MSME Images
Getdir2 = uigetdir('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/','Choose Post-Contrast T2-MSME images');
dicomdir_Post = cd(Getdir2);
dicomlist_Post = dir('*');
for i = 3:numel(dicomlist_Post)
   SEPix.Post(i-2).Data = dicomread(dicomlist_Post(i).name);
   SEPix.Post(i-2).Name = dicomlist_Post(i).name;
   SEPix.Post(i-2).Info = dicominfo(dicomlist_Post(i).name);
end
SEPix; GREPix;
[mySE,myGRE] = PDAC_Data(SEPix,GREPix);
%[m,k,n] = size(Analysis.deltaR2Star);

myDate = input('Scan Date?(YY_MM_DD)','s');
LosQ = input('L(osartan) or C(ontrol)?','s');

bI_init(1).Data = 0;
%SE Pre Analysis
[myFitVals.T2.Pre,bI] = PDAC_chooseROIs(SEPix.Pre,'SE','Pre',myDate,LosQ,bI_init);
delete('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectTemp');
delete('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectLoc');

%SE Post Analysis
[myFitVals.T2.Post,bITPost] = PDAC_chooseROIs(SEPix.Post,'SE','Post',myDate,LosQ,bI);
delete('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectTemp');
delete('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectLoc');

%GRE Pre Analysis
[myFitVals.T2Star.Pre,bITStarPre] = PDAC_chooseROIs(GREPix.Pre,'GR','Pre',myDate,LosQ,bI);
delete('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectTemp');
delete('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectLoc');

%GRE Post Analysis
[myFitVals.T2Star.Post,bITStarPost] = PDAC_chooseROIs(GREPix.Post,'GR','Post',myDate,LosQ,bI);
delete('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectTemp');
delete('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectLoc');


%figure;image(VSI(:,:,13))


%High-Res T2 Images

%Getdir3 = uigetdir('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/','Choose High-Res T2 images');
%dicomdir_HRT2 = cd(Getdir3);
%dicomlist_HRT2 = dir('*');
%for i = 3:numel(dicomlist_HRT2)
%   HRT2(i-2).Data = dicomread(dicomlist_HRT2(i).name);
%   HRT2(i-2).Name = dicomlist_HRT2(i).name;
%   HRT2(i-2).Info = dicominfo(dicomlist_HRT2(i).name);
%end

%ImgBrowOutput = ImageBrowser_Mod(HRT2);
%SliceSelectData = '/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectTemp';
%SliceSelectLoc = '/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectLoc';

%[Analysis] = VVF_Calc(SliceSelectData,SliceSelectLoc,Analysis);

%FinalImageDisplay(SliceSelectData,SliceSelectLoc,Analysis);


%figure;image(HRT2(13).Data)


    %DTI Images
%Getdir = uigetdir('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/','Choose DTI images');
%dicomdir_Pre = cd(Getdir);
%dicomlist_Pre = dir('*');
%for i = 3:numel(dicomlist_Pre)
%   DTIPix.Pre(i-2).Data = dicomread(dicomlist_Pre(i).name);
%   DTIPix.Pre(i-2).Name = dicomlist_Pre(i).name;
%   DTIPix.Pre(i-2).Info = dicominfo(dicomlist_Pre(i).name);
%end

