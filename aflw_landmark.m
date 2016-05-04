clc;
clear all;
close all;

load ('/home/tydu/Desktop/AFLW/landmarks/landmarks.mat');

margin=10;
face_count=1;

aflw_imgs={};
aflw_landmarks=zeros(68,2,size(valid,1));


for index=1:length(valid)
   if exist(fullfile('/home/tydu/Desktop/AFLW/aflw/data',data{valid(index),1}.filename),'file')
      im=imread(fullfile('/home/tydu/Desktop/AFLW/aflw/data',data{valid(index),1}.filename));
   
           if size(data{valid(index),1}.points,3) > 1
               for j=1:size(data{valid(index),1}.points,3)
                   global_landmarks=data{valid(index),1}.points(1:68,:,j);
                   min_x=max( (min(global_landmarks(:,1))-margin) , 1); 
                   min_y=max( (min(global_landmarks(:,2))-margin) , 1);
                   max_x=min( (max(global_landmarks(:,1))+margin) , size(im,2)); 
                   max_y=min( (max(global_landmarks(:,2))+margin) , size(im,1));

                   crop_im=im(min_y:max_y,min_x:max_x,:);
                   local_landmarks=global_landmarks;
                   local_landmarks=local_landmarks-[min_x*ones(68,1) min_y*ones(68,1)];

                   aflw_imgs{face_count,1}=crop_im;
                   aflw_landmarks(:,:,face_count)=local_landmarks;

                   face_count=face_count+1;
               end

            else    
               global_landmarks=data{valid(index),1}.points(1:68,:);
            %    imshow(im);
            %    for i=1:68
            %        hold on;
            %        plot(global_landmarks(i,1),global_landmarks(i,2),'.r');
            %    end
            %     
               min_x=max( (min(global_landmarks(:,1))-margin) , 1); 
               min_y=max( (min(global_landmarks(:,2))-margin) , 1);
               max_x=min( (max(global_landmarks(:,1))+margin) , size(im,2)); 
               max_y=min( (max(global_landmarks(:,2))+margin) , size(im,1));

               crop_im=im(min_y:max_y,min_x:max_x,:);
               local_landmarks=global_landmarks;
               local_landmarks=local_landmarks-[min_x*ones(68,1) min_y*ones(68,1)];

               aflw_imgs{face_count,1}=crop_im;
               aflw_landmarks(:,:,face_count)=local_landmarks;

               face_count=face_count+1;
            %    
            %    figure;
            %     imshow(aflw_imgs{index,1});
            %    for i=1:68
            %        hold on;
            %        plot(aflw_landmarks(i,1,index),aflw_landmarks(i,2,index),'.r');
            %    end
           end
   else
       continue;
   end
end