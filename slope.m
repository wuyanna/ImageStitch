function [slopV distV tmpslop]=slope(LocX_Y,LocY_Y,LocX_X,LocY_X,matchnode,Xcol)

 slopthr=0.02;%要改
 distthr=0.2;
 matcnum=size(matchnode,1);
 sloparr=ones(matcnum,2);
 distarr=zeros(matcnum);
 slopnum=1;
 tmpslop(1)=atan((LocX_Y(matchnode(1,1))-LocX_X(matchnode(1,2)))/(LocY_Y(matchnode(1,1))+Xcol-LocY_X(matchnode(1,2))));
 dist(1)=(LocX_Y(matchnode(1,1))-LocX_X(matchnode(1,2)))^2+(LocY_Y(matchnode(1,1))+Xcol-LocY_X(matchnode(1,2)))^2;
 sloparr(slopnum,:)=[tmpslop 1];
 distarr(slopnum)=dist(1);
 for i=2:matcnum
     tmpslop(i)=atan((LocX_Y(matchnode(i,1))-LocX_X(matchnode(i,2)))/(LocY_Y(matchnode(i,1))+Xcol-LocY_X(matchnode(i,2))));
     dist(i)=(LocX_Y(matchnode(i,1))-LocX_X(matchnode(i,2)))^2+(LocY_Y(matchnode(i,1))+Xcol-LocY_X(matchnode(i,2)))^2;
     add=1;
     for j=1:slopnum
         if abs(tmpslop(i)-sloparr(j,1))<slopthr && abs(dist(i)-distarr(j))<distthr*distarr(j)
             sloparr(j,1)=(sloparr(j,1)*sloparr(j,2)+tmpslop(i))/(sloparr(j,2)+1);
             distarr(j)=(distarr(j)*sloparr(j,2)+dist(i))/(sloparr(j,2)+1);
             sloparr(j,2)=sloparr(j,2)+1;
             add=0;
             break;
         end
     end
     if add==1
         slopnum=slopnum+1;
         sloparr(slopnum,1)=tmpslop(i);
         distarr(slopnum)=dist(i);
     end
 end
 
 [num ind]=max(sloparr(:,2));%暂时不考虑有两个相同最大值
 slopV=sloparr(ind,1);
 distV=distarr(ind);
end
