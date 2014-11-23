function [Output] = ImageBrowser_Mod(mystruct)
    %# read all frames at once
    numImgs = numel(mystruct);
  

    %# design GUI
    numThumbs = 5;
    mx = numImgs-numThumbs+1;
    hFig = figure('Menubar','none');
    hPanel = uipanel('Position',[0 0.04 1 0.16], 'Parent',hFig);
    uicontrol('Style','slider', 'Parent',hFig, ...
        'Callback',@slider_callback, ...
        'Units','normalized', 'Position',[0 0 1 0.04], ...
        'Value',1, 'Min',1, 'Max',mx, 'SliderStep',[1 10]./mx);

    %# main axis, and show first frame
    hAx = axes('Position',[0 0.2 1 0.8], 'Parent',hFig);
    hMainImg = imshow(mystruct(1).Data, 'Parent',hAx);
    
    
    %# thumbnail axes
    hThumImg = zeros(numThumbs,1);
    for i=1:numThumbs
        %# create axis, show frame, hookup click callback
        hAx = axes('Parent',hPanel, ...
            'Position',[(i-1)/numThumbs 0 1/numThumbs 1]);
        hThumImg(i) = imshow(mystruct(i).Data, 'Parent',hAx);
        set(hThumImg(i), 'ButtonDownFcn',@click_callback_4output)
        axis(hAx, 'normal')
    end
 
    %# callback functions
    function slider_callback(src,~)
        val = round(get(src,'Value'));  %# starting index
        %# update the thumbnails
        for k=1:numel(hThumImg)
            set(hThumImg(k), 'CData',mystruct(k+val-1).Data)
            drawnow
            File1 = '/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectLoc';
            csvwrite(File1,k+val-1,0);
        end
    end
    
    function click_callback(src,~)
        %# update the main image
        set(hMainImg, 'CData',get(src,'CData'));
        drawnow
    end
   

    function click_callback_4output(src,~)
        %# update the main image
        Selection = get(gcf, 'SelectionType');
           if strcmp(Selection,'normal')== 1% Click left mouse button
              set(hMainImg, 'CData',get(src,'CData'));
              drawnow
           elseif strcmp(Selection,'alt')== 1    % Control - click left mouse button or click right mouse button
              set(hMainImg, 'CData',get(src,'CData'));
              drawnow
              temp = get(src,'CData');
              %FinImgtemp = mat2gray(temp);
              %figure;imshow(FinImgtemp)
              Val = GrabmyDataNested(temp);
          end   
    end
 
    function [Val] = GrabmyDataNested(inVal)
        %figure;imshow(inVal)
        currfig = gcf;
        choice = menu('Would you like to continue analysis with this image?','Yes','No')
        if choice == 1
            sprintf('%s','Yay you like it :), Lets Move On')
            File = '/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/Analysis Programs/MATLAB/TempDataFiles/ImageSelectTemp';
            Val = inVal;
            csvwrite(File,inVal);
        elseif choice == 2
            sprintf('%s','Its ok if you dont like it. We can try again')
            Val = inVal;
            close currfig
        end
    end

  Output = menu('Are you done with ImageBrowser_Mod functionality?','Yes','No');
end
