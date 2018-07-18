data_filename = 'score.xls';
data = xlsread(data_filename);

team = 7;

normplot(data(:, team));