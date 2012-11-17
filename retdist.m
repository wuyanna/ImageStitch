function [pic_1 pic_2 d] = retdist(pic_1,pic_2)
%clear all;
%reply = '';
numofpic=2; %图像数目
imname='图像拼接';
%读取图像
 pic(1).colima=pic_1;%MPG4618,3905,MPG3916,1354,1355,1358,(672,674),667,669,319,321,
 pic(2).colima=pic_2;%MPG0527,MPG1196,MPG1195,MPG1191,775,779


 %转灰度图
for i=1:numofpic
    pic(i).image=double(rgb2gray(pic(i).colima));
end


%提取模板图像的特征点并显示及分布
%N=mark_corner4(pic(1).colima,[pic(1).Lcornerx pic(1).Rcornerx],[pic(1).Lcornery pic(1).Rcornery],pic(1).Lcornum+pic(1).Rcornum);
%N=uint8(N);

%figure;
%imshow(N);


%提取匹配图像的特征点并显示及分布
for i=1:numofpic
    [pic(i).Lcornerx,pic(i).Lcornery,pic(i).Lcornum,pic(i).Rcornerx,pic(i).Rcornery,pic(i).Rcornum,tmpX]=extcorner(pic(i).image);
end

midnum=floor((1+numofpic)/2);
%从左到右拓展图片
%即为右边图往左边图粘贴
direction=1;
i=midnum;
while( midnum<=i && i<=numofpic-1)
    colima1=pic(i).colima;
    cornerx1=pic(i).Rcornerx;
    cornery1=pic(i).Rcornery;
    cornum1=pic(i).Rcornum;
    colima2=pic(i+1).colima;
    cornerx2=pic(i+1).Lcornerx;
    cornery2=pic(i+1).Lcornery;
    cornum2=pic(i+1).Lcornum;
    [distV nodenum]=matchAndresolH(colima1,cornerx1,cornery1,cornum1,colima2,cornerx2,cornery2,cornum2,direction);
    i=i+1;
end

%从右到左拓展图片
%即为左边图往右边图粘贴
direction=2;
i=midnum;
while( 2<=i && i<=midnum)
    colima1=pic(i).colima;
    cornerx1=pic(i).Lcornerx;
    cornery1=pic(i).Lcornery;
    cornum1=pic(i).Lcornum;
    colima2=pic(i-1).colima;
    cornerx2=pic(i-1).Rcornerx;
    cornery2=pic(i-1).Rcornery;
    cornum2=pic(i-1).Rcornum;
    [distV nodenum]=matchAndresolH(colima1,cornerx1,cornery1,cornum1,colima2,cornerx2,cornery2,cornum2,direction);
    i=i-1;
end
%如果匹配点数少于20，则用sift算法进行匹配
% if nodenum/min(size(pic(1).image,1)*size(pic(1).image,2),size(pic(2).image,1)*size(pic(2).image,2)) <= 2e-4
%     for i=1:numofpic
%         [pic(i).im, pic(i).des, pic(i).loc] = sift(pic(i).colima);
%     end;    
%     distRatio = 0.6;   
% % For each descriptor in the first image, select its match to second image.
%     pic(2).dest = pic(2).des';                          % Precompute matrix transpose
%     for i = 1 : size(pic(1).des1,1)
%         dotprods = pic(1).des(i,:) * pic(2).dest;        % Computes vector of dot products
%         [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results
% 
%    % Check if nearest neighbor has angle less than distRatio times 2nd.
%         if (vals(1) < distRatio * vals(2))
%             match(i) = indx(1);
%         else
%             match(i) = 0;
%         end
%     end
%     pic(1).cols = size(pic(1).im,2);
%     num = sum(match > 0);
%     matchnode = [];
%     j = 1;
%     for i = 1:size(match,2)
%         if(match(1,i)>0)
%            matchnode(j,1) = i;
%             matchnode(j,2) = match(1,i);
%             j = j+1;
%         end;
%     end;
%     [selbyslono nodenum distV]=selectbyslope(pic(1).loc(:,1),pic(1).loc(:,2),pic(2).loc(:,1),pic(2).loc(:,2),matchnode,pic(1).cols);
% end
d1=sqrt(distV);
d=round(d1);
