clc;clear;
tic;
% %����ѭ����ȡ����tiff�ļ�
% file_path = 'E:\SMAP_L4\2020\�滻\';% ͼ���ļ���·�� 
% img_path_list = dir(strcat(file_path,'*.tif'));%��ȡ���ļ���������TIF��ʽ��ͼ�� 
% img_num = length(img_path_list);%��ȡͼ��������
% [Data,geo] = geotiffread('E:\SMAP_L4\2015\�滻\20150401.tif');
% info=geotiffinfo('E:\SMAP_L4\2015\�滻\20150401.tif');
% [n,m]=size(Data);
% % cha = importdata('E:\SMAP_L4\2016\SSWI\cha.tif'); 
% % SMAP_min = importdata('E:\SMAP_L4\2016\SSWI\min.tif'); 
% 
% %%����SMAP��SWI
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


%% �滻���߶���ȡֵ����SWI
file = xlsread('D:\qilianshan\ExpF\�滻���߶�SMAP���Ұţ��.xlsx','2018');
data = file(6:end,:);
output = data./0.813;
xlswrite('D:\qilianshan\ExpF\SWI�滻���߶�SMAP���Ұţ��.xlsx',output,'2018','B6')
toc;