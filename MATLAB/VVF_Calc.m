function [Analysis,mean_deltaR2Star_Muscle,bIm,SliceSelect] = VVF_Calc(SliceSelectData,SliceSelectLoc,Analysis)

BID = load(SliceSelectData);
SliceSelect = load(SliceSelectLoc);
figure;colormap(gray)
sprintf('Lets Get VVF')
k(1) = image(BID,'CDataMapping','scaled');hold on;
hFH = imfreehand();
bIm = hFH.createMask();
k(2) = image(Analysis.deltaR2Star(SliceSelect).Maps,'CDataMapping','scaled');hold off
set(k(2),'AlphaData',bIm)
DRS_Muscle_PREP1 = (Analysis.deltaR2Star(SliceSelect).Maps).*double(bIm);
deltaR2Star_Muscle_PREP = ~isnan(DRS_Muscle_PREP1);
mean_deltaR2Star_Muscle = mean(deltaR2Star_Muscle_PREP(:));


for n = 1:numel(Analysis.deltaR2Star)
Analysis.VVF(n).Maps = 3*(Analysis.deltaR2Star(n).Maps/mean_deltaR2Star_Muscle);
end
%close all

end
