% This simulation the first chamber of a sewage system that is based on
% a cow stomach. In the first chamber of the cow stomach, the solid food
% that can't be digested falls to the bottom while the rest goes on to the
% next chamber. The sweage system does the same with solid waste. This 
% simulations models how long the chamber needs to be for all of the solid
% waste to fall to the bottom.

clc;clear;close all;
%initialize variables
chamberLength = 50; 
chamberDepth = 50;
chamber = zeros(chamberLength,chamberDepth);
chamberNext = zeros(chamberLength,chamberDepth);
liquid = 0;
wasteLiquid = 1;
wasteSolid = 2;
becomeSolidRate = .1;
simulationTimeSteps = 1000;
chamber(1, 1) = 1;

% go through each instant in time
for t = 1:simulationTimeSteps
   % reset chamberNext
   chamberNext = zeros(chamberLength,chamberDepth);
   % create a constant stream of liquid waste coming into the top of the
   % grid.
   chamberNext(1,1) = wasteLiquid;
   % start with a layer of solid waste at the bottom of the chamber, this
   % is needed to get the solid waste to accumulate.
   chamber(chamberDepth,:) = wasteSolid;
   % go through each location in the chamber
   for j=1:chamberLength-1
       for i=1:chamberDepth-1
           right = chamber(i,j+1);
           under = chamber(i:chamberDepth,j);
           % check if a square is liquid waste
           if chamber(i,j) == wasteLiquid
               % if it turns into solid, make the next square to the right
               % into liquid waste. Turn the next square down into solid.
               if rand(1) < becomeSolidRate
                    chamberNext(i,j+1) = liquid;
                    chamberNext(i+1,j) = wasteSolid;
               % otherwise, the liquid waste keeps moving right
               else
                    chamberNext(i,j+1) = wasteLiquid;
                end
           end
           % check if square is solid
           if chamber(i,j) == wasteSolid
               if any(under == liquid)
                   chamberNext(i+1,j) = wasteSolid;
               else
                   chamberNext(i,j) = wasteSolid;
               end
           end
       end            
   end
   % display the entire chamber at this point in time
   imagesc(chamberNext,[0 2])
   drawnow;
   chamber = chamberNext;
  
end
