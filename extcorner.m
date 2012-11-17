%Harris角点检测算子 先做高斯平滑 在求梯度

function [fLocXL,fLocYL,fcountL,fLocXR,fLocYR,fcountR,tmp]=extcorner(ima,factor,L,R)
%rigorlef:1取左边的5/12,1则取右边的
fLocXL=[];
fLocYL=[];
fcountL=0;
fLocXR=[];
fLocYR=[];
fcountR=0;
tmp=[];
if nargin<2
    factor=0.41667;
    L=1;
    R=1;
end
[imr,imc]=size(ima);
saY=round(imc*factor);
%对图像左边5/12的区域提取特征点
if L==1
Input=ima(:,1:saY);
[fLocXL,fLocYL,fcountL,tmp]=hari(Input);
end

%对图像右边5/12的区域提取特征点
if R==1
Input=ima(:,imc-saY+1:imc);
[fLocXR,fLocYR,fcountR,tmp]=hari(Input);
fLocYR=fLocYR+imc-saY;
end

end






