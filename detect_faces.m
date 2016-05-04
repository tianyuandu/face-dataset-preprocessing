clear all;clc;
% This script will detect faces in a set of images
% The minimum face detection size is 36 pixels,
% the maximum size is the full image.
%% paths
addpath(genpath('/home/tydu/Desktop/PROJECTS/facial_landmarks/codes/FACE_DETECT/voc-dpm-master'));
%addpath(genpath('/home/tydu/Desktop/voc-dpm-master'));

%images_folder_path = '/home/tydu/Desktop/(data)helen/train/';
%txt_path='/home/tydu/Desktop/(data)helen/annotation/';
IBUG_path='/home/tydu/Desktop/IBUG/trainset/';
%results_folder_path = '/home/tydu/Desktop/detected_helen_train';
%results_folder_path = '/home/tydu/Desktop/cropped_helen_train/';
model_path = '/home/tydu/Desktop/PROJECTS/facial_landmarks/codes/FACE_DETECT/doppia/data/trained_models/face_detection/dpm_baseline.mat';
%model_path= '/home/tydu/Desktop/doppia/data/trained_models/face_detection/dpm_baseline.mat';
face_model = load(model_path);

%% parameters
% lower detection threshold generates more detections
% detection_threshold = -0.5; 
detection_threshold = 0.7; 
% 0.3 or 0.2 are adequate for face detection.overlap larger than nms_threshold will be suppress
nms_threshold = 0.2;
%image_names = dir(fullfile(images_folder_path, '*.jpg'));
txt_names = dir(fullfile(IBUG_path, '*.pts'));% read txt file which including image name
TRAIN=1;% train with landmarks
num_of_landmarks = 68;
%% begin
%fid=fopen('/home/tydu/Desktop/detected_helen_train/num_of_faces.txt','wt');
final_landmarks=[];
%final_image=single(zeros(224,224,3,3300));
%new_local_landmarks=single(zeros(136,1));

final_image=zeros(224,224,3,3300);
new_local_landmarks=zeros(136,1);

ferror=fopen('error_info.txt','wt');

for i=1:numel(txt_names)
    %image_name = textread([txt_path txt_names(i).name],'%s',1);
    image_name = txt_names(i).name(1:end-4);
    %image_name={'118736733_1'};
    
%     if exist([images_folder_path image_name{1,1} '.jpg'],'file')
%         image = imread([images_folder_path image_name{1,1} '.jpg']);
%     else
%         continue;
%     end
    
    if exist([IBUG_path image_name '.jpg'],'file')
        image = imread([IBUG_path image_name '.jpg']);
    elseif exist([IBUG_path image_name '.png'],'file')
        image = imread([IBUG_path image_name '.png']);
    else
        continue;
    end
            
%     [a,b]=textread([txt_path txt_names(i).name],'%f%f','delimiter',',','headerlines', 1);
%     global_landmarks=single([a b]);
%     clear a b;
    
    global_landmarks=read_shape([IBUG_path txt_names(i).name],num_of_landmarks);
    
    while (size(image,1) > 3000) + (size(image,2)>3000) >= 1 % image with big scale will crash the matlab
        image=imresize(image,0.5);
        global_landmarks=global_landmarks*0.5;
    end
    
    [ds, ~] = process_face(image, face_model.model,detection_threshold, nms_threshold);
    disp (['the ' num2str(i) 'th done!'])
    if size(ds,1) == 0 %did not find any face
        %fprintf(fid, '%s number of face(s):%d\n', image_name{1,1}, size(ds,1));
    else
        %result_path = fullfile(results_folder_path, [image_name{1,1}, '_result.png']);
        ds=handle_boxex(ds,image);%zoom in the bounding box
    
        if TRAIN
           [ds,count]=choose_boxex(ds,global_landmarks);% find the box with the most landmarks in
           if count ~= num_of_landmarks
               continue;
               %fprintf(fid,'%s number of landmarks in the box:%d\n',image_name{1,1},count);
           else 
               
              %% MAKE HDF5 FILE 
              image=image(ds(2):ds(4),ds(1):ds(3),:);
              %imwrite(image,[results_folder_path,image_name{1,1}, '_result.png'],'png');
              %image = permute(image, [2, 1, 3]);                         
              local_landmarks=process_landmarks(ds,global_landmarks);%convert the global landmarks to local landmarks according to the chosen box
              
              new_image=imresize(image,[224 224]);
              local_landmarks(:,1)=local_landmarks(:,1)*(224/size(image,2));
              local_landmarks(:,2)=local_landmarks(:,2)*(224/size(image,1));
                            
              new_image = permute(new_image, [2, 1, 3]); 
              %new_image = single(new_image)/255; %scale pixel values to [0, 1]
              new_image = new_image/255; 
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
        end
    end 
      
    %showsboxes_face(image, ds, result_path);
    
    %disp(['Created ', result_path]);
end
%fclose(fid);
fclose(ferror);
final_image=final_image(:,:,:,[1:size(final_landmarks,2)]);

save ('/home/tydu/Desktop/data_processing_matlab/ibug_img.mat','final_image');
save ('/home/tydu/Desktop/data_processing_matlab/ibug_label.mat','final_landmarks');

disp('All images processed');
