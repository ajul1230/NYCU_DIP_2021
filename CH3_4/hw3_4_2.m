clc; clear;
fig_original = double(imread('Bodybone.bmp'))/255 ;
sz = size(fig_original);

figure;
subplot(2, 4, 1);
imshow(fig_original);
imwrite(fig_original, 'origin.png');
laplace_result = zeros(sz);
for i=1:3
    laplace_result(:,:,i) = imgfilter2([-1 -1 -1; -1 8 -1; -1 -1 -1], fig_original(:,:,i),1);

end

subplot(2, 4, 2);
imshow(laplace_result);
imwrite(laplace_result, 'laplace_result.png');
%%
sharpened_laplace_result = fig_original + laplace_result;
subplot(2, 4, 3);
imshow(sharpened_laplace_result);
imwrite(sharpened_laplace_result, 'sharpened_laplace_result.png');
%%
sobel_grad = zeros(sz);
for i=1:3
    sobel_grad(:,:,i) = abs(imgfilter2([-1 -2 -1; 0 0 0; 1 2 1], fig_original(:,:,i),1)) + abs(imgfilter2([-1 0 1; -2 0 2; -1 0 1], fig_original(:,:,i),1));
end
subplot(2, 4, 4);
imshow(sobel_grad);
imwrite(sobel_grad, 'sobel_grad.png');
%%
smoothed_sobel_grad = zeros(sz);
for i=1:3
smoothed_sobel_grad(:,:,i) = imgfilter2(ones(5)/25, sobel_grad(:,:,i),2);
end
subplot(2, 4, 5);
imshow(smoothed_sobel_grad);
imwrite(smoothed_sobel_grad, 'smoothed_sobel_grad.png');
%%
product_laplace_sobel  = zeros(sz);
for i=1:3
product_laplace_sobel(:,:,i) = sharpened_laplace_result(:,:,i) .* smoothed_sobel_grad(:,:,i);
end
subplot(2, 4, 6);
imshow(product_laplace_sobel);
imwrite(product_laplace_sobel, 'product_laplace_sobel.png');

%%
sharpened_image  = zeros(sz);
for j=1:3
sharpened_image(:,:,j) = max(fig_original(:,:,j) + product_laplace_sobel(:,:,j), 0);
end
subplot(2, 4, 7);
imshow(sharpened_image);
imwrite(sharpened_image, 'sharpened_image.png');
%%
final_result  = zeros(sz);
for k=1:3
final_result(:,:,k) = power(sharpened_image(:,:,k), 0.5);
end
subplot(2, 4, 8);
imshow(final_result);
imwrite(final_result, 'final_result.png');
