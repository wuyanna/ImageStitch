function proimage=CylinPro(colima,focus)
%rigorlef:1取左边的5/12,1则取右边的
%注意数字图像中x方向为行下标，
 %pic1的点在pic2中找最匹配点
 %matarr=zeros(1,num);
% colima=imread('dian15.jpg');
 %figure
 %imshow(colima)
 colima=double(colima);
 %focus=415;%595.5,596,580,575,576,500,506;485,475

 [row,col,dim]=size(colima);
 
 corc=[1,col];
 procorc=focus*(atan((corc-col/2-0.5)/focus)+atan((col-1)/focus/2));
 %procorr=focus*(corr-row/2)./sqrt((corc-col/2).^2+focus^2)+row/2
 
 %minc=floor(procorc(1));
 %maxc=ceil(procorc(2));
 minc=ceil(procorc(1));
 maxc=floor(procorc(2));
 
 prorow=row;
 procol=maxc-minc+1;

 proimage=zeros(prorow,procol,dim);
 for i=1:prorow
     for j=1:procol
         proc=j+minc-1;%+minc-1;
         pror=i;
         proc=proc/focus-atan((col-1)/focus/2);
         colimar=0.5+row/2+(pror-row/2-0.5)*abs(sec(proc));
         colimac=0.5+col/2+focus*tan(proc);
         
         upr=floor(colimar);
         %downr=ceil(newind(1,i));
         leftc=floor(colimac);
         q=colimar-upr;
         p=colimac-leftc;
         porta=(1-p)*(1-q);
         portb=(1-p)*q;
         portc=p*(1-q);
         portd=p*q;
         
        % porta=sinc(p)*sinc(q);
        % portb=sinc(p)*sinc(1-q);
         %portc=sinc(1-p)*sinc(q);
         %portd=sinc(1-p)*sinc(1-q);
         %rightc=ceil(newind(2,i));
         aa=zeros(1,1,dim);
         if upr>=1 && upr<=row && leftc>=1 && leftc<=col
             aa=colima(upr,leftc,:);
         end
         bb=zeros(1,1,dim);
         if upr>=0 && upr<=row-1 && leftc>=1 && leftc<=col
             bb=colima(upr+1,leftc,:);
         end
         cc=zeros(1,1,dim);
         if upr>=1 && upr<=row && leftc>=0 && leftc<=col-1
             cc=colima(upr,leftc+1,:);
         end
         dd=zeros(1,1,dim);
         if upr>=0 && upr<=row-1 && leftc>=0 && leftc<=col-1
             dd=colima(upr+1,leftc+1,:);
         end

         tolport=0;
         if aa(1,1,1)~=0 && aa(1,1,2)~=0 && aa(1,1,3)~=0 
             tolport=tolport+porta;
         end
         if bb(1,1,1)~=0 && bb(1,1,2)~=0 && bb(1,1,3)~=0
             tolport=tolport+portb;
         end
         if cc(1,1,1)~=0 && cc(1,1,2)~=0 && cc(1,1,3)~=0
             tolport=tolport+portc;
         end
         if dd(1,1,1)~=0 && dd(1,1,2)~=0 && dd(1,1,3)~=0
             tolport=tolport+portd;
         end

          %proimage(i,j,:)=(porta*aa+portb*bb+portc*cc+portd*dd);
         if tolport~=0
             proimage(i,j,:)=(porta*aa+portb*bb+portc*cc+portd*dd)/tolport;
         end
     end
 end
 proimage=uint8(proimage);
 %figure
 %imshow(proimage)
end


function proimage=CylinProbb(colima)
%rigorlef:1取左边的5/12,1则取右边的
%注意数字图像中x方向为行下标，
 %pic1的点在pic2中找最匹配点
 %matarr=zeros(1,num);
% colima=imread('dian15.jpg');
 %figure
 %imshow(colima)
 colima=double(colima);
 %focus=415;%595.5,596,580,575,576,500,506;485,475
 focus=410;%410
 [row,col,dim]=size(colima);
 
 corc=[1,col];
 procorc=focus*(atan((corc-col/2-0.5)/focus)+atan((col-1)/focus/2));
 %procorr=focus*(corr-row/2)./sqrt((corc-col/2).^2+focus^2)+row/2
 
 %minc=floor(procorc(1));
 %maxc=ceil(procorc(2));
 minc=ceil(procorc(1));
 maxc=floor(procorc(2));
 
 prorow=row;
 procol=maxc-minc+1;

 proimage=zeros(prorow,procol,dim);
 for i=1:prorow
     for j=1:procol
         proc=j+minc-1;%+minc-1;
         pror=i;
         proc=proc/focus-atan((col-1)/focus/2);
         colimar=0.5+row/2+(pror-row/2-0.5)*abs(sec(proc));
         colimac=0.5+col/2+focus*tan(proc);
         
         upr=floor(colimar);
         %downr=ceil(newind(1,i));
         leftc=floor(colimac);
         q=colimar-upr;
         p=colimac-leftc;
         porta=(1-p)*(1-q);
         portb=(1-p)*q;
         portc=p*(1-q);
         portd=p*q;
         if upr>1 && leftc>1 && upr<row-2 && leftc<col-2
             A=[Weight(1+q) Weight(q) Weight(1-q) Weight(2-q)];
             A=A/sum(A);
             B=[colima(upr-1,leftc-1,:) colima(upr-1,leftc,:) colima(upr-1,leftc+1,:) colima(upr-1,leftc+2,:);
                colima(upr,leftc-1,:)   colima(upr,leftc,:)   colima(upr,leftc+1,:)   colima(upr,leftc+2,:);
                colima(upr+1,leftc-1,:) colima(upr+1,leftc,:) colima(upr+1,leftc+1,:) colima(upr+1,leftc+2,:);
                colima(upr+2,leftc-1,:) colima(upr+2,leftc,:) colima(upr+2,leftc+1,:) colima(upr+2,leftc+2,:)];
             C=[Weight(1+p);Weight(p);Weight(1-p);Weight(2-p)];
             C=C/sum(C);
             for ii=1:3
                 proimage(i,j,ii)=A*B(:,:,ii)*C;
             end
             
         end
         

     end
 end
 proimage=uint8(proimage);
 %figure
 %imshow(proimage)
end

function w=Weight(x)
 x=abs(x);
 w=0;
 if x<1
     w=1-2*x^2+x^3;
 elseif x>=1 && x<2
     w=4-8*x+5*x^2;
 end
end


function proimage=CylinProbb(colima)
%rigorlef:1取左边的5/12,1则取右边的
%注意数字图像中x方向为行下标，
 %pic1的点在pic2中找最匹配点
 %matarr=zeros(1,num);
% colima=imread('dian15.jpg');
 %figure
 %imshow(colima)
 colima=double(colima);
 %focus=415;%595.5,596,580,575,576,500,506;485,475
 focus=410;%410
 [row,col,dim]=size(colima);
 
 corc=[1,col];
 procorc=focus*(atan((corc-col/2-0.5)/focus)+atan((col-1)/focus/2));
 %procorr=focus*(corr-row/2)./sqrt((corc-col/2).^2+focus^2)+row/2
 
 %minc=floor(procorc(1));
 %maxc=ceil(procorc(2));
 minc=ceil(procorc(1));
 maxc=floor(procorc(2));
 
 prorow=row;
 procol=maxc-minc+1;

 proimage=zeros(prorow,procol,dim);
 for i=1:prorow
     for j=1:procol
         proc=j+minc-1;%+minc-1;
         pror=i;
         proc=proc/focus-atan((col-1)/focus/2);
         colimar=0.5+row/2+(pror-row/2-0.5)*abs(sec(proc));
         colimac=0.5+col/2+focus*tan(proc);
         
         upr=floor(colimar);
         %downr=ceil(newind(1,i));
         leftc=floor(colimac);
         q=colimar-upr;
         p=colimac-leftc;
         porta=(1-p)*(1-q);
         portb=(1-p)*q;
         portc=p*(1-q);
         portd=p*q;
         
        % porta=sinc(p)*sinc(q);
        % portb=sinc(p)*sinc(1-q);
         %portc=sinc(1-p)*sinc(q);
         %portd=sinc(1-p)*sinc(1-q);
         %rightc=ceil(newind(2,i));
         aa=zeros(1,1,dim);
         if upr>=1 && upr<=row && leftc>=1 && leftc<=col
             aa=colima(upr,leftc,:);
         end
         bb=zeros(1,1,dim);
         if upr>=0 && upr<=row-1 && leftc>=1 && leftc<=col
             bb=colima(upr+1,leftc,:);
         end
         cc=zeros(1,1,dim);
         if upr>=1 && upr<=row && leftc>=0 && leftc<=col-1
             cc=colima(upr,leftc+1,:);
         end
         dd=zeros(1,1,dim);
         if upr>=0 && upr<=row-1 && leftc>=0 && leftc<=col-1
             dd=colima(upr+1,leftc+1,:);
         end

         tolport=0;
         if aa(1,1,1)~=0 && aa(1,1,2)~=0 && aa(1,1,3)~=0 
             tolport=tolport+porta;
         end
         if bb(1,1,1)~=0 && bb(1,1,2)~=0 && bb(1,1,3)~=0
             tolport=tolport+portb;
         end
         if cc(1,1,1)~=0 && cc(1,1,2)~=0 && cc(1,1,3)~=0
             tolport=tolport+portc;
         end
         if dd(1,1,1)~=0 && dd(1,1,2)~=0 && dd(1,1,3)~=0
             tolport=tolport+portd;
         end

         if tolport~=0
             proimage(i,j,:)=(porta*aa+portb*bb+portc*cc+portd*dd)/tolport;
         end
     end
 end
 proimage=uint8(proimage);
 %figure
 %imshow(proimage)
end



function [matarr similar]=immatchxinbeifen(pic1,pic2)
%注意数字图像中x方向为行下标，
 
 %matarr=zeros(1,num);
 similar=ones(pic2.cornum,pic1.cornum);
 for i=1:pic1.cornum
     for j=1:pic2.cornum
     %换基于双目立体视觉的三维重构研究38页和互相关度其它相似指标看看   
     for k=1:7
         similar(j,i)=similar(j,i)-ajustsim(pic2.moment(j,k)/pic1.moment(i,k))/7;
     end
     mm=1;
     mm=similar(j,i);

     end
 end
 [V,matarr]=min(similar);
end

function y=ajustsim(x)
 y=x;
 if x>=1
     y=1/x;
 end
end

function [matarr h]=immatchbeifen(A,LocAX,LocAY,B,LocBX,LocBY)
%注意数字图像中x方向为行下标，
 C=uint8(A);
 D=uint8(B);
 [ra ca]=size(A);
 [rb cb]=size(B);
 win=10;
 numA=length(LocAX);
 numB=length(LocBX);
 
 %matarr=zeros(1,num);
 h=zeros(numB,numA);
 for i=1:numA
     [aup,adown,arwin]=bound(ra,LocAX(i),win);
     [aleft,aright,acwin]=bound(ca,LocAY(i),win);
     for j=1:numB
     [bup,bdown,brwin]=bound(rb,LocBX(j),win);
     [bleft,bright,bcwin]=bound(cb,LocBY(j),win);
    % up=max(aup,bup);
     %[rwin,indr]=min([arwin,brwin]);
    % [cwin,indc]=min([acwin,bcwin]);
     if arwin>brwin
        [aup,adown,arwin]=bound(ra,LocAX(i),brwin);
     elseif arwin<brwin
        [bup,bdown,brwin]=bound(rb,LocBX(j),arwin);
     end
     
     if acwin>bcwin
        [aleft,aright,acwin]=bound(ca,LocAY(i),bcwin);
     elseif acwin<bcwin
        [bleft,bright,bcwin]=bound(cb,LocBY(j),acwin);
     end
     %left=max(aleft,bleft);
     %right=min(aright,bright);
     
     imA=C(aup:adown,aleft:aright);
     imB=D(bup:bdown,bleft:bright);
     h(j,i)=minf(imA,imB);%换基于双目立体视觉的三维重构研究38页和互相关度其它相似指标看看
     mm=1;
     mm=h(j,i);

     end
 end
 [V,matarr]=max(h);
end


function ss()
reply = input('Do you want more? Y/N [Y]: ', 's');
if reply == 'y';
    return
end
end
function [leftb,rightb,realcwin]=bound(col,y,cwin)
      leftb=y-cwin;
      rightb=y+cwin;
     % ss();
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
function [leftb,rightb,upb,downb,realrwin,realcwin]=boundbeien(row,col,x,y,rwin,cwin)
      leftb=x-cwin;
      rightb=x+cwin;
      upb=y-rwin;
      downb=y+rwin;
     % ss();
      if leftb<1
          leftb=1;
      end
      if rightb>col
          rightb=col;
      end
      if upb<1
          upb=1;
      end
      if downb>row
          downb=row;
      end
      realrwin=min(downb-y,y-upb);
      realcwin=min(rightb-x,x-leftb);
end