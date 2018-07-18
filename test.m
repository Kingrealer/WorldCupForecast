data_filename = 'score.xls';
data = xlsread(data_filename);
% normplot(data(:,1))
%  
% wblplot(data(:,1))

team = 7;

y=data(:,team);
ymin=min(y);
ymax=max(y);
x=linspace(ymin,ymax,10);%将最大最小区间分成20个等分点(19等分),然后分别计算各个区间的个数
yy=hist(y,x);%计算各个区间的个数
yy=yy/length(y);%计算各个区间的个数
bar(x,yy)%画出概率密度分布图
