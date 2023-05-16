% function gsum = gradsum(g)
% [xgrad,ygrad] = gradient(g);
% xgrad_f = fft2(xgrad);
% ygrad_f = fft2(ygrad);
% xgrad_af = abs(xgrad_f);
% ygrad_af = abs(ygrad_f);
% x_sum = sum(sum(xgrad_af));
% y_sum = sum(sum(ygrad_af));
% gsum = x_sum+y_sum;
% end

function gsum = gradsum(g)
[xgrad,ygrad] = gradient(g);
xgrad_f = xgrad;
ygrad_f = ygrad;
xgrad_af = abs(xgrad_f);
ygrad_af = abs(ygrad_f);
x_sum = sum(sum(xgrad_af));
y_sum = sum(sum(ygrad_af));
gsum = x_sum+y_sum;
end