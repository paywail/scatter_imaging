%% object
clear
obj = [0,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,1;1,0,0,0,1,0,1,0,0,0,1,0,0,0,1,0,0;1,0,0,0,1,0,1,1,1,1,0,0,0,0,1,0,0;1,0,0,0,1,0,1,0,0,0,1,0,0,0,1,0,0;0,1,1,1,0,0,1,1,1,1,0,0,1,1,1,0,0];
img = padarray(obj, [249,244]);
img1 =  padarray(obj, [41,35]);
figure(1)
imshow(img1)
img_grad = gradsum(img);
%% create speckle 
medium = rand(513,513);
speckle = conv2(obj,medium);
speckle = speckle(59:459,65:465);
%% auto-autocorrelation
speckle = imread('OBJ.bmp');
speckle = im2double(speckle);
figure(2)
imshow(speckle,[])
% speckle = speckle(101:301,101:301);%
PR = zixiangguan(speckle);
% autocl = PR(57:143,57:143);
autocl = PR(158:244,158:244);
figure(3) 
imshow(autocl,[]);
%% amplitude
autocl_f = fft2(autocl);
G = sqrt(abs(autocl_f)); 
%% phase retrieval
S = ones(5,17);
S = padarray(S, [41 35]); %support area
est = rand(87,87);
xn = est;
est_flag = est;
bate = 0.72;
%HIO
for n=1:300
   c=Pm(est,G);
   d=Ps(c,S);
   e=Ps(est,S);
   est=(1+bate)*d-e-bate*c+est;
   est((est)<0)=0;
end
xn_est = Ps(est,S);
xn_rzt = abs(xn_est);
xn_hio = xn_rzt;
xn_hio = double((xn_hio-min(min(xn_hio)))./(max(max(xn_hio))-min(min(xn_hio))));
figure(4)
imshow(xn_hio)

xn_hio_r = xn_hio;
xn_hio_r = rot90(xn_hio_r,2);
% xn_hio_r = xn_hio_r./1.2;
xn_cut = xn_hio_r(42:46,36:52);
figure(10)
imshow(xn_hio_r)
xn_cut_r = xn_hio_r(42:46,36:52);

error_hio = log(MSE(img1,xn_hio));
if(log(MSE(img1,xn_hio_r))<error_hio)
    error_hio=log(MSE(img1,xn_hio_r));
end

ssim_hio = ssim(obj,xn_cut);
if(ssim(obj,xn_cut_r)>ssim_hio)
    ssim_hio=ssim(obj,xn_cut_r);
end

sss = rot90(xn_hio,2);
figure(7)
imshow(abs(sss),[])
% % Huber
      count = 1;
      error1 = 1;
      itera_t = 0;
      t=1;
  for n=1:500
   c=Pm(xn,G);
   d=Ps(c,S);
   e=Ps(xn,S);
   xn=(1+bate)*d-e-bate*c+xn;
   xn((xn)<0)=0;

      u_xn = Huber(xn); 
      xn = xn - t.*u_xn;
      
      xn_ab  = abs(xn);
      xn_ab  = xn_ab.*S;
      xn_ab(xn_ab<1e-24)=0;
      xn2=double((xn_ab-min(min(xn_ab)))./(max(max(xn_ab))-min(min(xn_ab))));
      midgrad = gradsum(xn2);
      error  = abs( (log(midgrad) -log(img_grad)) / log(img_grad) );
      if( error < error1)
          error1 = error;
          xn_r = xn2;
      else
          t=0.5*t;
          xn_r=xn2;
      end
  end
   count = count+1;

xn=Ps(c,S);
xn=double((xn-min(min(xn)))./(max(max(xn))-min(min(xn))));
figure(5)
imshow(abs(xn),[])
figure(6)
imshow(abs(xn_r),[])
error_huber1 = log(MSE(img1,xn_r));
xn_r1 = rot90(xn_r,2);
figure(7)
imshow(abs(xn_r1),[])
error_huber2 = (MSE(img1,xn_r1));