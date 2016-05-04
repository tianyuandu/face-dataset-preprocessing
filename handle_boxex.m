function new_ds = handle_boxex(ds,image)
%1.scale the box
%2.choose the box with most landmarks

SCALE=0.1; %zoom in 20%
new_ds=ds;

for i=1:size(ds,1)
    
    new_ds(i,1)=max( ds(i,1)-(ds(i,3)-ds(i,1))*SCALE , 1);
    new_ds(i,2)=max( ds(i,2)-(ds(i,4)-ds(i,2))*SCALE , 1);
    new_ds(i,3)=min( ds(i,3)+(ds(i,3)-ds(i,1))*SCALE , size(image,2));
    new_ds(i,4)=min( ds(i,4)+(ds(i,4)-ds(i,2))*SCALE , size(image,1));
    
end
end