%有融合的拼接
function [newim,difr,difc]=imstick(colimgb,colimga,estH,dif1r,dif1c,direction)
%cHA拼接到cHB
%注意数字图像中x方向为行下标，
%direction:1 为从左往右拓展图像； 2 为从右往左拓展图像
colimga=double(colimga);
colimgb=double(colimgb);
[arow acol dim]=size(colimga);
[brow bcol dim]=size(colimgb);

avertex=[1,1,arow,arow;1,acol,1,acol;1,1,1,1];
corr_avertex=estH*avertex;
corr_avertex(:,1)=corr_avertex(:,1)/corr_avertex(3,1);
corr_avertex(:,2)=corr_avertex(:,2)/corr_avertex(3,2);
corr_avertex(:,3)=corr_avertex(:,3)/corr_avertex(3,3);
corr_avertex(:,4)=corr_avertex(:,4)/corr_avertex(3,4);

corr_avertex(1,:)=corr_avertex(1,:)+dif1r;
corr_avertex(2,:)=corr_avertex(2,:)+dif1c;


imamaxr=ceil(max(corr_avertex(1,:)));
maxr=max(imamaxr,brow);

imaminr=floor(min(corr_avertex(1,:)));
minr=min(imaminr,1);%可能为负数和0

imamaxc=ceil(max(corr_avertex(2,:)));
maxc=max(imamaxc,bcol);

imaminc=floor(min(corr_avertex(2,:)));
minc=min(imaminc,1);



newr=maxr-minr+1;
newc=maxc-minc+1;
difr=1-minr;
difc=1-minc;

newim=zeros(newr,newc,3);
newim(1+difr:brow+difr,1+difc:bcol+difc,:)=colimgb;

imanumr=imamaxr-imaminr+1;
imanumc=imamaxc-imaminc+1;
imaind=ones(3,imanumr*imanumc);

for i=1:imanumr
    imaind(1,imanumc*(i-1)+1:imanumc*i)=i+imaminr-1-dif1r;
    imaind(2,imanumc*(i-1)+1:imanumc*i)=(imaminc:imamaxc)-dif1c;
end

aind=(estH^-1)*imaind;
scale=aind(3,:);

if direction==1
    bound1=imaminc+difc;
    %bound3=bcol+difc;
    bound3=bcol+difc;
    %bound2=(bound1+bound3)/2;
    bound2=(bound1+bound3)/2;
    if bound1>bound3
        error('不是从左往右粘贴');
    end
elseif direction==2
    bound1=1+difc;
    bound3=imamaxc+difc;
    %bound3=bcol+difc;
    %bound2=(bound1+bound3)/2;
    bound2=(bound1+bound3)/2;
    if bound1>bound3
        error('不是从右往左粘贴');
    end
else
    error('请指定粘贴方向');
end

limen=200;%yuan80


for i=1:imanumr*imanumc
    aind(:,i)=aind(:,i)/scale(i);%线性插值
    upr=floor(aind(1,i));
    %downr=ceil(newind(1,i));
    leftc=floor(aind(2,i));
    q=aind(1,i)-upr;
    p=aind(2,i)-leftc;
    porta=(1-p)*(1-q);
    portb=(1-p)*q;
    portc=p*(1-q);
    portd=p*q;
    %rightc=ceil(newind(2,i));
    aa=zeros(1,1,3);
    if upr>=1 && upr<=arow && leftc>=1 && leftc<=acol
        aa=colimga(upr,leftc,:);
    end
    bb=zeros(1,1,3);
    if upr>=0 && upr<=arow-1 && leftc>=1 && leftc<=acol
        bb=colimga(upr+1,leftc,:);
    end
    cc=zeros(1,1,3);
    if upr>=1 && upr<=arow && leftc>=0 && leftc<=acol-1
        cc=colimga(upr,leftc+1,:);
    end
    dd=zeros(1,1,3);
    if upr>=0 && upr<=arow-1 && leftc>=0 && leftc<=acol-1
        dd=colimga(upr+1,leftc+1,:);
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
    
    newindr=imaind(1,i)+difr+dif1r;
    newindc=imaind(2,i)+difc+dif1c;
    
    imagray=zeros(1,1,3);
    if tolport~=0
    imagray=(porta*aa+portb*bb+portc*cc+portd*dd)/tolport;
    end

    newgray=newim(newindr,newindc,:);

   % if newgray==0
   %     newgray=imagray;
   %% elseif imagray~=0
   %     newgray=(imagray+newgray)/2;
    %end
    %带阈值的渐入渐出融合
    if newgray(1,1,1)==0 && newgray(1,1,2)==0 && newgray(1,1,3)==0 
        newgray=imagray;
    elseif imagray(1,1,1)~=0 && imagray(1,1,2)~=0 && imagray(1,1,3)~=0 
        if direction==1
            mid=(newgray*(bound3-newindc)+imagray*(newindc-bound1))/(bound3-bound1);
            if newindc<=bound2 
                if sum(abs(newgray-mid))<limen
                    newgray=mid;
                end
            else
                if sum(abs(imagray-mid))<limen
                    newgray=mid;
                else
                    newgray=imagray;
                end
            end
        else
            mid=(imagray*(bound3-newindc)+newgray*(newindc-bound1))/(bound3-bound1);
            if newindc>bound2 
                if sum(abs(newgray-mid))<limen
                    newgray=mid;
                end
            else
                if sum(abs(imagray-mid))<limen
                    newgray=mid;
                else
                    newgray=imagray;
                end
            end
        end
    end

    newim(imaind(1,i)+difr+dif1r,imaind(2,i)+difc+dif1c,:)=newgray;
    %if newind(1,i)>0 && newind(2,i)>0 && newind(1,i)<=yrow && newind(2,i)<=ycol
    %   newim(oldind(1,i),oldind(2,i))=cAY(newind(1,i),newind(2,i));
    %end
end
difr=difr+dif1r;
difc=difc+dif1c;
%newim=255*(newim-newimmin)/(newimmax-newimmin);
newim=uint8(newim);
figure
imshow(newim)
title('newim');
 
end


%无融合直接拼接
function [newim,difr,difc]=imstickb(colimgb,colimga,estH,dif1r,dif1c,direction)
%无融合直接拼接
%注意数字图像中x方向为行下标，
%direction:1 为从左往右拓展图像； 2 为从右往左拓展图像
colimga=double(colimga);
colimgb=double(colimgb);
[arow acol dim]=size(colimga);
[brow bcol dim]=size(colimgb);

avertex=[1,1,arow,arow;1,acol,1,acol;1,1,1,1];
corr_avertex=estH*avertex;
corr_avertex(:,1)=corr_avertex(:,1)/corr_avertex(3,1);
corr_avertex(:,2)=corr_avertex(:,2)/corr_avertex(3,2);
corr_avertex(:,3)=corr_avertex(:,3)/corr_avertex(3,3);
corr_avertex(:,4)=corr_avertex(:,4)/corr_avertex(3,4);

corr_avertex(1,:)=corr_avertex(1,:)+dif1r;
corr_avertex(2,:)=corr_avertex(2,:)+dif1c;


imamaxr=ceil(max(corr_avertex(1,:)));
maxr=max(imamaxr,brow);

imaminr=floor(min(corr_avertex(1,:)));
minr=min(imaminr,1);%可能为负数和0

imamaxc=ceil(max(corr_avertex(2,:)));
maxc=max(imamaxc,bcol);

imaminc=floor(min(corr_avertex(2,:)));
minc=min(imaminc,1);



newr=maxr-minr+1;
newc=maxc-minc+1;
difr=1-minr;
difc=1-minc;

newim=zeros(newr,newc,3);
newim(1+difr:brow+difr,1+difc:bcol+difc,:)=colimgb;

imanumr=imamaxr-imaminr+1;
imanumc=imamaxc-imaminc+1;
imaind=ones(3,imanumr*imanumc);

for i=1:imanumr
    imaind(1,imanumc*(i-1)+1:imanumc*i)=i+imaminr-1-dif1r;
    imaind(2,imanumc*(i-1)+1:imanumc*i)=(imaminc:imamaxc)-dif1c;
end

aind=(estH^-1)*imaind;
scale=aind(3,:);

if direction==1
    bound1=imaminc+difc;
    %bound3=bcol+difc;
    bound3=bcol+difc;
    %bound2=(bound1+bound3)/2;
    bound2=(bound1+bound3)/2;
    if bound1>bound3
        error('不是从左往右粘贴');
    end
elseif direction==2
    bound1=1+difc;
    bound3=imamaxc+difc;
    %bound3=bcol+difc;
    %bound2=(bound1+bound3)/2;
    bound2=(bound1+bound3)/2;
    if bound1>bound3
        error('不是从右往左粘贴');
    end
else
    error('请指定粘贴方向');
end

limen=80;%yuan80


for i=1:imanumr*imanumc
    aind(:,i)=aind(:,i)/scale(i);%线性插值
    upr=floor(aind(1,i));
    %downr=ceil(newind(1,i));
    leftc=floor(aind(2,i));
    q=aind(1,i)-upr;
    p=aind(2,i)-leftc;
    porta=(1-p)*(1-q);
    portb=(1-p)*q;
    portc=p*(1-q);
    portd=p*q;
    %rightc=ceil(newind(2,i));
    aa=zeros(1,1,3);
    if upr>=1 && upr<=arow && leftc>=1 && leftc<=acol
        aa=colimga(upr,leftc,:);
    end
    bb=zeros(1,1,3);
    if upr>=0 && upr<=arow-1 && leftc>=1 && leftc<=acol
        bb=colimga(upr+1,leftc,:);
    end
    cc=zeros(1,1,3);
    if upr>=1 && upr<=arow && leftc>=0 && leftc<=acol-1
        cc=colimga(upr,leftc+1,:);
    end
    dd=zeros(1,1,3);
    if upr>=0 && upr<=arow-1 && leftc>=0 && leftc<=acol-1
        dd=colimga(upr+1,leftc+1,:);
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
    
    newindr=imaind(1,i)+difr+dif1r;
    newindc=imaind(2,i)+difc+dif1c;
    
    imagray=(porta*aa+portb*bb+portc*cc+portd*dd)/tolport;
 
    newgray=newim(newindr,newindc,:);

    if sum(newgray)<=50
        newgray=imagray;
    end
    
    newim(imaind(1,i)+difr+dif1r,imaind(2,i)+difc+dif1c,:)=newgray;
    %if newind(1,i)>0 && newind(2,i)>0 && newind(1,i)<=yrow && newind(2,i)<=ycol
    %   newim(oldind(1,i),oldind(2,i))=cAY(newind(1,i),newind(2,i));
    %end
end
difr=difr+dif1r;
difc=difc+dif1c;
%newim=255*(newim-newimmin)/(newimmax-newimmin);
newim=uint8(newim);
figure
imshow(newim)
title('newim');
 
end
