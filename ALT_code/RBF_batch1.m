clc;clear;
%% 降尺度：SMAP数据和日期数据
%% 训练
% file = xlsread('D:\qilianshan\babaohe\降尺度模型RBF输入数据.xlsx', 'All');
% RandIndex = randperm(length(file));
% file_random = file(RandIndex,:);
% mv = file_random(:,9)';
% traind = file_random(1:7346,1:8);
% train_mv = mv(1,1:7346);
% testd = file_random(7346:10495,1:8);
% test_mv = mv(1,7346:10495);
file = xlsread('D:\qilianshan\babaohe\降尺度模型RBF输入数据野牛沟.xlsx', 'Sheet1');
RandIndex = randperm(length(file));
file_random = file(RandIndex,:);
mv = file_random(:,9)';
traind = file_random(1:19,1:8);
train_mv = mv(1,1:19);
testd = file_random(19:22,1:8);
test_mv = mv(1,19:22);
%% 将BP网络改成径向基网络
net1=feedforwardnet(40);
net1.layers{1,1}.netInputFcn='netprod';
net1.layers{1,1}.transferFcn='radbas';
net1.trainParam.min_grad=1e-10;
net1=train(net1,traind',train_mv);
output=sim(net1,testd');
corr_rate=sum(round(output)==test_mv)/numel(test_mv);


%% 导入数据
silt = geotiffread('D:\qilianshan\chidu\silt.tif');
silt1 = silt(2:end,2:end);
sand = geotiffread('D:\qilianshan\chidu\sand.tif');
sand1 = sand(2:end,2:end);
clay = geotiffread('D:\qilianshan\chidu\clay.tif');
clay1 = clay(2:end,2:end);
slope = geotiffread('D:\qilianshan\chidu\slope.tif');
slope1 = slope(2:end,2:end);
dem = geotiffread('D:\qilianshan\chidu\dem.tif');
dem1 = dem(2:end,2:end);
landuse = geotiffread('D:\qilianshan\chidu\GONG.tif');
landuse1 = landuse(2:end,2:end);
X = geotiffread('D:\qilianshan\chidu\X.tif');
Y = geotiffread('D:\qilianshan\chidu\Y.tif');


%遍历循环读取所有tiff文件
file_path = 'E:\SMAP_L4\chidu\test\';% 图像文件夹路径 
img_path_list = dir(strcat(file_path,'*.tif'));%获取该文件夹中所有TIF格式的图像 
img_num = length(img_path_list);%获取图像总数量
II=cell(1,img_num);
[Data,geo] = geotiffread('E:\SMAP_L4\2015\resample\re_20150401.tif');
info=geotiffinfo('E:\SMAP_L4\2015\resample\re_20150401.tif');

%% 预测
for i = 1:img_num
    image_name = img_path_list(i).name;
    cell_str = strsplit(image_name,'.');
    smap_name = cell_str{1,1};
    SMAP = importdata(strcat(file_path,image_name));
    output1 = [];
    DATE = ones(6050,1); %影像大小是6050*10419
    for j = 1:10419
        X_in = X(1:end,j);
        Y_in = Y(1:end,j);
        SMAP_in = SMAP(1:end,j);
        silt_in = silt1(1:end,j);
        sand_in = sand1(1:end,j);
        clay_in = clay1(1:end,j);
        slope_in = slope1(1:end,j);
        dem_in = dem1(1:end,j);
        GONG_in = landuse1(1:end,j);
        DATE_in = DATE.*i;
        input_yu = [SMAP_in,dem_in,slope_in,clay_in,sand_in,silt_in,GONG_in,DATE_in];
        yuce = sim(net1,input_yu');
        output1 = [output1,yuce'];
    end
    outpath='E:\SMAP_L4\chidu\test\';
    outFile = strcat(outpath,smap_name,'.tif');
    geotiffwrite(outFile,output1,geo,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)
end

    
    
    