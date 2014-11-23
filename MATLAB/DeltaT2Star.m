function  DeltaT2Star(PixDataPre,PixDataPost)

%Get Pre-Contrast Dicom Images and Load Pixel Data
%Getdir = uigetdir('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/','Choose Pre-Contrast T2-GRE images');
%dicomdir_Pre = cd(Getdir);
%dicomlist_Pre = dir('*');
%for i = 3:numel(dicomlist_Pre)
%   PixDataPre(i-2).Data = dicomread(dicomlist_Pre(i).name);
%   PixDataPre(i).Name = dicomlist_Pre(i).name;
   %figure; imshow(PixData(i).Data)
    %metadata(i) = dicominfo(dicomlist(i).name);
%end

%Get Post-Contrast Dicom Images and Load Pixel Data
%Getdir2 = uigetdir('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/','Choose Post-Contrast T2-GRE images');
%dicomdir_Post = cd(Getdir2);
%dicomlist_Post = dir('*');
%for i = 3:numel(dicomlist_Post)
%   PixDataPost(i-2).Data = dicomread(dicomlist_Post(i).name);
%   PixDataPost(i).Name = dicomlist_Post(i).name;
   %figure; imshow(PixData(i).Data)
    %metadata(i) = dicominfo(dicomlist(i).name);
%end

%For each image in the Pre set, ratio each pixel in cooresponding image in
%the Post set

for L = 1:(numel(PixDataPre)-2)
    DeltaT2(L).Data=(PixDataPre(L).Data)./(PixDataPost(L).Data);
    if min(PixDataPre(L).Data)==max(PixDataPre(L).Data)
        sprintf ('The last valid image is Slice # %d.',L)
    else
        DeltaT2IM(L).Data=mat2gray(DeltaT2(L).Data);
    end
end

ImageBrowser(DeltaT2IM)