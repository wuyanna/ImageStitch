function w = lim(GI1,GI2,d,row1)

w(1)=1;
w(2)=0.99;
w(d/2)=1/2;
w(d)=0;
for i=1:row1
    for j=2:(d/2-2)        
        w(j+1)=(w(j)*(2*(GI1(i,j)-GI2(i,j)))-((GI1(i,j)-GI2(i,j))-(GI1(i,j+1)-GI1(i,j-1)+GI2(i,j-1)-GI2(i,j+1))/2)*w(j-1))/((GI1(i,j)-GI2(i,j))+(GI1(i,j+1)-GI1(i,j-1)+GI2(i,j-1)-GI2(i,j+1))/2);
    end
    for j=(d/2):(d-2)
        w(j+1)=(w(j)*(2*(GI1(i,j)-GI2(i,j)))-((GI1(i,j)-GI2(i,j))-(GI1(i,j+1)-GI1(i,j-1)+GI2(i,j-1)-GI2(i,j+1))/2)*w(j-1))/((GI1(i,j)-GI2(i,j))+(GI1(i,j+1)-GI1(i,j-1)+GI2(i,j-1)-GI2(i,j+1))/2);
    end
end

            
            
    
    