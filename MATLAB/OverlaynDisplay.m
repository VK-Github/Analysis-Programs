function [cdatah1,cdatah2] = OverlaynDisplay(OverlayImg1,BaseImgData)%,dirname,savestring)
   
        GetdirT2 = uigetdir('/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/','Choose Pre-Contrast T2-GRE images');
        dicomdir_T2 = cd(GetdirT2);
        dicomlist_T2 = dir('*');
        for i = 3:numel(dicomlist_T2)
            index = i-2;
            T2Pix.Pre(index).Data = dicomread(dicomlist_T2(i).name);
            T2Pix.Pre(index).Name = dicomlist_T2(i).name;
            T2Pix.Pre(index).Info = dicominfo(dicomlist_T2(i).name);
        end
        cmap = [gray(128);jet(128);];
        %cmap2 = [gray(128);cool(128)];
        %BaseImgData = TMap.post;%abs(T2Pix.Pre(12).Data);
        figure;colormap(gray)
        j = image(BaseImgData,'CDataMapping','scaled');hold on;
        cdatah1 = get(j,'CData');
        hFH = imfreehand();
        binaryImage = hFH.createMask();
        %cdatah3 = get(j,'CData');
        close gcf
        %subplot(2,1,1)
        %mymin = min(double(OverlayImg1)); mymax = max(double(OverlayImg1));
        h(1) = image(BaseImgData,'CDataMapping','scaled');hold on;
        h(2) = image(OverlayImg1,'CDataMapping','scaled');hold off
        cdatah2 = get(h(2),'CData');
        set(h(2),'AlphaData',binaryImage)
        set(h(2),'CData',cdatah1+max(cdatah1(:)))
        colormap(cmap);colorbar;%caxis([10 10000]);
        set(h(2),'CDataMapping','scaled')
        %subplot(2,1,2)
        %h(3) = image(BaseImgData,'CDataMapping','scaled');hold on;
        %h(4) = image(OverlayImg2);hold off
        %cdatah3 = get(h(3),'CData');
        %set(h(4),'AlphaData',binaryImage)
        %set(h(4),'CData',(2*cdatah3+max(cdatah3(:))))
        %colormap(cmap)
        %set(h(4),'CDataMapping','scaled')
        %saveinfo = strcat(dirname,'/',savestring,'Figure.tiff')
        %saveas(gcf,saveinfo);
        %title('savestring');
        %Hist_Data_Prep = OverlayImg.*double(binaryImage);
        %Hist_Data_Prep1 = Hist_Data_Prep(~isnan(Hist_Data_Prep));
        %Hist_Data = Hist_Data_Prep1(Hist_Data_Prep1~=0);
        %csvwrite(strcat(dirname,'/',savestring,'.xls'),Hist_Data);
        %figure;hist(Hist_Data);title(strcat(savestring,'Histogram'));
    end