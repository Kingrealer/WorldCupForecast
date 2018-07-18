% 求mu1,sig1（x）和mu2,sig2（y）对应的联合概率密度下y>=x的概率
function p=possibility(mu1,sig1,mu2,sig2)
    syms x y; %定义两个符号变量
%     p=int(int((1/(2*pi))*(1/(sig1*sig2))*exp(-((x - mu1)^2/(sig1^2) + (y - mu2)^2/(sig2^2))/2),y,x,Inf),x,-Inf,Inf);    %积分
    ff=@(x,y)(1/(2*pi))*(1/(sig1*sig2))*exp(-((x - mu1).^2/(sig1.^2) + (y - mu2).^2/(sig2.^2))/2);
    ymin=@(x)x;
    p=integral2(ff,-Inf,Inf,ymin,Inf);    %积分（这是近似解，解析解积分很慢）
    p=vpa(p,5);