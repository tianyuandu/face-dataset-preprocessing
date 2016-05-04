function local_landmarks=process_landmarks(ds,global_landmarks)
    
    local_landmarks(:,1)=global_landmarks(:,1)-ds(1);
    local_landmarks(:,2)=global_landmarks(:,2)-ds(2);
    
end