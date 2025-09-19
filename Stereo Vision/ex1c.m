load('ex1b_data.mat');
data_3D = readtable("inputs/calibration_points3.txt");
data_3D = table2array(data_3D);
%% the world axes are directioned following 1 0 0 ; 0 1 0 ; 0 0 1 vectors and 000 is the origin
Axes = [0 0 0 1;1 0 0 1;0 1 0 1;0 0 1 1]';

%% for right image
Axes_Right = M_Right*Axes;
Axes_Right = Axes_Right(1:2,:)./Axes_Right(3,:);
Origin_Right = Axes_Right(:,1);
Directions_Right = Axes_Right(:,2:4);
Directions_Right = Directions_Right - Origin_Right;
NewAxesRight = [Origin_Right Origin_Right+100*Directions_Right];


%% for left image
Axes_Left = M_Left*Axes;
Axes_Left = Axes_Left(1:2,:)./Axes_Left(3,:);
Origin_Left = Axes_Left(:,1);
Directions_Left = Axes_Left(:,2:4);
Directions_Left = Directions_Left - Origin_Left;
NewAxesLeft = [Origin_Left Origin_Left+100*Directions_Left];


%% points for right and left images
PointsR = M_Right*[data_3D' ;ones(1,12)];
PointsR = PointsR(1:2,:)./PointsR(3,:);

PointsL = M_Left*[data_3D' ;ones(1,12)];
PointsL = PointsL(1:2,:)./PointsL(3,:);

%% displaying of the world axes and deletion of all the used variables
figure
right = imread("inputs\right.jpg");
imshow(right);
title('right image with world axes and calibration points');
hold on
plot(NewAxesRight(1,1:2),NewAxesRight(2,1:2),'b.-','Markersize',20);
plot(NewAxesRight(1,1:2:3),NewAxesRight(2,1:2:3),'b.-','Markersize',20);
plot(NewAxesRight(1,1:3:4),NewAxesRight(2,1:3:4),'b.-','Markersize',20);
plot(PointsR(1,:),PointsR(2,:),'r.','Markersize',20);
figure
left = imread("inputs\left.jpg");
imshow(left);
title('left image with world axes and calibration points');
hold on
plot(NewAxesLeft(1,1:2),NewAxesLeft(2,1:2),'b.-','Markersize',20);
plot(NewAxesLeft(1,1:2:3),NewAxesLeft(2,1:2:3),'b.-','Markersize',20);
plot(NewAxesLeft(1,1:3:4),NewAxesLeft(2,1:3:4),'b.-','Markersize',20);
plot(PointsL(1,:),PointsL(2,:),'r.','Markersize',20);
hold off
clear Axes Axes_Left Axes_Right data_3D Directions_Left Directions_Right left NewAxesLeft NewAxesRight Origin_Left Origin_Right PointsL PointsR right 