close all
clear all
%% files and parameters management
%Original_frame1 = imread("Inputs/frame5.png");
%Original_frame2 = imread("Inputs/frame6.png");
%try with this for a single white object moving on a black background
Original_frame1 = rgb2gray(imread("ExtractedFrames\frame_0051.png"));
Original_frame2 = rgb2gray(imread("ExtractedFrames\frame_0053.png"));
frame1 = double(Original_frame1);
frame2 = double(Original_frame2);
Height = size(frame1,1);
Width = size(frame1,2);
%square window size ( K has to be odd because the central pixel is the processed pixel)
K = 5;
%% computation of E_x , E_y and E_t
% for x and y derivatives, we will use the derivation by differentiation
% the value after(+1) and before(-1). this means that the borders won't have a
% derivative.(side borders cant have derivatives for x and top and bottom
% borders cant have derivatives for y so no derivatives in general on
% borders). This spots will have 0s but keep in mind that they are unusable
E_x = zeros(Height,Width);
E_x(:,2:Width-1)=(frame1(:,3:Width)-frame1(:,1:Width-2))/2;

E_y = zeros(Height,Width);
E_y(2:Height-1,:)=(frame1(3:Height,:)-frame1(1:Height-2,:))/2;

E_t = (frame2-frame1);

%% u and v for each portion
% due to the size of the window and the borders not having derivative
% values, we have to exclude 1 + floor(K/2) pixels from each border E.g. if
% K = 5 than we will have a 3 sized border without any information.
d = zeros(Height,Width,2); % the 3 dimensional tensor containing the velocities u and v for each pixel

%for matrices that are non-invertible ( rank different than 2), we will add
%regularisation
epsilon = 10^-6;%regularisation factor.
%for those that have very small eigenvalues , the regularisation factor
%will also set a low threshold that the eigenvalue cannot exceed
%it will also resolve any ill-conditioned matrice related issues


for i=(1 + (1 + floor(K/2))):(Height - (1 + floor(K/2))) %goes through all pixels from bottom to top except the excluded borders
    for j=(1 + (1 + floor(K/2))):(Width - (1 + floor(K/2))) %goes through all pixels from left to right except the excluded borders
        %compute matrice A
        A = [reshape(E_x((i-floor(K/2)):(i+floor(K/2)),(j-floor(K/2)):(j+floor(K/2)))',K^2,1) reshape(E_y((i-floor(K/2)):(i+floor(K/2)),(j-floor(K/2)):(j+floor(K/2)))',K^2,1)];
        %compute array b
        b = [reshape(E_t((i-floor(K/2)):(i+floor(K/2)),(j-floor(K/2)):(j+floor(K/2)))',K^2,1)];
        %A^T A
        temp1 = (A' * A);
        %regularisation with epsiolon if rank different from2, if
        %eigenvalue too low or if ill-conditionned with a threshold of
        %1/epsilon
        if rank(temp1)~=2||(min(abs(temp1(1,1)),abs(temp1(2,2)))<epsilon)||(max(abs(temp1(1,1)),abs(temp1(2,2)))/min(abs(temp1(1,1)),abs(temp1(2,2))))>(1/(epsilon))
            temp1 = temp1 + epsilon * eye(2);
        end
        %- A^T b
        temp2 = (-(A' * b));
        %solve A^T A * d = - A^T b
        temp = temp1 \ temp2;
        d(i,j,:) = temp;
        
    end
end

%% plots
figure
imshow(Original_frame1);
hold on
quiver(1:Width, 1:Height, reshape(d(:,:,1),Height,Width), reshape(d(:,:,2),Height,Width),'r','LineWidth', 1.5, 'AutoScaleFactor', 6);
title('first frame overlayed with the optical flow ')
figure
imshow(Original_frame2);
hold on
quiver(1:Width, 1:Height, reshape(d(:,:,1),Height,Width), reshape(d(:,:,2),Height,Width),'r','LineWidth', 1.5, 'AutoScaleFactor', 6);
title('second frame overlayed with the optical flow ')
figure
imshow(uint8(0.5*(256+E_t)));
hold on
quiver(1:Width, 1:Height, reshape(d(:,:,1),Height,Width), reshape(d(:,:,2),Height,Width),'r','LineWidth', 1.5, 'AutoScaleFactor', 6);
title('time derivative(E_t) overlayed with the optical flow ')
figure
quiver(1:Width, Height:-1:1, reshape(d(:,:,1),Height,Width), reshape(d(:,:,2),Height,Width),'k','LineWidth', 1.5, 'AutoScaleFactor', 6);
title('optical flow')
xlim([1 Width])
ylim([1 Height])