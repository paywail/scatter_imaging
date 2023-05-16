function [ y] = Pm(x,p)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

a=fft2(x);

margin=abs(a);

b=a./margin;

if a~=0
    z=p.*b;
else z=p;
end

y=ifft2(z);

end

