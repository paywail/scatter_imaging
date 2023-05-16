function Huber = Huber(g)
% g = rand(100,100);

x_grad = diffh(g(:,:));
y_grad = diffv(g(:,:));

grad = sqrt( abs((x_grad(:,:))).^2 + abs((y_grad(:,:))).^2 );

theta = median(median(grad));

partbo = (abs(grad).^2)./(theta^2);

pf = sqrt(1+ partbo);

mid1 = grad/pf;

Huber =  -1/(2*(theta^2))*(mid1);

end

% Huber =  -1/(2*(theta^2))*(grad/pf);

