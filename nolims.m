function pic = nolims(IV1,IV2,d)
%IV1=imread('p1.jpg');
%IV2=imread('p2.jpg');
row1=size(IV1,1);
line1=size(IV1,2);
%d=retdist(IV1,IV2);%平移距离——由匹配图连线长度得到
%w=lim(IV1,IV2,d,row1);
w=linearr(d);
GP1=zeros(row1,line1,'uint8');
GP2=zeros(row1,line1,'uint8');
GG1=rgb2gray(IV1);
GG2=rgb2gray(IV2);
GI1=zeros(row1,d,'uint8');
GI2=zeros(row1,d,'uint8');
for a=1:row1
    for b=1:d
        GI1(a,b)=GG1(a,b+line1-d);
        GI2(a,b)=GG2(a,b);
    end
end

    
for a=1:row1
    for b=1:line1-d
        GP1(a,b)=GG1(a,b);
    end
    for b=line1-d+1:line1
        GP1(a,b)=w(b-line1+d)*GI1(a,b-line1+d);
    end
end
for a=1:row1
    for b=1:d
        GP2(a,b)=(1-w(b))*GI2(a,b);
    end
    for b=(d+1):line1
        GP2(a,b)=GG2(a,b);
    end
end
    
            
Z=zeros(row1,(line1-d))
I1=[GP1 Z];
I2=[Z GP2];
pic=I1+I2;
%imshow(pic)