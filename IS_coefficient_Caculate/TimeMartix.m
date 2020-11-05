% 按照Folder目录，读取目录下全部的CSV文件（JAVA按时间抽取出的引用数据）
clc,clear;
format long e
Folder = 'C:\\Users\\HP\\Desktop\\Data\\Time\\';
Files = dir([Folder '*.csv']);
LengthFiles = length(Files);
I = zeros(27,1);
S = zeros(27,1);

% 27个学科在2000-2017年的两类系数
InfluenceSequence = zeros(27,18);
SensitiveSequence = zeros(27,18);
for i = 1:LengthFiles 
    [I,S] = IS_Coefficent_Caculate([Folder,Files(i).name]);
    InfluenceSequence(:,i) = I;
    SensitiveSequence(:,i) = S;
end

xlswrite('C:\Users\HP\Desktop\Data\Time\InfluenceSequence.xls',InfluenceSequence,1,'A1');
xlswrite('C:\Users\HP\Desktop\Data\Time\SensitiveSequence.xls',SensitiveSequence,1,'A1');
