function [distV nodenum]=matchAndresolH(colima1,cornerx1,cornery1,cornum1,colima2,cornerx2,cornery2,cornum2,direction)
    %���HΪcolima2תΪcolima1
    %�����������Hu���������������
    moment1=GMoment(colima1,cornerx1,cornery1,cornum1);
    moment2=GMoment(colima2,cornerx2,cornery2,cornum2);
    %�������������ӳ���ƥ��
    [matchnode]=immatch(moment2,cornum2,moment1,cornum1);
 
    %��ʾ����ƥ����
    %showmatch(colima2,cornerx2,cornery2,colima1,cornerx1,cornery1,matchnode,direction);
    %momentt=pic(1).Rmoment(1,1:7)
    %reply = input('showmatch ��ʼ: ', 's');
       %momentt=pic(1).Rmoment(1,1:7)
    
     Xcol=size(colima1,2);
     selbyslono=0;
     %���ÿռ�ֲ��޳���ƥ��
    [selbyslono nodenum distV]=selectbyslope(cornerx2,cornery2,cornerx1,cornery1,matchnode,Xcol);
    %selbyslono=matchnode;%%%%%%
     %��ʾ�ռ�ֲ��޳���ƥ����ƥ����
    %showmatch(colima2,cornerx2,cornery2,colima1,cornerx1,cornery1,selbyslono,direction);
    %reply = input('showmatch б���޳���: ', 's');
    

end