data_filename = 'score.xls';
result_filename = 'result.xls';
data = xlsread(data_filename);

% �����̬�ֲ�����������

for i = 1:1:size(data,2)
    [mu sigma] = normfit(data(:,i));
    params(i, :) = [mu sigma];      % �������mu��sigma����
end

times = 1000;

% round1

win_rate1 = zeros(1 , 16);

for i = 1:1:8
    % ����˫��������
    team1 = i * 2 -1;               % ��һ֧������
    team2 = i * 2;                  % �ڶ�֧������
    % ����˫������Ĳ���
    t1mu = params(team1, 1);
    t1sigma = params(team1, 2);
    t2mu = params(team2, 1);
    t2sigma = params(team2, 2);
    % ���ɷ��Ӹ�����̬�ֲ�������
    t1 = normrnd(t1mu, t1sigma, 1, times);
    t2 = normrnd(t2mu, t2sigma, 1, times);
    
    t1c = 0;
    t2c = 0;
    
    for j=1:1:times
        if t1(j) == t2(j)
            t1c = t1c + 1;
            t2c = t2c + 1;
        elseif t1(j) > t2(j)
            t1c = t1c + 1;
        else
            t2c = t2c + 1;
        end
    end

    t1r = t1c / times;         % t1ʤ��
    t2r = t2c / times;         % t2ʤ��
    
    win_rate1(team1) = t1r;
    win_rate1(team2) = t2r;
end

% round2

win_rate2 = zeros(1 , 16);

for i = 1:1:16
   team = i;
   sector = ceil(team / 4);            % ����
   position = mod(team, 4);            % ���ڱ��
   if position == 0
       position = sector * 4;
   end
   if position <= 2
       team1 = sector * 4 - 1;          % ��ȡ��һ������ӱ��
       team2 = sector * 4;
   else
       team1 = sector * 4 - 3;
       team2 = sector * 4 - 2;
   end
   
   tmu = params(team, 1);
   tsigma = params(team, 2);
   t1mu = params(team1, 1);
   t1sigma = params(team1, 2);
   t2mu = params(team2, 1);
   t2sigma = params(team2, 2);
   
   % ����
   t = normrnd(tmu, tsigma, 1, times);
   t1 = normrnd(t1mu, t1sigma, 1, times);
   t2 = normrnd(t2mu, t2sigma, 1, times);
   
   % ��ʤ����
   tc1 = 0;
   tc2 = 0;
   
   for j=1:1:times
        if t(j) >= t1(j)
            tc1 = tc1 + 1;
        end
        if t(j) >= t2(j)
            tc2 = tc2 + 1;
        end
   end
   
   tc1r = tc1 / times;
   tc2r = tc2 / times;
    
   win_rate2(team) = win_rate1(team) * (win_rate1(team1) * tc1r + win_rate1(team2) * tc2r);
end

% round3

win_rate3 = zeros(1 , 16);
teams = zeros(1 , 4);

for i = 1:1:16
   team = i;
   sector = ceil(team / 8);            % ����
   position = mod(team, 8);            % ���ڱ��
   if position == 0
       position = sector * 8;
   end
   if position <= 4
       teams(1) = sector * 8 - 3;          % ��ȡ��һ������ӱ��
       teams(2) = sector * 8 - 2;
       teams(3) = sector * 8 - 1;
       teams(4) = sector * 8;
   else
       teams(1) = sector * 8 - 7;          % ��ȡ��һ������ӱ��
       teams(2) = sector * 8 - 6;
       teams(3) = sector * 8 - 5;
       teams(4) = sector * 8 - 4;
   end
   
   tmu = params(team, 1);
   tsigma = params(team, 2);
   
   pteams = zeros(4, times);
   
   for j = 1:1:length(teams)
       tmp = normrnd(params(teams(j), 1), params(teams(j), 2), times);
       for k = 1:1:times
           pteams(j, k) = tmp(k);
       end
   end
   
   % ��ʤ����
   tci = zeros(1, 4);
   tri = zeros(1, 4);
   
   for j=1:1:4
       pt = normrnd(tmu, tsigma, times);
       for k=1:1:times
           if pt(k) >= pteams(j, k)
               tci(j) = tci(j) + 1;
           end
       end
       tri(j) = tci(j) / times;
   end
   
   tmp_rate = 0;
   
   for j=1:1:4
       tmp_rate = tmp_rate + win_rate2(teams(j)) * tri(j);
   end
    
   win_rate3(team) = win_rate2(team) * tmp_rate;
end

% round4

win_rate4 = zeros(1 , 16);
teams = zeros(1 , 8);

for i = 1:1:16
   team = i;
   position = team;
   if position <= 8
       for j = 1:1:length(teams)
           teams(j) = 8 + j;
       end
   else
       for j = 1:1:length(teams)
           teams(j) = j;
       end
   end
   
   tmu = params(team, 1);
   tsigma = params(team, 2);
   
   pteams = zeros(8, times);
   
   for j = 1:1:length(teams)
       tmp = normrnd(params(teams(j), 1), params(teams(j), 2), times);
       for k = 1:1:times
           pteams(j, k) = tmp(k);
       end
   end
   
   % ��ʤ����
   tci = zeros(1, 8);
   tri = zeros(1, 8);
   
   for j=1:1:8
       pt = normrnd(tmu, tsigma, times);
       for k=1:1:times
           if pt(k) >= pteams(j, k)
               tci(j) = tci(j) + 1;
           end
       end
       tri(j) = tci(j) / times;
   end
   
   tmp_rate = 0;
   
   for j=1:1:8
       tmp_rate = tmp_rate + win_rate3(teams(j)) * tri(j);
   end
    
   win_rate4(team) = win_rate3(team) * tmp_rate;
end

xlswrite(result_filename, win_rate4);
     