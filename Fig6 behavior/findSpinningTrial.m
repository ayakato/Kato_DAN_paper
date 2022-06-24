function spinStatus = findSpinningTrial(nb,noSpinningThresh)
% The same algorithm as in findSpinning.m written by Laurent.
% This function detects spinning in each trial. 20210426 HK.

speed = diff(nb,1,2);
dir = [0,(speed > 1) - (speed < -1),0]; % if fly slows down a lot, counts this as an interruption in turn
startLeft = find((dir == 1) & (bdiffN(dir,1,1,2) > 0)) - 1;
stopLeft = find((dir == 1) & (fdiffN(dir,1,1,2) < 0)) - 1;
startRight = find((dir == -1) & (bdiffN(dir,1,1,2) < 0)) - 1;
stopRight = find((dir == -1) & (fdiffN(dir,1,1,2) > 0)) - 1;

spinLeft = (nb(stopLeft) - nb(startLeft)) > noSpinningThresh;
spinRight = -(nb(stopRight) - nb(startRight)) > noSpinningThresh;

spinStatus = any(spinLeft) || any(spinRight);
