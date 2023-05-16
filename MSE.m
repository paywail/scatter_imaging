function error =MSE(img_real,img_re)

[r,c] = size(img_real);
img_diff = img_re - img_real;
img_diff = img_diff.^2;
error = sum(sum(img_diff));
error = error/(r*c);

end