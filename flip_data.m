clc;
clear all;

load img.mat
load contour_label.mat
load rest_label.mat

for i=1:size(final_image,4)
flip_image(:,:,:,i)=fliplr(permute(final_image(:,:,:,i),[2,1,3]));
flip_image(:,:,:,i)=permute(flip_image(:,:,:,i),[2,1,3]);
end

flip_landmarks=single(zeros(size(contour_landmarks,1),size(contour_landmarks,2)));
flip_landmarks(1:2:end,:)=-contour_landmarks(1:2:end,:);
flip_landmarks(2:2:end,:)=contour_landmarks(2:2:end,:);

flip_rest_landmarks=single(zeros(306,1798));
flip_rest_landmarks(1:2:end,:)=-rest_landmarks(1:2:end,:);
flip_rest_landmarks(2:2:end,:)=rest_landmarks(2:2:end,:);

save ('/home/tydu/Desktop/data_processing_matlab/flip_img.mat','flip_image');
save ('/home/tydu/Desktop/data_processing_matlab/flip_contour_label.mat','flip_landmarks');
save ('/home/tydu/Desktop/data_processing_matlab/flip_rest_label.mat','flip_rest_landmarks');
