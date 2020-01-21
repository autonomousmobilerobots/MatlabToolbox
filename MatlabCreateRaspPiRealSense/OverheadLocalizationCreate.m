function[poseX, poseY, poseTheta] = OverheadLocalizationCreate(RobotName, OverheadLocClient)
% Dummy wrapper so students can use the same function as the simulator.

Pose = Create_Optitrack_Pose(RobotName, OverheadLocClient);
poseX = Pose(1);
poseY = Pose(2);
poseTheta = Pose(3);

