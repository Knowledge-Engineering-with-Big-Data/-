# -
This program is used for calculating the influence coefficient and the sensitivity coefficient by matlab
  
1. 将原数据对应的行合计、列合计算出，比较极大值，然后通过2个数组补齐这些差值    
2. 计算直接消耗系数矩阵A，矩阵元素除以对应列和（实际上是行和与列和的极大值）   
3. 计算里昂惕夫逆矩阵 （E-A）^-1  
4. 通过里昂惕夫逆矩阵，计算感应度系数与影响力系数  

采用matlab计算影响力系数

IS_Coefficent_Caculate.m
* 输入为目录下全体引用矩阵（.csv） 
* 输入：引用矩阵（.csv）路径
* 输出：影响力系数，感应度系数两个nx1的列向量

时间矩阵
* 输入：无
* 读取文件所在目录下的全体csv文件，每次调用IS_Coefficent_Caculate方法
* 输出：按照年份划分的不同学科影响力，感应度系数矩阵
