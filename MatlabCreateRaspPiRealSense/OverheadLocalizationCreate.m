function [poseX, poseY, poseTheta] = OverheadLocalizationCreate(Robot)
% This function returns the latest Optitrack pose of 'Robot'
% Wrapper for 'Create_Optitrack_Pose', so students can use the same function as the simulator.
%
% Robot struct is created by CreatePiInit function
%
% poseX, poseY in meters
% poseTheta in radians

Pose = Create_Optitrack_Pose(Robot.Name, Robot.OL_Client);
poseX = Pose(1);
poseY = Pose(2);
poseTheta = Pose(3);

