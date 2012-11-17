function pic = nolimscolor(IV1,IV2,d)
%IV1=imread('p1.jpg');
%IV2=imread('p2.jpg');
row1=size(IV1,1);
line1=size(IV1,2);
%d=171;
w=linearr(d);
GP1=zeros(row1,line1,3,'uint8');
GP2=zeros(row1,line1,3,'uint8');
GG1=IV1;
GG2=IV2;
GI1=zeros(row1,d,3,'uint8');
GI2=zeros(row1,d,3,'uint8');
%将两幅图的重叠部分分别放入GI1，GI2
for a=1:row1
    for b=1:d
        for c=1:3
            GI1(a,b,c)=GG1(a,b+line1-d,c);
            GI2(a,b,c)=GG2(a,b,c);
        end
    end
end
    
for a=1:row1
    for b=1:line1-d
        for c=1:3
            GP1(a,b,c)=GG1(a,b,c);
        end
    end
    for b=line1-d+1:line1
        for c=1:3
            GP1(a,b,c)=w(b-line1+d)*GI1(a,b-line1+d,c);
        end
    end
end
for a=1:row1
    for b=1:d
        for c=1:3
            GP2(a,b,c)=(1-w(b))*GI2(a,b,c);
        end
    end
    for b=(d+1):line1
        for c=1:3
            GP2(a,b,c)=GG2(a,b,c);
        end
    end
end
    
            
Z=zeros(row1,(line1-d),3,'uint8')
I1=[GP1 Z];
I2=[Z GP2];
pic=I1+I2;
%imshow(pic)