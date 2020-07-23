clc,clear;
format long e
%1 ԭʼ���ݽ��д�����������к��к�ʹ����Ӧ�кϼƵ����кϼ�
RawData = xlsread('C:\Users\������\Desktop\data_test\11\11������ѧ.xlsx' , 'sheet2');
[Number_Row,Number_Column] = size(RawData);
A = eye(Number_Row,Number_Column);
%�к��к͵ļ�ֵFillData
FillData = zeros(Number_Column,1);
%�������飨�кͣ�
Cited_Number = zeros(Number_Column,1);
%�������飨�кͣ�
Cite_Number = zeros(Number_Row,1);

%xlswrite('C:\Users\������\Desktop\data_test\xiala\Normalized_Matrix.xls',Normalized_Matrix,1,'A1');
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
%%����һ����ֵ50%�Ļ���
for i = 1 : Number_Row
    temp = (Cited_Number(i)+ Cite_Number(i)) / 2;
    Cited_Number(i) = Cited_Number(i) + temp;
    Cite_Number(i) = Cite_Number(i) + temp;
    FillData(i) = FillData(i) + temp;
end

%��ֱ������ϵ������A
for j = 1:Number_Column        
    for i = 1:Number_Row
        A(i,j) = RawData(i,j)/FillData(j);
    end
end


E = eye(Number_Row,Number_Column);
Leontief_Matrix = inv(E - A);
%���ֱ������ϵ������A���ﰺ��������
xlswrite('C:\Users\������\Desktop\data_test\11\A.xls',A,1,'A1');
xlswrite('C:\Users\������\Desktop\data_test\11\Leontief_Matrix.xls',Leontief_Matrix,1,'A1');
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

    % ��Ӧ��ϵ�� Ϊĳһ��Ԫ�غ�/�к�ƽ��ֵ
    % ��Ӧ��ѧ�Ƶ��������ö�����һ����λ��i�����ܲ�����������
    disp("����ֱ�����ľ���A����ĸ�Ӧ��ϵ��Ϊ");
    Sensitivity_coefficient = Leontief_Matrix_Row_Sum / (Sum_Leontief_Matrix/Number_Row)

    % Ӱ������ϵ�� Ϊĳһ��Ԫ�غ�/����Ԫ���ܺͣ�
    % ��Ӧ��J��������һ����λ���ö�ȫ��ѧ�Ƶ����󲨼��̶�
      disp("����ֱ�����ľ���A�����Ӱ����ϵ��Ϊ");
    Influence_coefficient = Leontief_Matrix_Column_Sum /(Sum_Leontief_Matrix/Number_Column)