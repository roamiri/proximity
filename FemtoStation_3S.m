classdef FemtoStation_3S
   properties
      X
      Y
      P
      dBS
      dMUE
      dFUE
      FUEX
      FUEY
      M  % distance with MUE
      B  % distance with BS
      dM1 = 15; dM2 = 50; dM3 = 125; 
      dB1 = 50; dB2 = 150; dB3 = 400;
      state = zeros(1,2)
      powerProfile = []
      C_FUE
      C_profile = []
   end
   methods
      function obj = FemtoStation_3S(xPos, yPos, BS, MUE, dFUE)
        obj.X = xPos;
        obj.Y = yPos;
        obj.dBS = sqrt((xPos-BS.X)^2 + (yPos-BS.Y)^2);
        obj.dMUE = nearest_MUE(xPos, yPos, MUE);% sqrt((xPos-MUE.X)^2 + (yPos-MUE.Y)^2); %distance to nearest MUE
        obj.dFUE = dFUE;
        obj.FUEX = xPos;
        obj.FUEY = yPos+dFUE;
      end
      
      function obj = setPower(obj,power)
%           obj.P = 10^((power-30)/10);
            obj.P = power;
            obj.powerProfile = [obj.powerProfile power];
      end
      
      function obj = setCapacity(obj,c)
        obj.C_FUE = c;
        obj.C_profile = [obj.C_profile c];
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