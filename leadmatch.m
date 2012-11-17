function [innode nodenum]=leadmatch(estH,slopV,Xcol,LocX_Y,LocY_Y,LocX_X,LocY_X,colima2,colima1)
slopthr=0.02;
 nodenum=0;%内点数
 var=7;%方差
 thr=sqrt(5.99)*var;%内点阀值
 thr=4;%原4%要和ransac中保持一致
 Ynodenum=length(LocX_Y);
 %Xnodenum=length(LocX_X);
 tmpin=Inf(Ynodenum,2);
 revH=estH^-1;
 
 %利用当前单应矩阵estH做引导匹配
 for i=1:Ynodenum
     Ynode=[LocX_Y(i);LocY_Y(i);1];
     estXnode=estH*Ynode;
     estXnode=estXnode./estXnode(3,1);
     var=(LocX_X-estXnode(1,1)).^2+(LocY_X-estXnode(2,1)).^2;
     [dist matcind]=min(var);

     Xnode=[LocX_X(matcind);LocY_X(matcind);1];
     estYnode=revH*Xnode;
     estYnode=estYnode./estYnode(3,1);
     dist=dist+sum((Ynode-estYnode).^2);
     
     %引导匹配同样要满足空间方向约束
     tmpslop=atan((LocX_Y(i)-LocX_X(matcind))/(LocY_Y(i)+Xcol-LocY_X(matcind)));
     if dist<thr && abs(tmpslop-slopV)<slopthr
         nodenum=nodenum+1;
         tmpin(nodenum,:)=[i,matcind];
     end
 end
 innode=tmpin(1:nodenum,:);
end
