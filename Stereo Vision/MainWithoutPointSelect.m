clear all
close all
disp('          This is the version of the main that uses previously')
disp('      chosen points by myself in the right and left image.')
disp('          It will thus directly display all the answers here bellow') 
disp('      and store all the relevant data in the workspace')
disp(' ')
input('     press any key to start the process and display all the values')

ex1b
ex1c
ex2

load('ex1a_data.mat')
load('ex1b_data.mat')
disp('Variables explanation in the workspace')
disp('->1.a Manually chosen calibration points chosen in the images : LeftPoints and RightPoints')
disp('->1.b M,K,R and T matrices for each image : M_Right, M_Left, K_right, K_left, R_right, R_left, T_right and T_left')
disp('->2.a Reconstructed calibration points : X1')
disp('->2.b error between the reconstructed and the given 3D points ( alse the average and maximum value) : errors, error_mean and error_max')
disp('->2.c manually selected vertices of the different objects : NewLeftPoints and NewRightPoints')
disp('->2.c reconstructed vertices : X2')

disp('thank you for your attention')