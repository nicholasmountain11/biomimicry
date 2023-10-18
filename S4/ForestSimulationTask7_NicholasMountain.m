clc;clear;close all;
%initialize variables
forestSizeX = 50;
forestSizeY = 50;
forest = zeros(forestSizeX,forestSizeY);
forestNext = zeros(forestSizeX,forestSizeY);
empty = 0;
tree = 1;
fire = 2;
treeGrowthRate = 0.01;
treeDeathRate = 0.001;
fireSparkRate = 0.001;
simulationTimeSteps = 500;
treeCount = zeros(1, simulationTimeSteps);
time = 1:simulationTimeSteps;


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
    imagesc(forestNext,[0 2])
    drawnow;
    forest = forestNext;
end

figure(2)
plot(time,treeCount)
xlabel("Time")
ylabel("Tree Count")