function pic = imscolor(IV1,IV2,d)
%IV1=imread('p1.jpg');
%IV2=imread('p2.jpg');
row1=size(IV1,1);
line1=size(IV1,2);
%d=171;
w=linearr(d);
GP1=zeros(row1,line1,3,'uint8');
GP2=zeros(row1,line1,3,'uint8');
GG1=IV1;
G1=zeros(row1,line1,3,'uint8');
GG2=IV2;
G2=zeros(row1,line1,3,'uint8');
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
m1=mean(mean(GI1));%图1重叠部分平均值
m2=mean(mean(GI2));%图二重叠部分平均值
m1r=m1(:,:,1);
m1g=m1(:,:,2);
m1b=m1(:,:,3);
m2r=m2(:,:,1);
m2g=m2(:,:,2);
m2b=m2(:,:,3);
m=[(m1r-m2r)/2 (m1g-m2g)/2 (m1b-m2b)/2];%亮度调整值矩阵
%G1与G2为原图亮度调整后的图
for a=1:row1
    for b=1:line1
        for c=1:3
            G1(a,b,c)=GG1(a,b,c)-m(c);
            G2(a,b,c)=GG2(a,b,c)+m(c);
        end
    end
end

for a=1:row1
    for b=1:d
        for c=1:3
            GII1(a,b,c)=G1(a,b+line1-d,c);
            GII2(a,b,c)=G2(a,b,c);
        end
    end
end
    
for a=1:row1
    for b=1:line1-d
        for c=1:3
            GP1(a,b,c)=G1(a,b,c);
        end
    end
    for b=line1-d+1:line1
        for c=1:3
            GP1(a,b,c)=w(b-line1+d)*GII1(a,b-line1+d,c);
        end
    end
end
for a=1:row1
    for b=1:d
        for c=1:3
            GP2(a,b,c)=(1-w(b))*GII2(a,b,c);
        end
    end
    for b=(d+1):line1
        for c=1:3
            GP2(a,b,c)=G2(a,b,c);
        end
    end
end
    
            
Z=zeros(row1,(line1-d),3,'uint8')
I1=[GP1 Z];
I2=[Z GP2];
pic=I1+I2;
%imshow(pic)