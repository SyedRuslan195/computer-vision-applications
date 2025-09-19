Left = imread("Inputs\left.jpg");
imshow(Left);
title('click on the 12 calibration points')
LeftPoints = ginput(12);

Right = imread("Inputs\right.jpg");
imshow(Right);
title('click on the 12 calibration points')
RightPoints = ginput(12);

save('ex1a_data','RightPoints','LeftPoints');