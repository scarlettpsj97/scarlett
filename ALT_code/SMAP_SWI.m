clc;clear;
tic;
% %遍历循环读取所有tiff文件
% file_path = 'E:\SMAP_L4\2020\替换\';% 图像文件夹路径 
% img_path_list = dir(strcat(file_path,'*.tif'));%获取该文件夹中所有TIF格式的图像 
% img_num = length(img_path_list);%获取图像总数量
% [Data,geo] = geotiffread('E:\SMAP_L4\2015\替换\20150401.tif');
% info=geotiffinfo('E:\SMAP_L4\2015\替换\20150401.tif');
% [n,m]=size(Data);
% % cha = importdata('E:\SMAP_L4\2016\SSWI\cha.tif'); 
% % SMAP_min = importdata('E:\SMAP_L4\2016\SSWI\min.tif'); 
% 
% %%计算SMAP的SWI
% for i = 1:img_num
%     image_name = img_path_list(i).name;
%     cell_str = strsplit(image_name,'.');
%     smap_name = cell_str{1,1};
%     SMAP = importdata(strcat(file_path,image_name));
% %     result = (SMAP-SMAP_min)./cha;
%     result = (SMAP-0)./(0.813-0);
%     outpath='E:\SMAP_L4\2020\SSWI\';
%     outFile = strcat(outpath,smap_name);
%     geotiffwrite(outFile,result,geo,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
% end


%% 替换降尺度提取值——SWI
file = xlsread('D:\qilianshan\ExpF\替换降尺度SMAP结果野牛沟.xlsx','2018');
data = file(6:end,:);
output = data./0.813;
xlswrite('D:\qilianshan\ExpF\SWI替换降尺度SMAP结果野牛沟.xlsx',output,'2018','B6')
toc;