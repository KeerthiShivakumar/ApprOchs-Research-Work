clc; clear; close all;
 
img = imread('doggyy.jpg');
if size(img, 3) == 3
    img = rgb2gray(img);
end
img = uint8(img);
[m, n] = size(img);
 
gaussWeights = [1 2 1; 2 4 2; 1 2 1];
 
img_pad = padarray(double(img), [1 1], 'replicate');
exact_blur = zeros(m, n);
kernel = [1 2 1; 2 4 2; 1 2 1] / 16;
for i = 1:m
    for j = 1:n
        patch = img_pad(i:i+2, j:j+2);
        exact_blur(i,j) = sum(sum(kernel .* patch));
    end
end
exact_blur = uint8(exact_blur);
exact_crop = exact_blur(2:m-1, 2:n-1);
 
k_values = 1:8;
num_k    = length(k_values);
 
psnr_or  = zeros(1, num_k);
ssim_or  = zeros(1, num_k);
psnr_maj = zeros(1, num_k);
ssim_maj = zeros(1, num_k);
 
blur_or_store  = cell(1, num_k);
blur_maj_store = cell(1, num_k);
 
for ki = 1:num_k
    k = k_values(ki);
 
    blur_or  = zeros(m, n, 'uint8');
    blur_maj = zeros(m, n, 'uint8');
 
    for i = 2:m-1
        for j = 2:n-1
 
            sum_or  = uint32(0);
            sum_maj = uint32(0);
            carry   = uint32(0);
 
            for x = -1:1
                for y = -1:1
                    w        = gaussWeights(x+2, y+2);
                    pixel    = uint32(img(i+x, j+y));
                    weighted = uint32(w) * pixel;
 
                    sum_or           = Approchs_adder(sum_or, weighted, k, 16);
                    [sum_maj, carry] = Majority_adder(sum_maj, weighted, carry, k, 16);
                end
            end
 
            blur_or(i, j)  = uint8(min(double(sum_or)  / 16, 255));
            blur_maj(i, j) = uint8(min(double(sum_maj) / 16, 255));
        end
    end
 
    or_crop  = blur_or(2:m-1,  2:n-1);
    maj_crop = blur_maj(2:m-1, 2:n-1);
 
    psnr_or(ki)  = psnr(or_crop,  exact_crop);
    ssim_or(ki)  = ssim(or_crop,  exact_crop);
    psnr_maj(ki) = psnr(maj_crop, exact_crop);
    ssim_maj(ki) = ssim(maj_crop, exact_crop);
 
    blur_or_store{ki}  = blur_or;
    blur_maj_store{ki} = blur_maj;
end
 
fprintf('%-6s  %-14s  %-10s  %-14s  %-10s\n', ...
        'k','OR-PSNR(dB)','OR-SSIM','MAJ-PSNR(dB)','MAJ-SSIM');
fprintf('%s\n', repmat('-',1,60));
for ki = 1:num_k
    fprintf('k=%-4d  %-14.4f  %-10.4f  %-14.4f  %-10.4f\n', ...
            k_values(ki),psnr_or(ki),ssim_or(ki),psnr_maj(ki),ssim_maj(ki));
end
fprintf('%s\n', repmat('-',1,60));
 
fig1 = figure('Name','OR-Based Blur','NumberTitle','off', ...
              'Visible','on','Units','normalized','OuterPosition',[0 0 1 1]);
subplot(3,3,1); imshow(img);        title('Original');    drawnow;
subplot(3,3,2); imshow(exact_blur); title('Exact (k=0)'); drawnow;
for ki = 1:7
    subplot(3,3,ki+2);
    imshow(blur_or_store{ki});
    title(sprintf('OR k=%d\nPSNR=%.1fdB',k_values(ki),psnr_or(ki)),'FontSize',8);
    drawnow;
end
 
fig2 = figure('Name','Majority Gate Blur','NumberTitle','off', ...
              'Visible','on','Units','normalized','OuterPosition',[0 0 1 1]);
subplot(3,3,1); imshow(img);        title('Original');    drawnow;
subplot(3,3,2); imshow(exact_blur); title('Exact (k=0)'); drawnow;
for ki = 1:7
    subplot(3,3,ki+2);
    imshow(blur_maj_store{ki});
    title(sprintf('MAJ k=%d\nPSNR=%.1fdB',k_values(ki),psnr_maj(ki)),'FontSize',8);
    drawnow;
end