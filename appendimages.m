% im = appendimages(image1, image2)
%
% Return a new image that appends the two images side-by-side.

function im = appendimages(image1, image2)

% Select the image with the fewest rows and fill in enough empty rows
%   to make it the same height as the other image.
rows1 = size(image1,1);
rows2 = size(image2,1);

dim = size(image1,3);

if (rows1 < rows2)
     image1(rows2,1,1:dim) = 0;
else
     image2(rows1,1,1:dim) = 0;
end

% Now append both images side-by-side.
im = [image1 image2];   
