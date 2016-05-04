% ensure the h5 file can be visualized through this script
clc;clear all;

%DATA=h5read('./flip_h5data/train_flip_contour.h5','/data');
DATA=load('./matdata/ibug/ibug_img.mat');
DATA=DATA.final_image;
%LABEL=h5read('./flip_h5data/train_flip_contour.h5','/label');
LABEL=load('./matdata/ibug/ibug_rest_label.mat');
LABEL=LABEL.new_rest_landmarks;

height=size(DATA(:,:,:,1),1)/2;

for index=1:3030
label1=LABEL(:,index);
vis_label(:,1)=label1(1:2:end);
vis_label(:,2)=label1(2:2:end);
vis_label = vis_label *height+height;
figure;
imshow(permute(DATA(:,:,:,index),[2 1 3]))

for i=1:size(vis_label,1)
hold on;
plot(vis_label(i,1),vis_label(i,2),'.r')
end

figure;

imshow(permute(DATA(:,:,:,index+1348),[2 1 3]))
label1=LABEL(:,index+1348);
vis_label(:,1)=label1(1:2:end);
vis_label(:,2)=label1(2:2:end);
vis_label = vis_label *height+height;
for i=1:size(vis_label,1)
hold on;
plot(vis_label(i,1),vis_label(i,2),'.r')
end
pause;
end