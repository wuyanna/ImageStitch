function [bestH innode Herr nodenum]=ransac(LocX_Y,LocY_Y,LocX_X,LocY_X,matchnode)
 N=Inf;
 count=0;
 num=4;
 e=0;%%%%��֪���Բ�
 samind=zeros(1,4);
 Herr=Inf;
 bestH=zeros(3,3);
 nodenum=0;%�ڵ���
 var=1;%����
 thr=sqrt(5.99)*var;%�ڵ㷧ֵ
 thr=3;%Ҫ��leadmatch�б���һ��
 s=4;
 p=0.99;
 fenzi=log(1-p);
 matcnum=size(matchnode,1);
 innode=Inf(matcnum,2);
 tmpin=Inf(matcnum,2);
 
 %���ѡ��num�鲻ͬ��Ӧ��
 %���õ������
 while N>count
     %�����ȡ4���Ӧ��
     samind(1,1)=randint(1,1,matcnum)+1;
     for i=2:num
         dosam=0;
         firsttime=1;
         while dosam==1 || firsttime==1
             dosam=0;
             firsttime=0;
             samind(1,i)=randint(1,1,matcnum)+1;
             for j=1:i-1
                 if samind(1,i)==samind(1,j)||matchnode(samind(1,i),2)==matchnode(samind(1,j),2)%ע������
                     dosam=1;
                     break
                 end
             end
         end
     end
     %���������ȡ��4���Ӧ����Ƶ�Ӧ����
     LocBX=LocX_Y(matchnode(samind,1));
     LocBY=LocY_Y(matchnode(samind,1));
     LocAX=LocX_X(matchnode(samind,2));
     LocAY=LocY_X(matchnode(samind,2));
     H=resolH(LocBX,LocBY,LocAX,LocAY);

    %��ÿ�Զ�Ӧ�������
     tmpnum=0;
     tmperr=0;
     revH=H^-1;
     for j=1:matcnum
         tmpb=ones(3,1);
         tmpb(1:2,1)=[LocX_Y(matchnode(j,1)),LocY_Y(matchnode(j,1))];
         tmpa=ones(3,1);
         tmpa(1:2,1)=[LocX_X(matchnode(j,2)),LocY_X(matchnode(j,2))];
         ima=H*tmpb;
         imb=revH*tmpa;
         ima=ima/ima(3,1);
         imb=imb/imb(3,1);
         dist=sum((ima-tmpa).^2)+sum((imb-tmpb).^2);
         tmperr=tmperr+dist;
         %�Լ���Ϊ���������һ��ֵ�������²����±���

          %ͳ�Ƶ�Ӧ������ڵ���
         if dist<thr
             tmpnum=tmpnum+1;
             tmpin(tmpnum,:)=matchnode(j,:);
         end
     end
     
     %��¼�ڵ������ĵ�Ӧ�������ڵ�
     if(tmpnum>nodenum)||(tmpnum==nodenum && tmperr<Herr)
         bestH=H;
         Herr=tmperr;
         innode=tmpin;
         nodenum=tmpnum;
     end
     
     %�����ڵ�������²�������
     if tmpnum~=0
         e=1-tmpnum/matcnum;
         N=fenzi/log(1-(1-e)^s);
         count=count+1;
     end
 end
 innode=innode(1:nodenum,:);
end
