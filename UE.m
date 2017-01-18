classdef UE
   properties
      X
      Y
      SINR
      C
   end
   methods
      function obj = UE(xPos, yPos)
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
      end
   end
   end
end