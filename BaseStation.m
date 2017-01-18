classdef BaseStation
   properties
      X
      Y
      P
   end
   methods
      function obj = BaseStation(xPos, yPos, transmitPower)
      if nargin > 0
         if isnumeric(xPos)
            obj.X = xPos;
         else
            error(' X Value must be numeric')
         end
         if isnumeric(yPos)
            obj.Y = yPos;
         else
            error(' Y Value must be numeric')
         end
         if isnumeric(transmitPower)
            %obj.P = 10^((transmitPower-30)/10);
            obj.P = transmitPower;
         else
            error(' P Value must be numeric')
         end
      end
   end
   end
end