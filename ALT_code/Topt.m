%计算SWI（基于最大NSE）
clc;clear;
PSWI04 = xlsread('D:\qilianshan\ExpF\shice2017_041020.xlsx','PSWI_O_04');%这是实测站点观测结果
PSWI10 = xlsread('D:\qilianshan\ExpF\shice2017_041020.xlsx','PSWI_O_10');
PSWI20 = xlsread('D:\qilianshan\ExpF\shice2017_041020.xlsx','PSWI_O_20');
SSWI04 = xlsread('D:\qilianshan\ExpF\SMAP_SWI.xlsx','2017_SSWI'); %这是smap结果
Ktn = xlsread('D:\qilianshan\ExpF\k.xlsx','Sheet1');
Pfile_20_1 = xlsread('D:\qilianshan\ExpF\shice_L20-40.xlsx','all_20_O_SWI');
Pfile_40_1 = xlsread('D:\qilianshan\ExpF\shice_L20-40.xlsx','all_40_O_SWI');
Pfile_40_2 = xlsread('D:\qilianshan\ExpF\shice_L40-80.xlsx','all_40_O_SWI');
Pfile_80_2 = xlsread('D:\qilianshan\ExpF\shice_L40-80.xlsx','all_80_O_SWI');
Pfile_80_3 = xlsread('D:\qilianshan\ExpF\shice_L80-160.xlsx','all_80_O_SWI');
Pfile_160_3 = xlsread('D:\qilianshan\ExpF\shice_L80-160.xlsx','all_160_O_SWI');
T=[1:68];%T值
[n,m]=size(PSWI04);
[n1,m1]=size(SSWI04);

% %% 计算NSE（用实测站点计算）
% SWIm_t = PSWI04(1,:);%取了每一个站点表层实测值第一天的值
% T_NSE=[];
% SWI_sim=[];
% T_opt=[];
% II=cell(1,68);
% for T1 = 1:68  %T为68
%     k_xishu = Ktn(:,T1);  %取了T为1：68中的t1列
%     for t1 = 2:213 %从第二行开始算，207
%         xishu = k_xishu(t1);
%         ms_tn = PSWI04(t1,:); %取了每一个站点第j天表层的实测值
%         SWIm_t = SWIm_t + k_xishu(t1).*(ms_tn-SWIm_t);
%         SWI_sim = [SWI_sim;SWIm_t];
%     end
%     II{T1}=SWI_sim;
%     PSWI_sim = PSWI20(2:end,:); %取深层实测的第二行到最后一行计算NSE
% %     PSWI_sim(isnan(PSWI_sim))=0;
% %     SWI_sim(isnan(SWI_sim))=0;
%     for j = 1:14  %站点数量
%         PSWI_sim_j = PSWI_sim(:,j);
%         SWI_sim_j = SWI_sim(:,j);
%         NSE1 = NSE(SWI_sim_j,PSWI_sim_j);  % nse = NSE(sim, obs) 输入参数分别为模拟值、实测值（序列）
%         T_NSE = [T_NSE,NSE1];
%     end
%     T_opt = [T_opt;T_NSE];
%     T_NSE=[];
%     SWIm_t = PSWI04(1,:);
%     SWI_sim=[];
% end
% xlswrite('D:\qilianshan\ExpF\Topt_Only.xlsx',T_opt ,'2015Layer20','B2');

%% 计算NSE（用表层SMAP提取值计算）
SWIm_t = SSWI04(1,:);%取了每一个站点SMAP第一天的值
T_NSE=[];
SWI_sim=[];
T_opt=[];
for T1 = 1:68  %T
    k_xishu = Ktn(:,T1);  %取了T为1：68中的t1列
    for t1 = 2:213 %从第二行开始算214
        xishu = k_xishu(t1);
        ms_tn = SSWI04(t1,:); %取了每一个站点第j天表层的SMAP值
        SWIm_t = SWIm_t + k_xishu(t1).*(ms_tn-SWIm_t);
        SWI_sim = [SWI_sim;SWIm_t];
    end
    PSWI_sim = PSWI20(2:end,:); %取深层实测的第二行到最后一行计算NSE
%     PSWI_sim(isnan(PSWI_sim))=0;
%     SWI_sim(isnan(SWI_sim))=0;
    for j = 1:13
        PSWI_sim_j = PSWI_sim(:,j);
        SWI_sim_j = SWI_sim(:,j);
        NSE1 = NSE(SWI_sim_j,PSWI_sim_j);  % nse = NSE(sim, obs) 输入参数分别为模拟值、实测值（序列）
        T_NSE = [T_NSE,NSE1];
    end
    T_opt = [T_opt;T_NSE];
    T_NSE=[];
    SWIm_t = PSWI04(1,:);
    SWI_sim=[];
end
xlswrite('D:\qilianshan\ExpF\Topt_Only.xlsx',T_opt ,'2017Layer20_SMAP','B2');

% %% 野牛沟区域站点深层Topt
% SWIm_t = Pfile_40_2(1,:);%取了每一个站点表层实测值第一天的值
% T_NSE=[];
% SWI_sim=[];
% T_opt=[];
% II=cell(1,68);
% for T1 = 1:68  %T为68
%     k_xishu = Ktn(:,T1);  %取了T为1：68中的t1列
%     for t1 = 2:213 %从第二行开始算，207
%         xishu = k_xishu(t1);
%         ms_tn = Pfile_40_2(t1,:); %取了每一个站点第j天表层的实测值
%         SWIm_t = SWIm_t + k_xishu(t1).*(ms_tn-SWIm_t);
%         SWI_sim = [SWI_sim;SWIm_t];
%     end
%     II{T1}=SWI_sim;
%     PSWI_sim = Pfile_80_2(2:end,:); %取深层实测的第二行到最后一行计算NSE
% %     PSWI_sim(isnan(PSWI_sim))=0;
% %     SWI_sim(isnan(SWI_sim))=0;
%     for j = 1:14  %站点数量
%         PSWI_sim_j = PSWI_sim(:,j);
%         SWI_sim_j = SWI_sim(:,j);
%         NSE1 = NSE(SWI_sim_j,PSWI_sim_j);  % nse = NSE(sim, obs) 输入参数分别为模拟值、实测值（序列）
%         T_NSE = [T_NSE,NSE1];
%     end
%     T_opt = [T_opt;T_NSE];
%     T_NSE=[];
%     SWIm_t = Pfile_40_2(1,:);
%     SWI_sim=[];
% end
% xlswrite('D:\qilianshan\ExpF\Topt.xlsx',T_opt ,'ye_40-80','A2');