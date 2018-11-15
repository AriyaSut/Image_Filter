clear
clc
    %up load picture
picColor = imread('pic.jpg');

    %change to black&white color
pic = rgb2gray(picColor);

    %pic size
pix1 = size(pic,1);
pix2 = size(pic,2);

    %add picture frame value to be 0
newMetrix = zeros(pix1+4,pix2+4);
newMetrix(3:pix1+2,3:pix2+2) = pic;

    %defind filter as 5x5matrix 
boxFilter = [1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1]; %Box filter
gaussFilter = [0 1 2 1 0; 1 3 5 3 1; 2 5 9 5 2;1 3 5 3 1; 0 1 2 1 0]; %Gauss filter
laplaceFilter = [0 0 -1 0 0; 0 -1 -2 -1 0; -1 -2 16 -2 -1; 0 -1 -2 -1 0; 0 0 -1 0 0]; %Laplace or Maxican hat filter

    %find new pixel value
boxImage = zeros(pix1,pix2);
gaussImage = zeros(pix1,pix2);
laplaceImage = zeros(pix1,pix2);
for u=3:pix1+2
     for v=3:pix2+2
         for x=u-2:u+2
             for y=v-2:v+2
                 boxImage(u-2,v-2) = boxImage(u-2,v-2)+newMetrix(x,y)*boxFilter((x-u)+3,(y-v)+3);
                 gaussImage(u-2,v-2) = gaussImage(u-2,v-2)+newMetrix(x,y)*gaussFilter((x-u)+3,(y-v)+3);
                 laplaceImage(u-2,v-2) = laplaceImage(u-2,v-2)+newMetrix(x,y)*laplaceFilter((x-u)+3,(y-v)+3);
             end
         end
     end 
end
boxImage = uint8(boxImage./25);
gaussImage = uint8(gaussImage./57);
laplaceImage = uint8(laplaceImage);

subplot(1,4,1); imshow(pic, 'InitialMagnification', 'fit'); title('Original image')
subplot(1,4,2); imshow(boxImage, 'InitialMagnification', 'fit'); title('Box filter')
subplot(1,4,3); imshow(gaussImage, 'InitialMagnification', 'fit'); title('Gauss filter')
subplot(1,4,4); imshow(laplaceImage, 'InitialMagnification', 'fit'); title('laplace filter')
