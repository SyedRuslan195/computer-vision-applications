

*****Steps to run:

step 1 : make sure that matlab is using this 'Stereo Vision' folder as the current folder.
step 2 : Run the MainWithoutPointSelect.m file to run everything and get all the results.
The results you obtain here are the results that I get with the latest points that I chose. You can always choose new points using the MainWithPointSelect.m file.

*****Details : 

Each part of the exercice is seperated in to a different .m file in which you can check the code for each part. Inside each file I delimeted everything using subtitles with code commentaries.
The data obtained in each subpart is stored in .mat files with corresponding names and these files are loaded in the next parts when needed.

All the answers are still in the workspace if you run the MainWithoutPointSelect or MainWithPointSelect and if you launch each subpart, the corresponding answers will appear in the workspace.

details about the workspace values :
->1.a Manually chosen calibration points chosen in the images : LeftPoints and RightPoints
->1.b M,K,R and T matrices for each image : M_Right, M_Left, K_right, K_left, R_right, R_left, T_right and T_left
->2.a Reconstructed calibration points : X1
->2.b error between the reconstructed and the given 3D points ( alse the average and maximum value) : errors, error_mean and error_max
->2.c manually selected vertices of the different objects : NewLeftPoints and NewRightPoints
->2.c reconstructed vertices : X2

*****Close all and Clear all:

The only moment i use them is in the beginning of the mains so if you launch the subparts , there will be a lot of new figures. There are clears in the end of the subpart as to get rid of the non final answer values.



*****Note:

There is a lot of information but its all reduntant . Just checking the workspace and the 3 figures that appear will answer all the questions. Everything else is details or code/workspace explanation.
