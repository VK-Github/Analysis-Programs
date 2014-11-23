function [T2Starmaps] = T2Star

%Get T2 Dicom Images and Load Pixel Data
dicomdir = cd(uigetdir);
dicomlist = dir('*');

for i = 3:numel(dicomlist)
   PixData(i-2).Data = dicomread(dicomlist(i).name);
   PixData(i).Name = dicomlist(i).name;
   %figure; imshow(PixData(i).Data)
    %metadata(i) = dicominfo(dicomlist(i).name);
end

%Get T1 Dicom Images and Display Image

%Draw ROI to select Tumor Region on T1-Post Contrast Image

%Super impose Tumor ROI onto T2 data.Note: Set of 4 images = same slice @ different TEs

%Plot data for each pixel within each ROI @ every TE. 

%S(GRE) = M0e^(-Te/T2*)

%delta(T2*) = pre(Tex)/post(Tex)

kmax = floor(numel(PixData)/4)-1;

%[Estimates.n,Model.n] = fitcurvedemo(n,PixVal);

for k = 0:kmax
    for j = 1:128
        for m = 1:128
            for n = 1:4
               
            end
        end
    end
end
               


 
%Best fit monoexponential.

%Plot image where pixel value == best fit exponent value. This is the
%T2*map






