# 采用matlab计算影响力系数

1. IS_Coefficent_Caculate.m

  * 输入：引用矩阵（.csv）路径
  * 输出：影响力系数，感应度系数两个nx1的列向量

TimeMatrix.m

  * 输入：无
  * 读取文件所在目录下的全体csv文件，每次调用IS_Coefficent_Caculate方法操作一个文件
  * 输出：按照年份划分的不同学科影响力、感应度系数矩阵
