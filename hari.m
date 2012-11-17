%Harris角点检测算子 先做高斯平滑 在求梯度

function [fLocX,fLocY,fcount,tmp]=hari(Input)
[saX,saY]=size(Input);
win=5;% 原为6,5



var=0.7;
for i=1:3
    for j=1:3
        gauW(i,j)=1/(2*pi*var^2)*exp(-((i-2)^2+(j-2)^2)/(2*var^2));
    end;
end;

[dimX,dimY]=size(Input);

for i=2:dimX-1
    for j=2:dimY-1
        Input2(i-1,j-1)=Input(i-1,j-1)*gauW(1,1)+Input(i-1,j)*gauW(1,2)+Input(i-1,j+1)*gauW(1,3)+Input(i,j-1)*gauW(2,1)+Input(i,j)*gauW(2,2)+Input(i,j+1)*gauW(2,3)+Input(i+1,j-1)*gauW(3,1)+Input(i+1,j)*gauW(3,2)+Input(i+1,j+1)*gauW(3,3);
    end;
end;

[dimX2,dimY2]=size(Input2);

for i=2:dimX2-1
    for j=2:dimY2-1
        diffX(i-1,j-1)=Input2(i+1,j)-Input2(i-1,j);
        diffY(i-1,j-1)=Input2(i,j+1)-Input2(i,j-1);
    end;
end;


[sdfX,sdfY]=size(diffX);

A=diffX.*diffX;
B=diffY.*diffY;
C=diffX.*diffY;

delx=[-3 -3 -3 -2 -2 -2 -2 -2 -1 -1 -1 -1 -1 -1 -1  0  0  0 0 0 0 0  1  1  1 1 1 1 1  2  2 2 2 2  3 3 3];
dely=[-1  0  1 -2 -1  0  1  2 -3 -2 -1  0  1  2  3 -3 -2 -1 0 1 2 3 -3 -2 -1 0 1 2 3 -2 -1 0 1 2 -1 0 1];

var=1;
AA=zeros(sdfX-6,sdfY-6);
BB=zeros(sdfX-6,sdfY-6);
CC=zeros(sdfX-6,sdfY-6);

for i=4:sdfX-3
    for j=4:sdfY-3
        x0=i;
        y0=j;
        sum1=0;
        sum2=0;
        sum3=0;
        for k=1:37
            sum1=sum1+A(x0+delx(k),y0+dely(k))*exp(-(delx(k)^2+dely(k)^2)/(2*var^2));
            sum2=sum2+B(x0+delx(k),y0+dely(k))*exp(-(delx(k)^2+dely(k)^2)/(2*var^2));
            sum3=sum3+C(x0+delx(k),y0+dely(k))*exp(-(delx(k)^2+dely(k)^2)/(2*var^2));
        end;
        AA(i-3,j-3)=sum1;
        BB(i-3,j-3)=sum2;
        CC(i-3,j-3)=sum3;
    end;
end;

k=0.2;%0.2

[xAA,yAA]=size(AA);
        
Det=AA.*BB-CC.*CC;
Trace=AA+BB;
Rsp=Det-k*(Trace.*Trace);


minr=min(min(Rsp));
maxr=max(max(Rsp));

tmp=(Rsp-minr)/(maxr-minr);

nodenummin=60;%可能 原60
nodenummax=100;%要改
bei=10;%原 100

count=0;
lastcount=0;
while(1)
    icount=0;%初始角点数目
    T=10000*bei;
    iLocX=0;
    iLocY=0;
    for i=1:xAA
        for j=1:yAA
            if Rsp(i,j)>T
                icount=icount+1;
                iLocX(icount)=i;%初始角点的X坐标
                iLocY(icount)=j;%初始角点的Y坐标
            end;
        end;
    end;
   % icount
    fcount=0;%最终角点数目
    
    %利用Non-maximum Suppression算法求得最终角点
    for i=1:icount
        flag=0;
        if iLocX(i)>win && iLocY(i)>win && iLocX(i)<xAA-win && iLocY(i)<yAA-win
            for j=-win:win
                for k=-win:win
                    tmpR=Rsp(iLocX(i)+j,iLocY(i)+k);
                    if tmpR>Rsp(iLocX(i),iLocY(i))
                        flag=1;
                        break;
                    end
                end
            end;
            if abs(flag)<0.0001
                fcount=fcount+1;
                fLocX(fcount)=iLocX(i)+5;%最终角点的X坐标
                fLocY(fcount)=iLocY(i)+5;%最终角点的Y坐标
            end;
        end;
    end;
    
    if fcount<nodenummin
        bei=bei-10;
    else
        break;
    end
    
    if lastcount==fcount
        count=count+1;
        if count>10
            break;
        end
    end
    lastcount=fcount;
end

end





