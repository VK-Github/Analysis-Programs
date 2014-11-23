function [myROI1,bI1] = PDAC_meanAnalysis(ImgData)

figure;image(ImgData,'CDatamapping','scaled');colormap('gray')
myH1 = imfreehand();
bI1 = myH1.createMask();
myROI1 = bI1.*ImgData;
size(myROI1)
figure;image(myROI1,'CDatamapping','scaled')
%figure;image((~isnan(myROI1)),'CDatamapping','scaled')
ROIinds = find(~isnan(myROI1));
newROI = myROI1(ROIinds);



%meanOUT.myisnan.ONE = mean(~isnan(myROI1(:)));
%meanOUT.myisnan.TWO = [mean(~isnan(myROI1(:,1):myROI1(:,64))),mean(~isnan(myROI1(:,65):myROI1(:,128)))];
%meanOUT.myfind.ONE =  mean(myv(:));
%meanOUT.myfind.TWO = [mean(myv(1):v(j/2)),mean(myv((j/2)+1):myv(j))];

end