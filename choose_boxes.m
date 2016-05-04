% choose the box with the most amount of landmarks
function [new_ds,num_landmarks]=choose_boxex(ds,global_landmarks)
    count=zeros(size(ds,1),1);
    for i=1:size(ds,1)
       
       for lines=1:size(global_landmarks,1)
           
           if (ds(i,1)<=global_landmarks(lines,1))*(global_landmarks(lines,1)<=ds(i,3))*...
                   (ds(i,2)<=global_landmarks(lines,2))*(global_landmarks(lines,2)<=ds(i,4))
               count(i)=count(i)+1;
           end
           
       end
       
       
    end
    [num_landmarks, I]=max(count);
    new_ds=ds(I,:);
end


