function showmatch(im1,LocX1,LocY1,im2,LocX2,LocY2,matchnode,direction)
% Create a new image showing the two images side by side.
if direction==1
    im3 = appendimages(im2,im1);
    cols2 = size(im2,2);
else
    im3 = appendimages(im1,im2);
    cols2 = size(im1,2);
end


% Show a figure with lines joining the accepted matches.
%figure('Position', [100 100 size(im3,2) size(im3,1)]);
%colormap('gray');
%imagesc(im3);
figure
imshow(im3);
hold on;

matchnum=size(matchnode,1);
color=['y' 'm' 'c' 'r' 'g' 'b'];
if direction==1
    for i = 1: matchnum
        line([LocY2(matchnode(i,2)) LocY1(matchnode(i,1))+cols2], ...
            [LocX2(matchnode(i,2)) LocX1(matchnode(i,1))], 'Color', color(mod(i,6)+1),'LineWidth',1.5);
       % kk=(LocX2(matchnode(i,2))-LocX1(matchnode(i,1)))/(LocY2(matchnode(i,2))-LocY1(matchnode(i,1))-cols2);
       % for ii=LocY2(matchnode(i,2)):LocY1(matchnode(i,1))+cols2
        %    jj=uint8(kk*(ii-LocY2(matchnode(i,2)))+LocX2(matchnode(i,2)));
        %    im3(jj,ii,:)=[255 0 0];
        %end
        %imshow(im3);
    end
else
    for i = 1: matchnum
        line([LocY2(matchnode(i,2))+cols2 LocY1(matchnode(i,1))], ...
            [LocX2(matchnode(i,2)) LocX1(matchnode(i,1))], 'Color', color(mod(i,6)+1),'LineWidth',1.5);
    end
end

hold off;
title(['Found ', num2str(matchnum),' matches.']);

%imwrite(im3,'chushi.bmp');
end

function showmatchbeifen(im1,LocX1,LocY1,im2,LocX2,LocY2,matchnode)
% Create a new image showing the two images side by side.
im3 = appendimages(im1,im2);

% Show a figure with lines joining the accepted matches.
figure('Position', [100 100 size(im3,2) size(im3,1)]);
colormap('gray');
imagesc(im3);
hold on;
cols1 = size(im1,2);
matchnum=size(matchnode,1);
for i = 1: matchnum
    line([LocY1(matchnode(i,1)) LocY2(matchnode(i,2))+cols1], ...
         [LocX1(matchnode(i,1)) LocX2(matchnode(i,2))], 'Color', 'c');
end
hold off;
title(['Found ', num2str(matchnum),' matches.']);

end