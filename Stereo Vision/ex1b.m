load('ex1a_data.mat');
data_3D = readtable("inputs/calibration_points3.txt");
data_3D = table2array(data_3D);
format short
%% Projection matrix M for right
%%matrix composition for direct linear calibration
A = [];
for i=1:12
    A = [A
        data_3D(i,:) 1 zeros(1,4) -RightPoints(i,1).*data_3D(i,:) -RightPoints(i,1)
        zeros(1,4) data_3D(i,:) 1 -RightPoints(i,2).*data_3D(i,:) -RightPoints(i,2)];
end

clear i
%%we have the data matrix at this point, now we need to interpolate to find
%%M
[U,D,V] = svd(A);
Mvec = V(:,end);

M_Right = reshape(Mvec,4,3)';

%% K,R and T for Right
m1 = M_Right(1,1:3);
m2 = M_Right(2,1:3);
m3 = M_Right(3,1:3);
m14 = M_Right(1,4);
m24 = M_Right(2,4);
m34 = M_Right(3,4);

r3 = m3;
cx = m1*m3';
cy = m2*m3';
fx = norm(cross(m1,m3));
fy = norm(cross(m2,m3));
r1 = (m1-cx.*m3)./fx;
r2 = (m2-cy.*m3)./fy;
tx = (m14 -cx*m34)/fx;
ty = (m24 -cy*m34)/fy;
tz = m34;

R_right = [r1;r2;r3];
T_right = [tx;ty;tz];
K_right = [fx  0   cx
           0   fy  cy
           0   0   1];

%% Projection matrix M for left
%%matrix composition for direct linear calibration
A = [];
for i=1:12
    A = [A
        data_3D(i,:) 1 zeros(1,4) -LeftPoints(i,1).*data_3D(i,:) -LeftPoints(i,1)
        zeros(1,4) data_3D(i,:) 1 -LeftPoints(i,2).*data_3D(i,:) -LeftPoints(i,2)];
end
clear i
%%we have the data matrix at this point, now we need to interpolate to find
%%M
[U,D,V] = svd(A);
Mvec = V(:,end);
M_Left = reshape(Mvec,4,3)';

%% K,R and T for Left
m1 = M_Left(1,1:3);
m2 = M_Left(2,1:3);
m3 = M_Left(3,1:3);
m14 = M_Left(1,4);
m24 = M_Left(2,4);
m34 = M_Left(3,4);

r3 = m3;
cx = m1*m3';
cy = m2*m3';
fx = norm(cross(m1,m3));
fy = norm(cross(m2,m3));
r1 = (m1-cx.*m3)./fx;
r2 = (m2-cy.*m3)./fy;
tx = (m14 -cx*m34)/fx;
ty = (m24 -cy*m34)/fy;
tz = m34;


R_left = [r1;r2;r3];
T_left = [tx;ty;tz];
K_left = [fx  0   cx
           0   fy  cy
           0   0   1];

%% clearing and saving
clear tx ty tz r1 r2 r3 fx fy cx cy m14 m24 m34 m1 m2 m3 U V D Mvec A CalibPoints data_3D Left Right
save("ex1b_data");
disp('1.b.')
disp('The M matrices for each image are : ')
disp('right M : ')
disp(M_Right)
disp('left M : ')
disp(M_Left)
disp('The K,R and T matrices for each image are : ')
disp('right K : ')
disp(K_right)
disp('right R : ')
disp(R_right)
disp('right T : ')
disp(T_right)
disp('left K : ')
disp(K_left)
disp('left R : ')
disp(R_left)
disp('left T : ')
disp(T_left)
disp('see value in the workspace for scientific notation')