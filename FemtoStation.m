classdef FemtoStation
   properties
      X
      Y
      P
      dBS
      dMUE
      dFUE
      M  % distance with MUE
      B  % distance with BS
      dM1 = 15; dM2 = 50; dM3 = 125; 
      dB1 = 50; dB2 = 150; dB3 = 400;
      state = zeros(1,3)
      powerProfile = []
   end
   methods
      function obj = FemtoStation(xPos, yPos, BS, MUE, dFUE)
        obj.X = xPos;
        obj.Y = yPos;
        obj.dBS = sqrt((xPos-BS.X)^2 + (yPos-BS.Y)^2);
        obj.dMUE = sqrt((xPos-MUE.X)^2 + (yPos-MUE.Y)^2);
        obj.dFUE = dFUE;
      end
      
      function obj = setPower(obj,power)
%           obj.P = 10^((power-30)/10);
            obj.P = power;
            obj.powerProfile = [obj.powerProfile power];
      end
      
      function obj = getDistanceStatus(obj)
          if(obj.dMUE <= obj.dM1 )
              obj.state(2) = 0;
          elseif(obj.dMUE <= obj.dM2 )
              obj.state(2) = 1;
          elseif(obj.dMUE <= obj.dM3 )
              obj.state(2) = 2;
          else
              obj.state(2) = 3;
          end
          
          if(obj.dBS <= obj.dB1 )
              obj.state(3) = 0;
          elseif(obj.dBS <= obj.dB2 )
              obj.state(3) = 1;
          elseif(obj.dBS <= obj.dB3 )
              obj.state(3) = 2;
          else
              obj.state(3) = 3;
          end
      end
   end
end