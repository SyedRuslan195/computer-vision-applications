Left = imread("Inputs\left.jpg");
imshow(Left);
title('click on the 18 vertices of different objects')
NewLeftPoints = ginput(18);

Right = imread("Inputs\right.jpg");
imshow(Right);
title('click on the 18 vertices of different objects')
NewRightPoints = ginput(18);

save('ex2NewPoints_data','NewRightPoints','NewLeftPoints');