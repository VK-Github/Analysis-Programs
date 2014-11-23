function [FitVals,binImg,ROISelect] = PDAC_chooseROIs(PixData,setdata,ContrastQ,myDate,LosQ,mybinImg)

%PixData: GREPix or SEPix=> Pre/Post.Data/Info/Name

%Set appropriate image number and TEs for SE or GRE

if setdata == 'SE'
    a = 126;
    b = 6;
    TEs = [10 20 30 40 50 60];
    FileAddT = 'T2';
    FileAddR = 'R2';
elseif setdata == 'GR'
    a = 84;
    b = 4;
    TEs = [3.525 8.525 13.525 18.525];
    FileAddT = 'T2Star';
    FileAddR = 'R2Star';
end


setinds = [1:b:a];
myFile = '/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/AnalyzedData/';


%Organize data,display as browser, choose slice for tumor.
for n = 1:21
    ChoosePixData(n).Data = PixData(setinds(n)).Data;
end

ImgBrowOutputROIs = ImageBrowser_Mod(ChoosePixData);

ChooseLoc = csvread('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectLoc')

%Set three slices for analysis, 2 flanking the chosen slice
MyROISliceLocs =[ChooseLoc-1,ChooseLoc,ChooseLoc+1];
myK = b-1;
%Organize Data into a structure for easy access,Slice:1-3 and Echoes: 4/6
for  D = 1:3
    for K = 0: myK
        SetSlice = b*MyROISliceLocs(D);
        EchoInd = b-K;
        DataSelect.Slice(D).EchoImage(EchoInd).Data = PixData(SetSlice-K).Data;
        DataSelect.Slice(D).EchoTime(K+1) = TEs(K+1);
    end
end

close gcf

%Draw ROI on Each Slice, at EchoImage(1)
%get ROI data for each slice from all EchoImages
if mybinImg(1).Data == 0
    for V = 1:3
        figure;image(DataSelect.Slice(V).EchoImage(3).Data,'CDatamapping','scaled');colormap('gray');
        myH1 = imfreehand();
        bI_TOTAL = myH1.createMask();
        myH2 = imfreehand();
        bI_CENTER = myH2.createMask();
        binImg(V).Data = bI_TOTAL;%-bI_CENTER;
        saveas(gcf,strcat(myFile,myDate,'_',LosQ,'_',ContrastQ,'_','Slice',num2str(V),'_',setdata),'jpg');
    end
else
    binImg = mybinImg;
end

for V = 1:3
     for DK = 1:b
         ROISelect.Slice(V).EchoROI(DK).DataRaw = (binImg(V).Data).*double(DataSelect.Slice(V).EchoImage(DK).Data);
     end
     OverlaynDisplay(DataSelect.Slice(V).EchoImage(3).Data,DataSelect.Slice(V).EchoImage(3).Data,binImg(V).Data);
end
 


%Divs = Divs+1;
%Grab non-zero values, determine length of final Data
for V = 1:3
     for DK = 1:b
         [r,c,ROISelect.Slice(V).EchoROI(DK).Data] = find(ROISelect.Slice(V).EchoROI(DK).DataRaw);
         mylen = length(ROISelect.Slice(V).EchoROI(DK).Data);
         %Divs = mylen
     end
end

%Determine Divisions of ROI: 1-128^2
Divs = input('How many divisions would you like?');

%Determine length of each division

DivSize = mylen/Divs;
DivIt = 1:DivSize:mylen; 

%Split Data into Divsions
for V = 1:3
     for DK = 1:b
         for L = 1:(length(DivIt))
             if L < length(DivIt)
                 c = round(DivIt(L));
                 d = floor(DivIt(L+1));
                 MeanSelect.Slice(V).EchoROI(DK).Div(L).DataRaw = ROISelect.Slice(V).EchoROI(DK).Data(c:d);
                 MeanSelect.Slice(V).Div(L).EchoROI(DK).Means = mean(MeanSelect.Slice(V).EchoROI(DK).Div(L).DataRaw);
             end
         end
     end
end


%Do T2 analysis on each division
for V = 1:3
    for L = 1:(length(DivIt)-1)
        myData=[];
        for DK = 1:b
            myData = [myData, MeanSelect.Slice(V).Div(L).EchoROI(DK).Means];
        end
        SliceLoc = num2str(V);
        sizeTE = size(TEs);
        sizemyData = size(myData);
        %Actual Calcs
         [fitresult, gof] = createFit(TEs,myData);
         saveas(gcf,strcat(myFile,myDate,'_',LosQ,'_',ContrastQ,'_','Slice',num2str(V),'_',setdata,'Plot'),'jpg')
         close gcf
         CVals = coeffvalues(fitresult);
         M0 = CVals(1);
         neginvT2 = CVals(2);
         FitVals.T.Slice(V).Div(L).Data = -1/neginvT2;
         FitVals.R.Slice(V).Div(L).Data = -(neginvT2);
         FitVals.M0.Slice(V).Div(L).Data = M0;
         FitVals.GoF.Slice(V).Div(L).Data = gof;
         myFileCompT = strcat(myFile,myDate,'_',LosQ,'_',ContrastQ,'_','Slice',SliceLoc,'_',FileAddT);
         csvwrite(myFileCompT,FitVals.T.Slice(V).Div(L).Data);
         myFileCompR = strcat(myFile,myDate,'_',LosQ,'_',ContrastQ,'_','Slice',SliceLoc,'_',FileAddR);
         csvwrite(myFileCompR,FitVals.R.Slice(V).Div(L).Data);
         %[FR.Slice(V).Div(L),gof.Slice(V).Div(L),T2.Reg.Slice(V).Div(L)] = myT2fits(TEs,myData);
         
    end
end
        
clear ChooseLoc;

    function OverlaynDisplay(BaseImgData,OverlayImg,binaryImage)
        cmap = [gray(128);jet(128)];
        figure;
        h(1) = image(BaseImgData,'CDataMapping','scaled');hold on;
        cdatah1 = get(h(1),'CData');
        h(2) = image(OverlayImg);hold off
        cdatah2 = get(h(2),'CData');
        set(h(2),'AlphaData',binaryImage)
        set(h(2),'CData',cdatah1+max(cdatah1(:)))
        colormap(cmap)
        set(h(2),'CDataMapping','scaled')
    end

end

        
