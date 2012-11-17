function [innode nodenum distV]=selectbyslope(LocX_Y,LocY_Y,LocX_X,LocY_X,matchnode,Xcol)
 slopthr=0.02;%要改
 distthr=0.2;
 %对倾斜角和距离进行二维直方图统计，求标准倾斜角和距离
 [slopV distV tmpslopto]=slope(LocX_Y,LocY_Y,LocX_X,LocY_X,matchnode,Xcol);
 matcnum=size(matchnode,1);
 tmpinnode=zeros(matcnum,2);
 nodenum=0;
 newslopV=0;
 %利用标准倾斜角和距离剔除误匹配
 for i=1:matcnum
     tmpslop=atan((LocX_Y(matchnode(i,1))-LocX_X(matchnode(i,2)))/(LocY_Y(matchnode(i,1))+Xcol-LocY_X(matchnode(i,2))));
     dist=(LocX_Y(matchnode(i,1))-LocX_X(matchnode(i,2)))^2+(LocY_Y(matchnode(i,1))+Xcol-LocY_X(matchnode(i,2)))^2;
     if abs(tmpslop-slopV)<slopthr && abs(dist-distV)<distthr*distV
         newslopV=(newslopV*nodenum+tmpslop)/(nodenum+1);
         nodenum=nodenum+1;
         tmpinnode(nodenum,:)=matchnode(i,:);
     end
 end
 innode=tmpinnode(1:nodenum,:);
 
end
