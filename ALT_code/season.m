clc;clear;
tic;
%读取shape文件
shape1 = xlsread('G:\qilianshan\SBAS_result\垂向\H\out_10_vector_1_clip.xlsx');
% [max,im] = max(shape(:,1));
% [shape,dbfFeildName] = dbfread('G:\qilianshan\SBAS_result\106_17-21new\coherence_thr_10_clip\out_10_vector_9_clip.dbf');
% [a, date] = xlsread('D:\qilianshan\insar_date.xlsx','106');
% shape1 = cell2mat(shape); %将元胞结构转换成double数值类型
% velocity = shape1(:,1);
% x = shape1(:,9);
% y = shape1(:,10);
x = shape1(:,1);
y = shape1(:,2);
disp = shape1(:,2:end);
disp_F_17 = disp(:,2:17);%首次温度0以上和0以下的区间
disp_F_18 = disp(:,31:45);
disp_F_19 = disp(:,60:80);
% disp_F_20 = disp(:,94:110);
[max_17,index_max17] = max(disp_F_17,[],2);
[min_17,index_min17] = min(disp_F_17,[],2);
[max_18,index_max18] = max(disp_F_18,[],2);
[min_18,index_min18] = min(disp_F_18,[],2);
[max_19,index_max19] = max(disp_F_19,[],2);
[min_19,index_min19] = min(disp_F_19,[],2);
% [max_20,index_max20] = max(disp_F_20,[],2);
% [min_20,index_min20] = min(disp_F_20,[],2);

cha_17 = max_17-min_17;
% H_17 = cha_17./cosd(39.2);
cha_18 = max_18-min_18;
% H_18 = cha_18./cosd(39.2);
cha_19 = max_19-min_19;
% H_19 = cha_19./cosd(39.2);
cha_20= max_20-min_20;
% H_20 = cha_20./cosd(39.2);
output = [x,y,max_17,index_max17,min_17,index_min17,cha_17,...
    max_18,index_max18,min_18,index_min18,cha_18,...
    max_19,index_max19,min_19,index_min19,cha_19,...
    max_20,index_max20,min_20,index_min20,cha_20]; 
xlswrite('G:\qilianshan\SBAS_result\垂向\H_fit\vector_9.xlsx', output,'Sheet1','A2');