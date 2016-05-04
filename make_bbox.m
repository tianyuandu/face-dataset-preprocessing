%194 helen:
%1~41 contour (counter-clockwise)
%42~58 nose (counter-clockwise)
%59~114 lip (clockwise)
%115~134 right eye (clockwise)
%135~154 left eye (counter-clockwise)
%155~174 right eyebrow (clockwise)
%175~194 left eyebrow (counter-clockwise)

%68 landmarks:
%1~17 contour
%18~22 left eyebrow
%23~27 right eyebrow
%28~36 nose
%37~42 left eye
%43~48 right eye
%49~68 mouth

% rectangle('position',[nose_min(1),nose_min(2),nose_max(1)-nose_min(1),nose_max(2)-nose_min(2)]);
% rectangle('position',[face_dataset.roidb_train{1,1}.rois(i).boxes(j,1),face_dataset.roidb_train{1,1}.rois(i).boxes(j,2), ...
% face_dataset.roidb_train{1,1}.rois(i).boxes(j,3)-face_dataset.roidb_train{1,1}.rois(i).boxes(j,1),...
% face_dataset.roidb_train{1,1}.rois(i).boxes(j,4)-face_dataset.roidb_train{1,1}.rois(i).boxes(j,2)]);

for i=1:size(final_landmarks,2)
    landmarks=zeros(51,2);
    landmarks(:,1)=final_landmarks(35:2:end,i)*112+112;
    landmarks(:,2)=final_landmarks(36:2:end,i)*112+112;
    
    left_eyebrow_landmarks=landmarks(1:5,:);
    right_eyebrow_landmarks=landmarks(6:10,:);
    nose_landmarks=landmarks(11:19,:);
    left_eye_landmarks=landmarks(20:25,:);
    right_eye_landmarks=landmarks(26:31,:);
    mouth_landmarks=landmarks(32:51,:);
        
    face_dataset.roidb_train{1,1}.rois(i).gt=[1;1;1;1;1;1]; 
    face_dataset.roidb_train{1,1}.rois(i).overlap=zeros(6, 4, 'single');%compute later
    


    face_dataset.roidb_train{1,1}.rois(i).boxes=...
        single([round(min(left_eyebrow_landmarks(:,1)))-5 round(min(left_eyebrow_landmarks(:,2)))-5 round(max(left_eyebrow_landmarks(:,1)))+5 round(max(left_eyebrow_landmarks(:,2)))+5;...
        round(min(right_eyebrow_landmarks(:,1)))-5 round(min(right_eyebrow_landmarks(:,2)))-5 round(max(right_eyebrow_landmarks(:,1)))+5 round(max(right_eyebrow_landmarks(:,2)))+5;...
        round(min(left_eye_landmarks(:,1)))-5 round(min(left_eye_landmarks(:,2)))-5 round(max(left_eye_landmarks(:,1)))+5 round(max(left_eye_landmarks(:,2)))+5;...
        round(min(right_eye_landmarks(:,1)))-5 round(min(right_eye_landmarks(:,2)))-5 round(max(right_eye_landmarks(:,1)))+5 round(max(right_eye_landmarks(:,2)))+5;...
        round(min(nose_landmarks(:,1)))-5 round(min(nose_landmarks(:,2)))-5 round(max(nose_landmarks(:,1)))+5 round(max(nose_landmarks(:,2)))+5;...
        round(min(mouth_landmarks(:,1)))-5 round(min(mouth_landmarks(:,2)))-5 round(max(mouth_landmarks(:,1)))+5 round(max(mouth_landmarks(:,2)))+5]);
    
    face_dataset.roidb_train{1,1}.rois(i).feat=[];
    face_dataset.roidb_train{1,1}.rois(i).class=[1;1;2;2;3;4];

    for j = 1:6
  
        face_dataset.roidb_train{1,1}.rois(i).overlap(:,face_dataset.roidb_train{1,1}.rois(i).class(j)) = ...
      max(face_dataset.roidb_train{1,1}.rois(i).overlap(:,face_dataset.roidb_train{1,1}.rois(i).class(j)),...
      boxoverlap(face_dataset.roidb_train{1,1}.rois(i).boxes,face_dataset.roidb_train{1,1}.rois(i).boxes(j, :)));

    end    
% rectangle('position',[face_dataset.roidb_train{1,1}.rois(i).boxes(j,1),face_dataset.roidb_train{1,1}.rois(i).boxes(j,2), ...
% face_dataset.roidb_train{1,1}.rois(i).boxes(j,3)-face_dataset.roidb_train{1,1}.rois(i).boxes(j,1),...
% face_dataset.roidb_train{1,1}.rois(i).boxes(j,4)-face_dataset.roidb_train{1,1}.rois(i).boxes(j,2)]);

     %1:eyebrow,2:eye,3:nose,4:mouth
    
    
end
    
    