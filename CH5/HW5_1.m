clc;clear;
%% read 5.25
fig = double(rgb2gray(imread('Fig5.25.jpg')))/255;
[H_1,W_1] = size(fig);
F_1 = fft2(center_transform(fig));
%% inverse filter
o = 5/6;
f = filter_H1(H_1,W_1,0.0025,o);
butter = butterworth_lowpass_filter(H_1,W_1,30,10);
res = (F_1./f);
res_filter = (F_1./f).*butter;
res2 = real(ifft2(res));
res_filter2 = real(ifft2(res_filter));
res_fig = center_transform(res2);
lpf_fig = center_transform(res_filter2);
lpf_fig2 = center_transform(real(ifft2(res_filter)));
lpf_fig(lpf_fig>1)=1;
lpf_fig(lpf_fig<0)=0;
res_fig(res_fig>1)=1;
res_fig(res_fig<0)=0;
r=double(lpf_fig);
g=double(lpf_fig);
b=double(lpf_fig);
rgb=cat(3,r,g,b);
figure(1)
imshow(fig, []);
figure(2)
imshow(rgb,[]);
imwrite(rgb, '5.25_lpf.png');
figure(3)
imshow(res_fig,[]);
imwrite(res_fig, '5.25_nolpf.png');


%% wiener filter
f2 = filter_H1(H_1,W_1,0.0025,o);
F_wiener = fft2(center_transform(fig));
wiener_restored = center_transform(real(ifft2(wiener_filter1(0.0025, F_1, f2) .* F_wiener)));
wiener_restored(wiener_restored>1)=1;
wiener_restored(wiener_restored<0)=0;
r_wiener=double(wiener_restored);
g_wiener=double(wiener_restored);
b_wiener=double(wiener_restored);
rgb_wiener=cat(3,r_wiener,g_wiener,b_wiener);

figure(4)
imshow(rgb_wiener, []);
imwrite(rgb_wiener, '5.25_wiener.png');
%% read the book cover picture
fig_original = double(imread('book-cover-blurred.tif')) / 255;
[H, W] =size(fig_original);
F = fft2(center_transform(fig_original));
%% inverse filter
h = filter_H(H, W, 0.1, 0.1, 1);
inverse_restored = center_transform(real(ifft2(F ./ h)));
figure(5)
imshow(inverse_restored, []);
imwrite(inverse_restored, 'book_cover_inverse.png');
%% wiener filter
noise = gaussian_noise(H, W, sqrt(1), 0) / 255;
blurred_noisy_image = fig_original + noise;
F_blurred_noisy = fft2(center_transform(blurred_noisy_image));
blurred_noisy_restored = center_transform(real(ifft2(wiener_filter(noise, F, h) .* F_blurred_noisy)));
figure(6)
imshow(blurred_noisy_restored, []);
imwrite(blurred_noisy_restored, 'book_cover_wiener.png');
