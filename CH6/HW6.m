clc;clear;
%% lena
img = imread('lenna-RGB.tif');


for z = 1:3
    C = double(img(:,:,z));
    for i = 1:size(C,1)-2
        for j = 1:size(C,2)-2
            x = ((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
            y = ((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
        
            img(i,j,z) = sqrt(x.^2+y.^2);
        
        end
    end
end

img_res = img(:,:,1) + img(:,:,2)+img(:,:,3);
figure(1)
imshow(img);title('Sobel gradient RGB');
figure(2)
imshow(img(:,:,1));title('Sobel gradient R');
figure(3)
imshow(img(:,:,2));title('Sobel gradient G');
figure(4)
imshow(img(:,:,3));title('Sobel gradient B');
figure(5)
imshow(img_res);title('Sobel gradient R+G+B');

%% fruit
[img_fruit,map] = imread('Visual resolution.gif');
img_fruit = ind2rgb(img_fruit, map);
for z = 1:3
    C = double(img_fruit(:,:,z));
    for i = 1:size(C,1)-2
        for j = 1:size(C,2)-2
            x = ((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
            y = ((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
            img_fruit(i,j,z) = sqrt(x.^2+y.^2);
        end
    end
end

img_res_fruit = img_fruit(:,:,1) + img_fruit(:,:,2)+img_fruit(:,:,3);
figure(6)
imshow(img_fruit);title('Sobel gradient RGB');
figure(7)
imshow(img_fruit(:,:,1));title('Sobel gradient R');
figure(8)
imshow(img_fruit(:,:,2));title('Sobel gradient G');
figure(9)
imshow(img_fruit(:,:,3));title('Sobel gradient B');
figure(10)
imshow(img_res_fruit);title('Sobel gradient R+G+B');

