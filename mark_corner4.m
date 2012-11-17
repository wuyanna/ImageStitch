function [M]=mark_corner4(A,LocX,LocY,counter)
win=2;
[nr,nc,dim]=size(A);
if dim==1
    M(:,:,1)=A;
    M(:,:,2)=A;
    M(:,:,3)=A;
elseif dim==3
    M=A;
end
for i=1:counter
    leftb=LocX(i)-win;
    rightb=LocX(i)+win;
    upb=LocY(i)-win;
    downb=LocY(i)+win;
    if leftb<1
        leftb=1;
    end
    if rightb>nc
        rightb=nc;
    end
    if upb<1
        upb=1;
    end
    if downb>nr
        downb=nr;
    end

        M(LocX(i),upb:downb,2:3)=0;
        M(LocX(i),upb:downb,1)=255;
   
        M(leftb:rightb,LocY(i),2:3)=0;
        M(leftb:rightb,LocY(i),1)=255;
end;
