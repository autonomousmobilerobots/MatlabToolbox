function[poseX, poseY, poseTheta] = OverheadLocalizationCreate(Robot)
% Dummy wrapper so students can use the same function as the simulator.

Pose = Create_Optitrack_Pose(Robot.Name, Robot.OL_Client);
poseX = Pose(1);
poseY = Pose(2);
poseTheta = Pose(3);

