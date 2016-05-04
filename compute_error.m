
%compute_error
%   compute the average point-to-point Euclidean error normalized by the
%   inter-ocular distance (measured as the Euclidean distance between the
%   outer corners of the eyes)
%
%   Inputs:
%          grounth_truth_all, size: num_of_points x 2 x num_of_images
%          detected_points_all, size: num_of_points x 2 x num_of_images
%   Output:
%          error_per_image, size: num_of_images x 1

load ibug_test_label.mat
load test_result.mat

num_of_images = size(final_image,4);
num_of_points = 68;
num_of_test_points = 17;



error_per_image = zeros(num_of_images,1);

for i =1:num_of_images
    detected_points      = final(:,i);
    detected_landmarks=zeros(17,2);
    detected_landmarks(:,1)=detected_points(1:2:end)*112+112;
    detected_landmarks(:,2)=detected_points(2:2:end)*112+112;
       
    
    ground_truth_points  = final_landmarks(:,i);
    ground_truth_landmarks = zeros(68,2);
    ground_truth_landmarks(:,1)=ground_truth_points(1:2:end)*112+112;
    ground_truth_landmarks(:,2)=ground_truth_points(2:2:end)*112+112;
    
    if num_of_points == 68
        interocular_distance = norm(mean(ground_truth_landmarks(37:42,:))-mean(ground_truth_landmarks(43:48,:)));  % norm((mean(shape_gt(37:42, :)) - mean(shape_gt(43:48, :))));
    elseif num_of_points == 51
        interocular_distance = norm(ground_truth_points(20,:) - ground_truth_points(29,:));
    elseif num_of_points == 29
        interocular_distance = norm(mean(ground_truth_points(9:2:17,:))-mean(ground_truth_points(10:2:18,:)));        
    else
        interocular_distance = norm(mean(ground_truth_points(1:2,:))-mean(ground_truth_points(end - 1:end,:)));        
    end
    
    sum=0;
    for j=1:num_of_test_points
        sum = sum+norm(detected_landmarks(j,:)-ground_truth_landmarks(j,:));
    end
    error_per_image(i) = sum/(num_of_test_points*interocular_distance);
end

