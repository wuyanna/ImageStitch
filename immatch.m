function [matchnode]=immatch(pic1moment,pic1cornum,pic2moment,pic2cornum)
%rigorlef:1取左边的5/12,1则取右边的
%注意数字图像中x方向为行下标，
 %pic1的点在pic2中找最匹配点
 %matarr=zeros(1,num);

 tmpmatchnode=zeros(pic1cornum,2);
 index=0;
 
 for i=1:pic1cornum
     sampleM=pic1moment(i,:);
     object=findmatch(sampleM,pic2moment,pic2cornum);
     revobject=inf;
     if object<=pic2cornum && object>0
         sampleM=pic2moment(object,:);
         revobject=findmatch(sampleM,pic1moment,pic1cornum);
         %%revobject=i;%%
     end
     
     %判断是否一一映射
     if revobject==i
         index=index+1;
         tmpmatchnode(index,:)=[i,object];
     end
 end
 matchnode=tmpmatchnode(1:index,:);
end

%利用相对距离之和
function [object similar]=findmatch(sampleM,pic2moment,pic2cornum)
%rigorlef:1取左边的5/12,1则取右边的
%注意数字图像中x方向为行下标，
 %pic1的点在pic2中找最匹配点
 %matarr=zeros(1,num);
 num=size(pic2moment,2);
 
 factor=0.9;%0.8
 targ=inf;
 object=inf;
 
      mini=1;
      secmin=inf;
     for j=1:pic2cornum
         %换基于双目立体视觉的三维重构研究38页和互相关度其它相似指标看看   
         similar=0;
         for k=1:num
             similar=similar+abs(pic2moment(j,k)-sampleM(k))/(abs(pic2moment(j,k))+abs(sampleM(k))+eps);
         end
         similar=similar/num;
         if similar<mini
             secmin=mini;
             mini=similar;
             targ=j;
         elseif similar<secmin
             secmin=similar;
         end
     end

     if mini<factor*secmin
         object=targ;
     end
end