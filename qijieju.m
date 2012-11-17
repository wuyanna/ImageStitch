function ju=qijieju(I0,num)
 A=double(I0);
 ju=zeros(1,7);
 [nr nc]=size(A);
 
 meanV=sum(sum(A))/nr/nc;
 %A=A-meanV;
  
 
 rad=min(nr,nc)/2;
 centr=(1+nr)/2;
 centc=(1+nc)/2;
 for i=1:nr
     for j=1:nc
         if (i-centr)^2+(j-centc)^2>=(rad-0.75)^2%0.75
             A(i,j)=0;
         end
     end
 end
 A;

 
 
 
 [x y]=meshgrid(1:nr,1:nc);
 x=x(:);
 y=y(:);
 A=A(:);
 m00=sum(A);
 if m00==0
     m00=eps;
 end
 m10=sum(x.*A);
 m01=sum(y.*A);
 xmean=m10/m00;
 ymean=m01/m00;
 
 cm00=m00;
 cm02=(sum((y-ymean).^2.*A))/(m00^2);
 cm03=(sum((y-ymean).^3.*A))/(m00^2.5);
 cm11=(sum((x-xmean).*(y-ymean).*A))/(m00^2);
 cm12=(sum((x-xmean).*(y-ymean).^2.*A))/(m00^2.5);
 cm20=(sum((x-xmean).^2.*A))/(m00^2);
 cm21=(sum((x-xmean).^2.*(y-ymean).*A))/(m00^2.5);
 cm30=(sum((x-xmean).^3.*A))/(m00^2.5);
 ju(1)=cm20+cm02;
 ju(2)=(cm20-cm02)^2+4*cm11^2;
 ju(3)=(cm30-3*cm12)^2+(3*cm21-cm03)^2;
 ju(4)=(cm30+cm12)^2+(cm21+cm03)^2;
 ju(5)=(cm30-3*cm12)*(cm30+cm12)*((cm30+cm12)^2-3*(cm21+cm03)^2)+(3*cm21-cm03)*(cm21+cm03)*(3*(cm30+cm12)^2-(cm21+cm03)^2);
 ju(6)=(cm20-cm02)*((cm30+cm12)^2-(cm21+cm03)^2)+4*cm11*(cm30+cm12)*(cm21+cm03);
 ju(7)=(3*cm21-cm03)*(cm30+cm12)*((cm30+cm12)^2-3*(cm21+cm03)^2)+(3*cm12-cm30)*(cm21+cm03)*(3*(cm30+cm12)^2-(cm21+cm03)^2);
  
 tmp=log(ju);
 ju=abs(log(ju));
 reply ='';
 %reply = input('ju: ', 's');
if reply == 'y'
    return;
end

 
end