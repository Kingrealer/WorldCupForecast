data_filename = 'score.xls';
data = xlsread(data_filename);
% normplot(data(:,1))
%  
% wblplot(data(:,1))

team = 7;

y=data(:,team);
ymin=min(y);
ymax=max(y);
x=linspace(ymin,ymax,10);%�������С����ֳ�20���ȷֵ�(19�ȷ�),Ȼ��ֱ�����������ĸ���
yy=hist(y,x);%�����������ĸ���
yy=yy/length(y);%�����������ĸ���
bar(x,yy)%���������ܶȷֲ�ͼ
