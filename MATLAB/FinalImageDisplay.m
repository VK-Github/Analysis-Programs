function [binaryImage,BaseImgData,savestring,HistData,OverlayImg] = FinalImageDisplay(SliceSelectData,SliceSelectLoc,Analysis)

%Import,Load and Prep variables
sprintf('We are ready for final ROIs and analysis!')
BaseImgData = load(SliceSelectData);
SliceSelect = load(SliceSelectLoc);
cmap = [gray(128);jet(128)];
myfigurechoice = 1;
dirname = uigetdir('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/','Where would you like to save Final Images and Figures?');
%OverlayImg = Analysis.VSI(SliceSelect).Maps;
%figure;image(Analysis.VSI(SliceSelect).Maps,'CDataMapping','scaled')
%figure;image(OverlayImg,'CDataMapping','scaled')
%savestring = 'T2';
%Display SliceSelectData in grayscale, Draw ROI, Generate Mask
   
figure;colormap(gray)
j = image(BaseImgData,'CDataMapping','scaled');hold on;
hFH = imfreehand();
binaryImage = hFH.createMask();
cdatah1 = get(j,'CData');
close gcf

while myfigurechoice == 1
    [OverlayImg,savestring] = ChooseOverlay(Analysis,SliceSelect);
    OverlaynDisplay(BaseImgData,OverlayImg,binaryImage,dirname,savestring);
    hist(OverlayImg.*double(binaryImage));
    myfigurechoice = menu('Would you Like to make another figure?','Yes','No');
end


%Select Overlay Image
    function [OverlayImg,savestring] = ChooseOverlay(Analysis,SliceSelect)
        fields = fieldnames(Analysis);
        choice = menu('Select Overlay Image',fields(1),fields(2),fields(3),fields(4),fields(5),fields(6),fields(7),fields(8),fields(9),fields(10));

        if choice == 1
            OverlayImg = Analysis.T2.Post(SliceSelect).Maps(:,:,2);
            savestring = 'T2';
        elseif choice == 2
            OverlayImg = Analysis.T2Star.Post(SliceSelect).Maps(:,:,2);
            savestring = 'T2Star';
        elseif choice == 3
            OverlayImg = Analysis.deltaT2(SliceSelect).Maps;
            savestring = 'DeltaT2';
        elseif choice == 4
            OverlayImg = Analysis.deltaR2(SliceSelect).Maps;
            savestring = 'DeltaR2';
        elseif choice == 5
            OverlayImg = Analysis.deltaT2Star(SliceSelect).Maps;
            savestring = 'DeltaT2Star';
        elseif choice == 6
            OverlayImg = Analysis.deltaR2Star(SliceSelect).Maps;
           savestring = 'DeltaR2Star';
        elseif choice == 7
            OverlayImg = Analysis.VSI(SliceSelect).Maps;
            savestring = 'VSI';
        elseif choice == 8
            OverlayImg = Analysis.VSI32(SliceSelect).Maps;
            savestring = 'VSI32';
        elseif choice == 9
            OverlayImg = Analysis.VVF(SliceSelect).Maps;
            savestring = 'VVF';
        elseif choice == 10
            OverlayImg = Analysis.VDI(SliceSelect).Maps;
            savestring = 'VDI';
        end
    end


%Use ROI to overlay Tumor Region from
%Maps(T2,T2Star,DeltaT2,DeltaT2Star,R2,R2Star,DeltaR2,DeltaR2Star,VSI)
    function [HistData] = OverlaynDisplay(BaseImgData,OverlayImg,binaryImage,dirname,savestring)
        figure;
        h(1) = image(BaseImgData,'CDataMapping','scaled');hold on;
        h(2) = image(OverlayImg);hold off
        cdatah2 = get(h(2),'CData');
        set(h(2),'AlphaData',binaryImage)
        set(h(2),'CData',cdatah1+max(cdatah1(:)))
        colormap(cmap)
        set(h(2),'CDataMapping','scaled')
        saveinfo = strcat(dirname,'/',savestring,'Figure.tiff')
        saveas(gcf,saveinfo);
        title('savestring');
        Hist_Data_Prep = OverlayImg.*double(binaryImage);
        Hist_Data_Prep1 = Hist_Data_Prep(~isnan(Hist_Data_Prep));
        Hist_Data = Hist_Data_Prep1(Hist_Data_Prep1~=0);
        csvwrite(strcat(dirname,'/',savestring,'.xls'),Hist_Data);
        figure;hist(Hist_Data);title(strcat(savestring,'Histogram'));
    end

end






