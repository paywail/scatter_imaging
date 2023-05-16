function zxg = zixiangguan(input)

I1 = input;
I1 = I1(:,:,1);
colormap(gray(255));
axis off
FI1 = fft2(I1);
max1 = max(FI1);
max2 = max(max1);
scale = 1.0/max2;
FI1 = FI1.*scale;
I2 = I1; % 输入图像2，输入相同的图像
I2 = I2(:,:,1);
colormap(gray(255));
FI2 = fft2(I2);
max1 = max(FI2);
max2 = max(max1);
scale = 1.0/max2;
FI2 = FI2.*scale;
% 进行相关性的计算
FPR = FI1.*conj(FI2); 
PR = ifft2(FPR);
PR = fftshift(PR);
max1 = max(PR);
max2 = max(max1);
scale = 1.0/max2;
PR = PR.*scale;
PR1 = PR;
m = min(PR1);
m = min(m); % 找到矩阵最小值,
PR2 = PR1 - m;
m1 = max(PR2);
m1 = max(m1); % 找到矩阵的最大值
PR3 = PR2 / m1; 
zxg = PR3;
end