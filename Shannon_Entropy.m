clc,clear;
RawData = xlsread('C:\Users\唐毅明\Desktop\data_test\Finance\Finance.xlsx' , 'sheet2');
[Number_Row,Number_Column] = size(RawData);
ShannonEntropy = zeros(Number_Row,1);
Denominator = zeros(Number_Row,1);
RawData_Column_Sum = zeros(1,Number_Column);
RawData_Row_Sum = zeros(1,Number_Row);
% 计算行和与列和
for j = 1 : Number_Column        
    for i = 1 : Number_Row
        RawData_Column_Sum(j) = RawData_Column_Sum(j)+ RawData(i,j);
    end
end
for i = 1 : Number_Row        
    for j = 1 : Number_Column
        RawData_Row_Sum(i) = RawData_Row_Sum(i)+ RawData(i,j);
    end
end
% 计算公式中的分母，即对应序号k的行和+列和
for i = 1 : Number_Row
        Denominator(i) = RawData_Row_Sum(i) + RawData_Column_Sum(i);
end

for k = 1 : Number_Row
    for i = 1 : Number_Row
        numerator = RawData(i,k) + RawData(k,i);
        temp = numerator/Denominator(k);
        ShannonEntropy(k) = ShannonEntropy(k) - temp * log(temp);
    end
end
ShannonEntropy