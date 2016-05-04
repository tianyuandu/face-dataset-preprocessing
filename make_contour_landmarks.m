%194 helen:
%1~41 contour (counter-clockwise)
%42~58 nose (counter-clockwise)
%59~114 lip (clockwise)
%115~134 right eye (clockwise)
%135~154 left eye (counter-clockwise)
%155~174 right eyebrow (clockwise)
%175~194 left eyebrow (counter-clockwise)

clear all;clc;

load label.mat
load img.mat


contour_landmarks(:,:)=final_landmarks(1:82,:);
rest_landmarks(:,:)=final_landmarks(83:end,:);

save ('/home/tydu/Desktop/data_processing_matlab/contour_label.mat','contour_landmarks');
save ('/home/tydu/Desktop/data_processing_matlab/rest_label.mat','rest_landmarks');


% imshow(permute(final_image(:,:,:,1),[2 1 3]))
% for i=1:194
% hold on;
% plot(landmarks(i,1),landmarks(i,2),'.r')
% text(double(landmarks(i,1)+0.1),double(landmarks(i,2)+0.1),num2str(i))
% end