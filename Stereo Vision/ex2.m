load('ex1a_data.mat');
load('ex1b_data.mat');
load('ex2NewPoints_data');
data_3D = readtable("inputs/calibration_points3.txt");
data_3D = table2array(data_3D);
%% Resolution by SVD for calibration points
m1Tr = M_Right(1,:);
m2Tr = M_Right(2,:);
m3Tr = M_Right(3,:);
m1Tl = M_Left(1,:);
m2Tl = M_Left(2,:);
m3Tl = M_Left(3,:);

X1 = [];
for i=1:12
    xr = RightPoints(i,1);
    yr = RightPoints(i,2);
    xl = LeftPoints(i,1);
    yl = LeftPoints(i,2);
    A = [xr.*m3Tr - m1Tr
            yr.*m3Tr-m2Tr
            xl.*m3Tl-m1Tl
            yl.*m3Tl-m2Tl];
    [U,D,V]=svd(A);
    X1 = [X1,V(:,end)];
end
X1 = (X1(1:3,:)./X1(4,:))';
X = X1;
%% Resolution bt SVD for the new vertex points
X2 = [];
for i=1:18
    xr = NewRightPoints(i,1);
    yr = NewRightPoints(i,2);
    xl = NewLeftPoints(i,1);
    yl = NewLeftPoints(i,2);
    A = [xr.*m3Tr - m1Tr
            yr.*m3Tr-m2Tr
            xl.*m3Tl-m1Tl
            yl.*m3Tl-m2Tl];
    [U,D,V]=svd(A);
    X2 = [X2,V(:,end)];
end
X2 = (X2(1:3,:)./X2(4,:))';
X = [X;X2];

%% error estimation
errors = abs(X1 - data_3D);
error_mean = mean(errors(:));
error_max = max(errors(:));

%% 3D world reconstruction
figure
%% vertices
plot3(X(:,1),X(:,2),X(:,3),'g.','MarkerSize',20);
grid on
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('World reconstruction');
hold on
%% lines and patches
%% box
i=13;
j=14;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');
i=13;
j=17;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');
i=13;
j=16;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=14;
j=15;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=15;
j=16;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');
i=15;
j=19;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=16;
j=18;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=17;
j=18;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=18;
j=19;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

patch(X(13:16,1),X(13:16,2),X(13:16,3),[0.2 0.2 0.2]);
patch([X(13,1) X(16,1) X(18,1) X(17,1)],[X(13,2) X(16,2) X(18,2) X(17,2)],[X(13,3) X(16,3) X(18,3) X(17,3)],[0.2 0.2 0.2]);
patch([X(15:16,1) ;X(18:19,1)],[X(15:16,2) ;X(18:19,2)],[X(15:16,3) ;X(18:19,3)],[0.2 0.2 0.2]);
%% triangle base pyramid
i=20;
j=21;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');
i=20;
j=23;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=21;
j=22;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');
i=21;
j=23;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=22;
j=23;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

patch([X(20:21,1);X(23,1)],[X(20:21,2);X(23,2)],[X(20:21,3);X(23,3)],'r');
patch(X(21:23,1),X(21:23,2),X(21:23,3),'r');

%% cube
i=24;
j=25;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');
i=24;
j=27;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');
i=24;
j=28;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=25;
j=26;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=26;
j=27;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');
i=26;
j=30;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=27;
j=29;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=28;
j=29;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

i=29;
j=30;
plot3([X(i,1) X(j,1)],[X(i,2) X(j,2)],[X(i,3) X(j,3)],'k-');

patch(X(24:27,1),X(24:27,2),X(24:27,3),'y');
patch([X(24,1) X(27,1) X(29,1) X(28,1)],[X(24,2) X(27,2) X(29,2) X(28,2)],[X(24,3) X(27,3) X(29,3) X(28,3)],'y');
patch([X(26:27,1) ;X(29:30,1)],[X(26:27,2); X(29:30,2)],[X(26:27,3) ;X(29:30,3)],'y');
%% axes lines and patches
plot3([0 150],[0 0],[0 0],'k-');
plot3([0 0],[0 150],[0 0],'k-');
plot3([0 0],[0 0],[0 320],'k-');
plot3([0 0],[150 0],[320 320],'k-');
plot3([0 0],[150 150],[320 0],'k-');
plot3([150 0],[0 0],[320 320],'k-');
plot3([150 150],[0 0],[320 0],'k-');
patch([0 150 150 0],[0 0 0 0],[0 0 320 320],[0.5 0.5 0.5]);
patch([0 0 0 0],[0 150 150 0],[0 0 320 320],[0.5 0.5 0.5]);


%% answer display in command window clearing of intermediate variables
clear A D data_3D i j Left m1Tl m2Tl m3Tl m1Tr m2Tr m3Tr Right U V X xl xr yl yr
disp('2.a.')
format short
disp('The manually selected calibration points for the right image are RightPoints : ')
disp(RightPoints)
disp('The manually selected calibration points for the left image are LeftPoints : ')
disp(LeftPoints)
disp('The reconstructed coordinates of these points are X1 : ')
disp(X1)
disp('see long format values in the workspace')
disp('2.b.')
format long
disp('maximum error : ' + string(error_max))
disp('average error : ' + string(error_mean))
disp('see full error matrix in -errors- in the workspace')
disp('2.c.')
format short
disp('The manually selected vertices for the right image are NewRightPoints : ')
disp(NewRightPoints)
disp('The manually selected vertices for the left image are NewLeftPoints : ')
disp(NewLeftPoints)
disp('The reconstructed coordinates of these vertices are X2 : ')
disp(X2)
disp('see long format values in the workspace')