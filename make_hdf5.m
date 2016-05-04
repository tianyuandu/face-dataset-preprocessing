% clear all;clc;
% 
% load label.mat;
% load img.mat;
% 
% %1798 samples, choose 450 as val, 1348 as train
% %final_landmarks=single(final_landmarks);
% train_image=final_image(:,:,:,1:1348);
% train_landmarks=final_landmarks(:,1:1348);
% train_length=1348;
% 
% val_image=final_image(:,:,:,1349:end);
% val_landmarks=final_landmarks(:,1349:end);
% val_length=450;
% 
% h5create('train.h5','/data',[224 224 3 train_length],'Datatype','single');  %cols x rows!!!!!!!
% h5create('train.h5','/label',[388 train_length],'Datatype','single');
% h5create('val.h5','/data',[224 224 3 val_length],'Datatype','single');  %cols x rows!!!!!!!
% h5create('val.h5','/label',[388 val_length],'Datatype','single');
% 
% h5write('train.h5','/data',train_image);
% h5write('train.h5','/label',train_landmarks);
% h5write('val.h5','/data',val_image);
% h5write('val.h5','/label',val_landmarks);

% after that, use visualize_h5file.m check

clear all;clc;

load final_flip_contour_label.mat;
%load rest_label.mat
load final_flip_img.mat;

%1798 samples, choose 450 as val, 1348 as train
%final_landmarks=single(final_landmarks);
train_image=final_image_flip(:,:,:,[1:1348,1799:3146]);
train_contour_landmarks=final_contour_flip_landmarks(:,[1:1348,1799:3146]);
%train_rest_landmarks=rest_landmarks(:,1:1348);
train_length=1348*2;

val_image=final_image_flip(:,:,:,[1349:1798,3147:3596]);
val_contour_landmarks=final_contour_flip_landmarks(:,[1349:1798,3147:3596]);
%val_rest_landmarks=rest_landmarks(:,1349:end);
val_length=450*2;

h5create('train_flip_contour.h5','/data',[224 224 3 train_length],'Datatype','single');  %cols x rows!!!!!!!
h5create('train_flip_contour.h5','/label',[82 train_length],'Datatype','single');
h5create('val_flip_contour.h5','/data',[224 224 3 val_length],'Datatype','single');  %cols x rows!!!!!!!
h5create('val_flip_contour.h5','/label',[82 val_length],'Datatype','single');

h5write('train_flip_contour.h5','/data',train_image);
h5write('train_flip_contour.h5','/label',train_contour_landmarks);
h5write('val_flip_contour.h5','/data',val_image);
h5write('val_flip_contour.h5','/label',val_contour_landmarks);

% h5create('train_rest.h5','/data',[224 224 3 train_length],'Datatype','single');  %cols x rows!!!!!!!
% h5create('train_rest.h5','/label',[306 train_length],'Datatype','single');
% h5create('val_rest.h5','/data',[224 224 3 val_length],'Datatype','single');  %cols x rows!!!!!!!
% h5create('val_rest.h5','/label',[306 val_length],'Datatype','single');
% 
% h5write('train_rest.h5','/data',train_image);
% h5write('train_rest.h5','/label',train_rest_landmarks);
% h5write('val_rest.h5','/data',val_image);
% h5write('val_rest.h5','/label',val_rest_landmarks);
