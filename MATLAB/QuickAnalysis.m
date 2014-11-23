function [Analysis] = QuickAnalysis(HRT2,Analysis)

ImgBrowOutput = ImageBrowser_Mod(HRT2);
SliceSelectData = '/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectTemp';
SliceSelectLoc = '/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectLoc';
csvread(SliceSelectLoc)

[Analysis] = VVF_Calc(SliceSelectData,SliceSelectLoc,Analysis);

FinalImageDisplay(SliceSelectData,SliceSelectLoc,Analysis);
end
