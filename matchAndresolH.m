function [distV nodenum]=matchAndresolH(colima1,cornerx1,cornery1,cornum1,colima2,cornerx2,cornery2,cornum2,direction)
    %求的H为colima2转为colima1
    %给特征点分配Hu不变矩特征描述子
    moment1=GMoment(colima1,cornerx1,cornery1,cornum1);
    moment2=GMoment(colima2,cornerx2,cornery2,cornum2);
    %利用特征描述子初步匹配
    [matchnode]=immatch(moment2,cornum2,moment1,cornum1);
 
    %显示初步匹配结果
    %showmatch(colima2,cornerx2,cornery2,colima1,cornerx1,cornery1,matchnode,direction);
    %momentt=pic(1).Rmoment(1,1:7)
    %reply = input('showmatch 初始: ', 's');
       %momentt=pic(1).Rmoment(1,1:7)
    
     Xcol=size(colima1,2);
     selbyslono=0;
     %利用空间分布剔除误匹配
    [selbyslono nodenum distV]=selectbyslope(cornerx2,cornery2,cornerx1,cornery1,matchnode,Xcol);
    %selbyslono=matchnode;%%%%%%
     %显示空间分布剔除误匹配后的匹配结果
    %showmatch(colima2,cornerx2,cornery2,colima1,cornerx1,cornery1,selbyslono,direction);
    %reply = input('showmatch 斜率剔除后: ', 's');
    

end