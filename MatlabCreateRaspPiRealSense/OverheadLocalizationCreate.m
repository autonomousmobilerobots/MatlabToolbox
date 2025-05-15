function[poseX, poseY, poseTheta] = OverheadLocalizationCreate(Robot)
% Dummy wrapper so we can use the same function in the lab and the simulator.
%
% Robot is the robot struct created by CretePiInit
%
% Output: PoseX, poseY, poseTheta
% In case of an error, returns NaNs


poseX = NaN;
poseY = NaN;
poseTheta = NaN;

try
    Pose = Create_Optitrack_Pose(Robot.Name, Robot.OL_Client);
    poseX = Pose(1);
    poseY = Pose(2);
    poseTheta = Pose(3);

catch
    disp(append('WARNING: function ', mfilename, ' did not execute correctly'));
end

end