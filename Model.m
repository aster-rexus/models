function [Pmax, Pavg, wrotorMax,RPM,RPS,mrotor, E, warning] = Model(t,mUnit,unitSize,rrotor_in, rrotor_out, rotorDensity,d,wallthickness, hrotor_in, hrotor_out)
%UNTITLED2 Summary of this function goes he
%   Detailed explanation goes here

%% Calculate rotor mass
mrotor_in = pi*rrotor_in^2*hrotor_in*rotorDensity;
mrotor_out = pi*(rrotor_out^2-rrotor_in^2)*hrotor_out*rotorDensity;
mrotor = mrotor_in + mrotor_out;

%% Moments of inertia
Isat = 1/6 * mUnit * unitSize;
IrotorXY_in = 1/12 * mrotor_in * (3*rrotor_in^2 + hrotor_in^2);
IrotorZ_in = 0.5* mrotor_in * rrotor_in^2;

IrotorXY_out = 1/12 * mrotor_in * (3*rrotor_out^2 + hrotor_out^2) - 1/12 * mrotor_in * (3*rrotor_in^2 + hrotor_in^2);
IrotorZ_out = 0.5* mrotor_out * rrotor_out^2 - 0.5* mrotor_in * rrotor_in^2;

IrotorXY = IrotorXY_in + IrotorXY_out;
IrotorZ = IrotorZ_in + IrotorZ_out;

Ibody = Isat + 2*(IrotorXY + mrotor * d^2);

%% Dynamics
wBodyAverage = pi/t;
wBodyMax = 2*wBodyAverage;
dwBody = 2*wBodyMax/t;

wrotorMax = Ibody/IrotorZ * wBodyMax;
dwrotor = Ibody/IrotorZ * dwBody;

T = dwrotor * IrotorZ;
Pmax = wrotorMax * T;
Pavg = Pmax/2;
E = Pavg*t;
RPM = wrotorMax/2/pi*60;
RPS = RPM/60;

%% Size warning
warning = 0;
if rrotor_out > d-hrotor_out/2
    %fprintf(2,"WARNING ROTOR COLLISION " + unitSize +" " + rrotor_out + "\n");
    warning = 1;
end

end
  

