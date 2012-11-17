function H=resolH(LocBX,LocBY,LocAX,LocAY)
num=length(LocBX);
 [TB,norBx,norBy]=normcoor(LocBX,LocBY,num);
 [TA,norAx,norAy]=normcoor(LocAX,LocAY,num);
 
 B=zeros(2*num,9);
 for i=1:num
     Bnod=[norBx(i),norBy(i),1];
     B(2*i-1,4:6)=-Bnod;
     B(2*i-1,7:9)=norAy(i)*Bnod;
     B(2*i,1:3)=Bnod;
     B(2*i,7:9)=-norAx(i)*Bnod;
 end
 %B

 [U,S,V]=svd(B);
 [row col]=size(V);
 h=V(:,col);
 H(1,1:3)=h(1:3);
 H(2,1:3)=h(4:6);
 H(3,1:3)=h(7:9);

 
 H=(TA^-1)*H*TB;
end

function [T,norax,noray]=normcoor(LocAX,LocAY,num)

 Ttr=diag([1 1 1]);
 averx=sum(LocAX)/num;
 avery=sum(LocAY)/num;
 Ttr(1,3)=-averx;
 Ttr(2,3)=-avery;
 %LocAX
 %LocAY
 rms=sqrt(sum((LocAX-averx).^2)+sum((LocAY-avery).^2)/num);
 %ss();
 p=sqrt(2)/rms;
 Tsca=diag([p p 1]);
 T=Tsca*Ttr;
 norax=p.*(LocAX-averx);
 noray=p.*(LocAY-avery);
end
