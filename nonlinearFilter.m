clear
clc
    %up load picture
picColor = imread('pic.jpg');

    %change to black&white color
pic = rgb2gray(picColor);

    %pic size
pix1 = size(pic,1);
pix2 = size(pic,2);

noiseImage = imnoise(pic,'salt & pepper',0.01); %add salt and pepper noise in the image 

weightMatrix = [1 2 1; 2 3 2; 1 2 1]; %use in Weight median filter

minImage = noiseImage;
maxImage = noiseImage;
medImage = noiseImage;
wmedImage = noiseImage;
for u=2:pix1-1
    for v=2:pix2-1
        count = 1;
        %Minimum filter:replace pixel with 255 value by smallest value in the 3x3 region
        if noiseImage(u,v)==255 
            minImage(u,v) = min(min(noiseImage(u-1:u+1,v-1:v+1)));
        end
        
        %Maximum filter:replace pixel with 0 value by maximum value in the 3x3 region
        if noiseImage(u,v)==0 
            maxImage(u,v) = max(max(noiseImage(u-1:u+1,v-1:v+1)));
        end
        
        %Median filter
        medImage(u,v) = median(median(noiseImage(u-1:u+1,v-1:v+1)));
        
        %Weight median filter
        for x=u-1:u+1
            for y=v-1:v+1 
                for i=1:weightMatrix(x-u+2,y-v+2)
                    rank(count) = noiseImage(x,y);
                    count = count+1;
                end
            end
        end 
        median(rank);
        wmedImage(u,v) = median(rank);
    end
end

subplot(1,5,1); imshow(noiseImage, 'InitialMagnification', 'fit'); title('Original image')
subplot(1,5,2); imshow(minImage, 'InitialMagnification', 'fit'); title('Minimum filter')
subplot(1,5,3); imshow(maxImage, 'InitialMagnification', 'fit'); title('Maximum filter')
subplot(1,5,4); imshow(medImage, 'InitialMagnification', 'fit'); title('Median filter')
subplot(1,5,5); imshow(wmedImage, 'InitialMagnification', 'fit'); title('Weight median filter')