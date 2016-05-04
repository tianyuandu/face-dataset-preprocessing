%  Copyright (c) 2015, Omkar M. Parkhi
%  All rights reserved.
clc;
clear all;
addpath('/home/tydu/caffe/matlab/');
addpath(genpath('.'));
img_o = imread('gojunhee.jpg');

img_o = imresize(img_o,[224 224]);
img = single(img_o)/255;

%img = img(:, :, [3, 2, 1]); % convert from RGB to BGR
img = permute(img, [2, 1, 3]); % permute width and height

tic;
model = './prototxts/finetune/VGG_ILSVRC_16_layers_deploy_contour.prototxt';
%model = '/home/tydu/Desktop/caffe-regression-master/kaggle_prototxt/fkp_deploy.prototxt';

weights = './models/vgg_contour_3rd_iter_100000.caffemodel';

caffe.set_mode_cpu();
net = caffe.Net(model, weights, 'test'); % create net and load weights

res = net.forward({img});
caffe_ft = net.blobs('conv3_1').get_data();
toc;


% row=ceil(sqrt(size(caffe_ft,3)));
% col=ceil(size(caffe_ft,3)/row);
% for i=1:size(caffe_ft,3)
% subplot(row,col,i);
% imshow(caffe_ft(:,:,i)')
% end

%landmarks=zeros(194,2);
landmarks=zeros(41,2);
landmarks(:,1)=res{1,1}(1:2:end);
landmarks(:,2)=res{1,1}(2:2:end);
landmarks=landmarks*112+112;

figure;
imshow(img_o);
for i=1:size(landmarks,1)
hold on;
plot(landmarks(i,1),landmarks(i,2),'.r');
end