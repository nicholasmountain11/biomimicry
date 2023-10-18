% What I have done in this simulation, is added fire breaks. To make this
% happen, I simply added a variable called "fireBreak" and set it equal to
% 3. Then, I added a line of fire breaks up the middle of the grid
% horizontally and vertically. Since the simulation says nothing about how
% to deal with a grid square that is assigned 3, fire will not spread
% across the fire breaks, and trees will not grow there. I made fire breaks
% because in the example forest fire simulation, they used fire breaks as a
% way of keeping the fires from spreading. This simulation gives the option
% of testing how effective the fire breaks are at keeping more trees alive.

clc;clear;close all;
%initialize variables
forestSizeX = 50;
forestSizeY = 50;
forest = zeros(forestSizeX,forestSizeY);
forestNext = zeros(forestSizeX,forestSizeY);
empty = 0;
tree = 1;
fire = 2;
fireBreak = 3;
treeGrowthRate = 0.01;
treeDeathRate = 0.001;
fireSparkRate = 0.001;
simulationTimeSteps = 500;
treeCount = zeros(1, simulationTimeSteps);
time = 1:simulationTimeSteps;

% give the forest two lines of fire breaks
forest(forestSizeX/2,:) = fireBreak;
forest(:,forestSizeY/2) = fireBreak;
forestNext(forestSizeX/2,:) = fireBreak;
forestNext(:,forestSizeY/2) = fireBreak;





% go through each instant in time
for t=1:simulationTimeSteps
    % Go through every location in your forest
    for i=2:forestSizeX-1
        for j=2:forestSizeY-1
            neighbors = forest(i-1:i+1,j-1:j+1); % set array of neighbors
            onFire = any(neighbors(:) == 2); % onFire checks if any neighbors are on fire
            % check forest(i,j), and determine if it’s empty
            if forest(i, j) == empty
                % based on this decide, if forestNext(i,j) should grow a tree
                if rand(1)<treeGrowthRate
                    forestNext(i,j) = tree;
                end

            end
            % check forest(i,j), and determine if it's a tree
            if forest(i,j) == tree
                treeCount(t) = treeCount(t) + 1;
                % check if any of the tree's neighbors are on fire
                if onFire
                    forestNext(i,j) = fire;
                % based on this decide, if forestNext(i,j) should naturally
                % die
                elseif rand(1)<treeDeathRate
                    forestNext(i,j) = empty;
                % if tree does not die, check if it should catch on fire
                elseif rand(1)<fireSparkRate
                    forestNext(i,j) = fire;
                end
            end


            % check forest(i,j), and determine if it's on fire
            if forest(i,j) == fire
                forestNext(i,j) = empty;
            end
            
        end
    end
    % display the entire forest at this point in time
    imagesc(forestNext,[0 3])
    drawnow;
    forest = forestNext;
end

figure(2)
plot(time,treeCount)
xlabel("Time")
ylabel("Tree Count")