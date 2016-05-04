% read landmarks
% scale boxes
% crop the image
% save
clear all;clc;

test_path='E:\testset';
txt_names = dir(fullfile(test_path, '*.pts'));

final_landmarks=[];
final_image=single(zeros(224,224,3,554));
new_local_landmarks=single(zeros(num_of_landmarks*2,1));

ferror=fopen('error_info.txt','wt');

for i=1:numel(txt_names)
    image_name = txt_names(i).name(1:end-4);

    if exist([test_path image_name '.jpg'],'file')
        image = imread([test_path image_name '.jpg']);
    elseif exist([test_path image_name '.png'],'file')
        image = imread([test_path image_name '.png']);
    else
        continue;
    end

    global_landmarks=read_shape([test_path txt_names(i).name],num_of_landmarks);
    
    test_ds=[min(global_landmarks(:,1)),min(global_landmarks(:,2)), ...
       max(global_landmarks(:,1)),max(global_landmarks(:,2))];
          
        ds=handle_boxex(test_ds,image);%zoom in the bounding box
        
              image=image(ds(2):ds(4),ds(1):ds(3),:);
              %imwrite(image,[results_folder_path,image_name{1,1}, '_result.png'],'png');
              %image = permute(image, [2, 1, 3]);                         
              local_landmarks=process_landmarks(ds,global_landmarks);%convert the global landmarks to local landmarks according to the chosen box
              
              new_image=imresize(image,[224 224]);
              local_landmarks(:,1)=local_landmarks(:,1)*(224/size(image,2));
              local_landmarks(:,2)=local_landmarks(:,2)*(224/size(image,1));
                            
              new_image = permute(new_image, [2, 1, 3]); 
              new_image = single(new_image)/255; %scale pixel values to [0, 1]
              new_local_landmarks(1:2:end)=local_landmarks(:,1);
              new_local_landmarks(2:2:end)=local_landmarks(:,2);
              
              local_landmarks=(new_local_landmarks-112)/112; %scale target coordinates to [-1, 1]
              %% 
              final_landmarks=[final_landmarks local_landmarks];
              
              try
                final_image(:,:,:,size(final_landmarks,2))=new_image;
              catch
                  fprintf(ferror,'error in %s\n',image_name);
                  continue;
              end
              % TODO:
              
              
              %flandmark=fopen(['/home/tydu/Desktop/cropped_helen_train/',image_name{1,1},'.txt'],'wt');
              %for lines=1:length(local_landmarks)
              %      fprintf(flandmark,'%f,%f\n',local_landmarks(lines,1),local_landmarks(lines,2));
              %end
              %fclose(flandmark);
    end
 
      
    %showsboxes_face(image, ds, result_path);
    
    %disp(['Created ', result_path]);
%fclose(fid);
fclose(ferror);