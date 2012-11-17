function moment=GMoment(colima,cornerx,cornery,cornum)
%注意数字图像中x方向为行下标
 %colima=rgb2gray(colima);
 
[ra ca wei]=size(colima);
 win=7;

 
 %matarr=zeros(1,num);
 moment=zeros(cornum,wei*7);
 tmpju=zeros(1,wei*7);
 
 for i=1:cornum
     [aup,adown,arwin]=bound(ra,cornerx(i),win);
     [aleft,aright,acwin]=bound(ca,cornery(i),win);
     for j=1:wei
         imA=colima(aup:adown,aleft:aright,j);
         tmpju(1,(j-1)*7+1:j*7)=qijieju(imA);
     end
    tmpju=normal(tmpju);
     moment(i,:)=tmpju;
 end
end
function Output=normal(Input)

  meanV=0;
  %meanV=sum(Input)/num;
  varV=sqrt(sum(abs(Input).^2));
  Output=(Input-meanV)./varV;
end

function [leftb,rightb,realcwin]=bound(col,y,cwin)
      leftb=y-cwin;
      rightb=y+cwin;
      if leftb<1
          leftb=1;
      end
      if rightb>col
          rightb=col;
      end
      realcwin=min(rightb-y,y-leftb);
      leftb=y-realcwin;
      rightb=y+realcwin;
end