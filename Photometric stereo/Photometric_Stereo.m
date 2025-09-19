close all
clear all

%% Input, read images and light directions.

% images:

baseDir = 'Inputs/cat/Objects';  % Specify your folder path: change the fold name for different objects
%Objects : cat,frog,hippo,lizard,pig,scholar,turtle

%number of files :

files = dir(baseDir);% Get a list of all files and directories
files = files(~[files.isdir]); % Filter out directories
N = length(files);% Count the number of files

%read all images

firstImage = imread(fullfile(baseDir, sprintf('Image_01.png')));
[rows, cols] = size(firstImage);
I = zeros(rows, cols, N, 'like',firstImage); 
clear firstImage
for i = 1:N
    imageName = sprintf('Image_%02d.png', i);
    imagePath = fullfile(baseDir, imageName);
    I(:, :, i) = imread(imagePath);
end
I = flipud(I);% put upside down because images in png and their storage in matlab are opposite on the vertical axes.

%Compute shadow to remove parts of image that aren't the object

threshold = 200.0;%change threshold for different lighting intesities and objects. Use imshow(flipud(shadow)) to check if the contours are well defined or no.
shadow = (max(I,[],3)>threshold);
imshow(flipud(shadow));

%light directions:

filePath = 'Inputs/frog/light_directions.txt';
fileID = fopen(filePath, 'r');
S = fscanf(fileID, '%f');
fclose(fileID);
S = reshape(S,N,3);

%clear unused variables

clear baseDir fileID filePath i imageName imagePath threshold files 

%% gradient space coordinates of the normal
% Equations for all images:

I = double(reshape(I,rows*cols,N)');%reshape for optimization

%for each pixel location, from I=S*ñ we find ñ by applying least square
%approximation ñ = (S^T*S)^{-1}*S^T*I.
%next line works because in MATLAB, this expression will apply to each
%collumn of I individually

n_tilde = (S'*S)\(S'*I);
n = n_tilde./n_tilde(3,:);%normalization to have z = 1
n = reshape(n',rows,cols,[]);%reshape back for image sizes
n(~shadow) = NaN;%put NaN in locations part of the shadow to be able to remove them from the final result.
clear cols rows N I n_tilde S

%% depth map from normal vectors.

p = n(:,:,1);
q = n(:,:,2);
p(isnan(p)) = 0;
q(isnan(q)) = 0;

% remove the normal components for locations that are not part of the
% object.

p = p.*shadow;
q = q.*shadow;
Z = DepthFromGradient(p, q); %given function for Frankot-Chellappa algortihm
Z(isnan(n(:,:,1)) | isnan(n(:,:,2)) | isnan(n(:,:,3))) = NaN;
clear p q shadow 

%% Visualize depth map.

figure;
surf(-Z, 'EdgeColor', 'None', 'FaceColor', [0.5 0.5 0.5]); % we display the opposite for visual effect
axis equal; camlight;
view(-75, 30);
title("Depth map")
clear n