% 根据Input_Filepath读取单个引用矩阵，返回Influence_coefficient与Sensitivity_coefficient两个nx1向量
function [Influence_coefficient,Sensitivity_coefficient] = IS_Coefficent_Caculate(Input_Filepath)

format long e

%1 原始数据进行处理，并且填充行和列和使得相应行合计等于列合计

RawData = xlsread(Input_Filepath);

[Number_Row,Number_Column] = size(RawData);

A = eye(Number_Row,Number_Column);

% 行和列和的极值FillData

FillData = zeros(Number_Column,1);

% 被引数组（行和）

Cited_Number = zeros(Number_Raw,1);

% 引用数组（列和）

Cite_Number = zeros(Number_Column,1);



Column_Sum_RawData = zeros(1,Number_Column);

Row_Sum_RawData = zeros(1,Number_Row);



for j = 1:Number_Column        

    for i = 1:Number_Row

        Column_Sum_RawData(j) = Column_Sum_RawData(j)+ RawData(i,j);

    end

end

for i = 1 : Number_Row        

    for j = 1 : Number_Column

        Row_Sum_RawData(i) = Row_Sum_RawData(i)+ RawData(i,j);

    end

end



for i = 1 : Number_Row

    if ( Column_Sum_RawData(i) >= Row_Sum_RawData(i) )

        FillData(i) = Column_Sum_RawData(i) ;

        Cited_Number(i) = Column_Sum_RawData(i) - Row_Sum_RawData(i);

    else 

        FillData(i) = Row_Sum_RawData(i);

        Cite_Number(i) = Row_Sum_RawData(i) - Column_Sum_RawData(i);

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

    Sensitivity_coefficient = Leontief_Matrix_Row_Sum / (Sum_Leontief_Matrix/Number_Row);



    % 影响力度系数 为某一列元素和/矩阵元素总和，

    % 反应的J部门增加一个单位引用对全体学科的需求波及程度

    Influence_coefficient = Leontief_Matrix_Column_Sum /(Sum_Leontief_Matrix/Number_Column);
    
    
end