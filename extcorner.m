%Harris�ǵ������� ������˹ƽ�� �����ݶ�

function [fLocXL,fLocYL,fcountL,fLocXR,fLocYR,fcountR,tmp]=extcorner(ima,factor,L,R)
%rigorlef:1ȡ��ߵ�5/12,1��ȡ�ұߵ�
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
%��ͼ�����5/12��������ȡ������
if L==1
Input=ima(:,1:saY);
[fLocXL,fLocYL,fcountL,tmp]=hari(Input);
end

%��ͼ���ұ�5/12��������ȡ������
if R==1
Input=ima(:,imc-saY+1:imc);
[fLocXR,fLocYR,fcountR,tmp]=hari(Input);
fLocYR=fLocYR+imc-saY;
end

end






