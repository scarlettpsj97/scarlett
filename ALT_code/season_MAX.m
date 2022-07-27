clc;clear;
tic;
file17 = xlsread('G:\qilianshan\SBAS_result\106_17-21new\season_fit\17\vector_8_17.xlsx');
file18 = xlsread('G:\qilianshan\SBAS_result\106_17-21new\season_fit\18\vector_8_18.xlsx');
file19 = xlsread('G:\qilianshan\SBAS_result\106_17-21new\season_fit\19\vector_8_19.xlsx');
file20 = xlsread('G:\qilianshan\SBAS_result\106_17-21new\season_fit\20\vector_8_20.xlsx');

%% 用速度找到相同的点，查找其季节形变量最大值
[n17,m17]=size(file17);
[n18,m18]=size(file18);
[n19,m19]=size(file19);
[n20,m20]=size(file20);


output = [];
for i = 1:n20
    vel = file20(i,1);
    chazhao = [file18;file19;file17];
    [x,y] = find(chazhao==vel);
    if isnan(x)
        output1=file20(i,:);
    else
        [n_x,m_y] = size(x);
        same_vel1 = file20(i,:);
        same_vel3 = [];
        %将相同速率的数据提取出来
        for j = 1:n_x
            same_vel2 = chazhao(x(j),:);
            same_vel3 = [same_vel3;same_vel2];
        end
        same_vel = [same_vel1;same_vel3];
        season = same_vel(:,10);
        season_ave = mean(season);
        output1 = [file20(i,1:9),season_ave];
%         [season_max,index] = min(season);
%         output1 = same_vel(index,:);
    end
    output = [output;output1];
end
xlswrite('G:\qilianshan\SBAS_result\106_17-21new\season_fit\zonghe_ave\sea_max_8.xlsx', output,'Sheet1','A2');
toc;