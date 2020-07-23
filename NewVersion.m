clc,clear;
format long e
%1 原始数据进行处理，并且填充行和列和使得相应行合计等于列合计
RawData = xlsread('C:\Users\唐毅明\Desktop\data_test\11\11生命科学.xlsx' , 'sheet2');
[Number_Row,Number_Column] = size(RawData);
A = eye(Number_Row,Number_Column);
%行和列和的极值FillData
FillData = zeros(Number_Column,1);
%被引数组（列和）
Cited_Number = zeros(Number_Column,1);
%引用数组（行和）
Cite_Number = zeros(Number_Row,1);

%xlswrite('C:\Users\唐毅明\Desktop\data_test\xiala\Normalized_Matrix.xls',Normalized_Matrix,1,'A1');
RawData_Column_Sum = zeros(1,Number_Column);
RawData_Row_Sum = zeros(1,Number_Row);

for j = 1:Number_Column        
    for i = 1:Number_Row
        RawData_Column_Sum(j) = RawData_Column_Sum(j)+ RawData(i,j);
    end
end
for i = 1 : Number_Row        
    for j = 1 : Number_Column
        RawData_Row_Sum(i) = RawData_Row_Sum(i)+ RawData(i,j);
    end
end

for i = 1 : Number_Row
    if ( RawData_Column_Sum(i) >= RawData_Row_Sum(i) )
        FillData(i) = RawData_Column_Sum(i) ;
        Cited_Number(i) = RawData_Column_Sum(i) - RawData_Row_Sum(i);
    else 
        FillData(i) = RawData_Row_Sum(i);
        Cite_Number(i) = RawData_Row_Sum(i) - RawData_Column_Sum(i);
    end
end
%%增加一个最值50%的基数
for i = 1 : Number_Row
    temp = (Cited_Number(i)+ Cite_Number(i)) / 2;
    Cited_Number(i) = Cited_Number(i) + temp;
    Cite_Number(i) = Cite_Number(i) + temp;
    FillData(i) = FillData(i) + temp;
end

%求直接消耗系数矩阵A
for j = 1:Number_Column        
    for i = 1:Number_Row
        A(i,j) = RawData(i,j)/FillData(j);
    end
end


E = eye(Number_Row,Number_Column);
Leontief_Matrix = inv(E - A);
%输出直接消耗系数矩阵A和里昂惕夫逆矩阵
xlswrite('C:\Users\唐毅明\Desktop\data_test\11\A.xls',A,1,'A1');
xlswrite('C:\Users\唐毅明\Desktop\data_test\11\Leontief_Matrix.xls',Leontief_Matrix,1,'A1');
Sum_Leontief_Matrix = 0;
Leontief_Matrix_Column_Sum = zeros(Number_Column,1);
Leontief_Matrix_Row_Sum = zeros(Number_Row,1);
for i = 1 : Number_Row
    for j = 1 : Number_Column
        Sum_Leontief_Matrix = Sum_Leontief_Matrix + Leontief_Matrix(i,j);
        Leontief_Matrix_Row_Sum(i) = Leontief_Matrix_Row_Sum(i) + Leontief_Matrix(i,j);

    end
end
for j = 1 : Number_Column
    for i = 1 : Number_Row
        Leontief_Matrix_Column_Sum(j) = Leontief_Matrix_Column_Sum(j) + Leontief_Matrix(i,j);
    end
end

    % 感应度系数 为某一行元素和/列和平均值
    % 反应各学科的最终引用都增加一个单位对i部门总产出的需求量
    disp("根据直接消耗矩阵A计算的感应度系数为");
    Sensitivity_coefficient = Leontief_Matrix_Row_Sum / (Sum_Leontief_Matrix/Number_Row)

    % 影响力度系数 为某一列元素和/矩阵元素总和，
    % 反应的J部门增加一个单位引用对全体学科的需求波及程度
      disp("根据直接消耗矩阵A计算的影响力系数为");
    Influence_coefficient = Leontief_Matrix_Column_Sum /(Sum_Leontief_Matrix/Number_Column)