% 该代码求融化时段内最大值与最小值之间，形变点直线拟合结果（y=kx+b），求得斜率k，
% 该斜率为季节融化的速率，找到季节融化结束时间，与季节融化开始时间，用速率求出季节融化量。
clc;clear;
tic;
%读取shape文件
shape1 = xlsread('G:\qilianshan\SBAS_result\垂向\H\out_10_vector_9_clip.xlsx');
% [shape,dbfFeildName] = dbfread('G:\qilianshan\SBAS_result\106_17-21new\coherence_thr_10_clip\out_10_vector_10_clip.dbf');
% [a, date] = xlsread('D:\qilianshan\insar_date.xlsx','106');
% shape1 = cell2mat(shape); %将元胞结构转换成double数值类型
date = xlsread('D:\qilianshan\insar_date.xlsx','106');
% velocity = shape1(:,1);
% x = shape1(:,9);
% y = shape1(:,10);
% vel = shape1(:,1);
% disp = shape1(:,19:end);
%% 8 9不知道为什么读出来多第一列
% velocity = shape1(:,2);
x = shape1(:,1);
y = shape1(:,2);
% vel = shape1(:,2);
disp = shape1(:,3:end);
%首次温度0以上和0以下的区间
disp_F_17 = disp(:,2:17);%20170330-20171008
date_17 = date(2:17,2)';
[max_17,index_max17] = max(disp_F_17,[],2);
[min_17,index_min17] = min(disp_F_17,[],2);
zuhe17 = [x,y,max_17,min_17,index_max17,index_min17];
[n17,m17] = size(zuhe17);
% 筛选掉不符合常规的点（最大值出现时间晚于4）
output17 = [];
for i  = 1:n17
    quzhi17 = zuhe17(i,:);
    max17 = quzhi17(:,5);
    min17 = quzhi17(:,6);
    if max17 < 5 && min17-max17>5
        disp_hang17 = disp_F_17(i,max17:min17);
        date_fit17 = date_17(:,max17:min17);
        [fun,g] = createFit1(date_fit17', disp_hang17');%function [fitresult, gof] = createFit1(date_fit, disp_hang)
        k17 = fun.p1;
        b17 = fun.p2;
        RMSE17 = g.rmse;
        R217 = g.adjrsquare;
        %预测
        t = date(2:17,2)';
        y17 = k17.*t+b17;
        season17 = (y17(1,16)-y17(1,1));%转垂向
        A17 = [zuhe17(i,:),k17, b17, season17];
        output17 = [output17;A17];
    end
end
xlswrite('G:\qilianshan\SBAS_result\垂向\H_fit\vector_9_17.xlsx', output17,'Sheet1','A2');


disp_F_18 = disp(:,31:45);%20180325-20181003
date_18 = date(31:45,2)';
[max_18,index_max18] = max(disp_F_18,[],2);
[min_18,index_min18] = min(disp_F_18,[],2);
zuhe18 = [x,y,max_18,min_18,index_max18,index_min18];
[n18,m18] = size(zuhe18);
% 筛选掉不符合常规的点（最大值出现时间晚于4）
output18 = [];
for j  = 1:n18
    quzhi18 = zuhe18(j,:);
    max18 = quzhi18(:,5);
    min18 = quzhi18(:,6);
    if max18 < 5 && min18-max18>5
        disp_hang18 = disp_F_18(j,max18:min18);
        date_fit18 = date_18(:,max18:min18);
        [fun,g] = createFit1(date_fit18', disp_hang18');%function [fitresult, gof] = createFit1(date_fit, disp_hang)
        k18 = fun.p1;
        b18 = fun.p2;
        RMSE18 = g.rmse;
        R218 = g.adjrsquare;
        %预测
        t = date(2:17,2)';
        y18 = k18.*t+b18;
        season18 = (y18(1,16)-y18(1,1));%转垂向
        A18 = [zuhe18(j,:),k18, b18, season18];
        output18 = [output18;A18];
    end
end
xlswrite('G:\qilianshan\SBAS_result\垂向\H_fit\vector_9_18.xlsx', output18,'Sheet1','A2');


disp_F_19 = disp(:,60:76);%20190401-20191010
date_19 = date(60:76,2)';
[max_19,index_max19] = max(disp_F_19,[],2);
[min_19,index_min19] = min(disp_F_19,[],2);
zuhe19 = [x,y,max_19,min_19,index_max19,index_min19];
[n19,m19] = size(zuhe19);
% 筛选掉不符合常规的点（最大值出现时间晚于4）
output19 = [];
for h  = 1:n19
    quzhi19 = zuhe19(h,:);
    max19 = quzhi19(:,5);
    min19 = quzhi19(:,6);
    if max19 < 5 && min19-max19>5
        disp_hang19 = disp_F_19(h,max19:min19);
        date_fit19 = date_19(:,max19:min19);
        [fun,g] = createFit1(date_fit19', disp_hang19');%function [fitresult, gof] = createFit1(date_fit, disp_hang)
        k19 = fun.p1;
        b19 = fun.p2;
        RMSE19 = g.rmse;
        R219 = g.adjrsquare;
        %预测
        t = date(2:17,2)';
        y19 = k19.*t+b19;
        season19 = (y19(1,16)-y19(1,1));%转垂向
        A19 = [zuhe19(h,:),k19, b19, season19];
        output19 = [output19;A19];
    end
end
xlswrite('G:\qilianshan\SBAS_result\垂向\H_fit\vector_9_19.xlsx', output19,'Sheet1','A2');


% disp_F_20 = disp(:,89:105);%20200326-20201004
% date_20 = date(89:105,2)';
% [max_20,index_max20] = max(disp_F_20,[],2);
% [min_20,index_min20] = min(disp_F_20,[],2);
toc;
