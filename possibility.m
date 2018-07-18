% ��mu1,sig1��x����mu2,sig2��y����Ӧ�����ϸ����ܶ���y>=x�ĸ���
function p=possibility(mu1,sig1,mu2,sig2)
    syms x y; %�����������ű���
%     p=int(int((1/(2*pi))*(1/(sig1*sig2))*exp(-((x - mu1)^2/(sig1^2) + (y - mu2)^2/(sig2^2))/2),y,x,Inf),x,-Inf,Inf);    %����
    ff=@(x,y)(1/(2*pi))*(1/(sig1*sig2))*exp(-((x - mu1).^2/(sig1.^2) + (y - mu2).^2/(sig2.^2))/2);
    ymin=@(x)x;
    p=integral2(ff,-Inf,Inf,ymin,Inf);    %���֣����ǽ��ƽ⣬��������ֺ�����
    p=vpa(p,5);