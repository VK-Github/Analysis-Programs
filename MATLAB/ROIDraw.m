function [message,binaryImage,xy] = ROIDraw(FigData)

%FigDatainit = csvread(FileLoc);
%FigData = mat2gray(FigDatainit);
figure;
FigDataDouble = double(FigData);
T1_Orig = imshow(mat2gray(FigDataDouble));
title('Enhanced T1 Image')
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
message = sprintf('Draw an ROI to select tumor. Click and hold to begin drawing.\nSimply lift the mouse button to finish');
uiwait(msgbox(message));
hFH = imfreehand();
% Create a binary image ("mask") from the ROI object.
binaryImage = hFH.createMask();
xy = hFH.getPosition;

im(~binaryImage) = NaN;
figure;imagesc(im)

% Convert the grayscale image to RGB using the jet colormap.
rgbImage = ind2rgb(FigData, jet(256));
% Scale and convert from double (in the 0-1 range) to uint8.
rgbImage = uint8(255*rgbImage);

% Extract the red, green, and blue channels from the color image.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);
% Create a new color channel images for the output.
outputImageR = FigData;
outputImageG = FigData;
outputImageB = FigData;
% Transfer the colored parts.
outputImageR(binaryImage) = redChannel(binaryImage);
outputImageG(binaryImage) = greenChannel(binaryImage);
outputImageB(binaryImage) = blueChannel(binaryImage);
% Convert into an RGB image
outputRGBImage = cat(3, outputImageR, outputImageG, outputImageB);
% Display the output RGB image.
figure;
h = imshow(outputRGBImage);
axis on;
title('Output RGB Image');

message = sprintf('Lets Continue with the Analysis');
uiwait(msgbox(message));