clc
clear all
close all

%% Input parameters
t = 5; % s
mUnit = 3; % kg
unitSize = 150e-3; % m
%rrotor = 40e-3; % m
%mrotor = 0.3; % kg
rrotor_out = 60e-3;
hrotor_out = 20e-3;
rrotor_in = 0.9*rrotor_out;
hrotor_in = 1e-3;

rotorDensity = 8050; % kg/m3
%hrotor = mrotor / rotorDensity / pi / rrotor^2; % m
wallthickness=2e-3;
d = unitSize/2 - (wallthickness + hrotor_out/2);  % Distance between rotor center and cube center [m]

%hrotor = mrotor / rotorDensity / pi / rrotor^2; % m

%% Other necessary variables
nFig = 1;

%% Run model
%[Pmax, Pavg, wrotorMax,RPM,RPS,hrotor, E, warning] =
%Model(t,mSat,satSize,rrotor_in, rrotor_out, ,rotorDensity,d,wallthickness, hrotor_in, hrotor_out);

%% Plot rotor mass
localWarning = 0;
i=0;
for plotVar = 0.1:0.001:0.8 % kg
    [Pmax, Pavg, wrotorMax,RPM,RPS,mrotor, E, warning] = Model(t,mUnit,unitSize,rrotor_in, rrotor_out, rotorDensity,d,wallthickness, hrotor_in, hrotor_out)

    if(warning == 0)
        i=i+1;
        good_x(i) = plotVar;
        good_y(i) = Pmax;
        bad_x(i) = NaN;
        bad_y(i) = NaN;
    else
        localWarning = 1;
        i=i+1;
        good_x(i) = NaN;
        good_y(i) = NaN;
        bad_x(i) = plotVar;
        bad_y(i) = Pmax;
    end
end
figure(nFig)
if(localWarning == 1)
    plot(bad_x, bad_y, 'r')
    legend('Rotor collision')
    hold on
end
plot(good_x, good_y, 'g')
title(['Peak power per rotor mass for a ',num2str(t),'s maneuver time' ]);
xlabel('Rotor mass [kg]');
ylabel('Peak power [W]');
clear good_x
clear good_y
clear bad_x
clear bad_y
nFig = nFig+1;

%% Plot rrotor
localWarning = 0;
i=0;
for plotVar = 40e-3:0.1e-3:70e-3 % [m]
    [Pmax, Pavg, wrotorMax,RPM,RPS,mrotor, E, warning] = Model(t,mUnit,unitSize,0.9*plotVar, plotVar, rotorDensity,d,wallthickness, hrotor_in, hrotor_out);
    if(warning == 0)
        i=i+1;
        good_x(i) = plotVar;
        good_y(i) = Pmax;
        bad_x(i) = NaN;
        bad_y(i) = NaN;
    else
        localWarning = 1;
        i=i+1;
        good_x(i) = NaN;
        good_y(i) = NaN;
        bad_x(i) = plotVar;
        bad_y(i) = Pmax;
    end
end
figure(nFig)
hold on
plot(good_x, good_y, 'g')
if(localWarning == 1)
    plot(bad_x, bad_y, 'r')
    legend('Acceptable parameters','Rotor collision')
end
title(['Peak power per rotor radius for a ',num2str(mrotor),'kg rotor mass' ]);
xlabel('Rotor radius [m]');
ylabel('Peak power [W]');
clear good_x
clear good_y
clear bad_x
clear bad_y
nFig = nFig+1;

%% Plot RPM
localWarning = 0;
i=0;
for plotVar = 40e-3:0.1e-3:70e-3 % [m]
    [Pmax, Pavg, wrotorMax,RPM,RPS,mrotor, E, warning] = Model(t,mUnit,unitSize,0.9*plotVar, plotVar, rotorDensity,d,wallthickness, hrotor_in, hrotor_out);
    if(warning == 0)
        i=i+1;
        good_x(i) = plotVar;
        good_y(i) = RPM;
        bad_x(i) = NaN;
        bad_y(i) = NaN;
    else
        localWarning = 1;
        i=i+1;
        good_x(i) = NaN;
        good_y(i) = NaN;
        bad_x(i) = plotVar;
        bad_y(i) = RPM;
    end
end
figure(nFig)
hold on
plot(good_x, good_y, 'g')
if(localWarning == 1)
    plot(bad_x, bad_y, 'r')
    legend('Acceptable parameters','Rotor collision')
end
title(['ANgular velocity per rotor radius for a ',num2str(mrotor),'kg rotor mass' ]);
xlabel('Rotor radius [m]');
ylabel('Angular velocity [RPM]');
clear good_x
clear good_y
clear bad_x
clear bad_y
nFig = nFig+1;


%% Plot RPM
localWarning = 0;
i=0;
for plotVar = 100e-3:1e-3:200e-3 % [m]
    % Increase rrotor based on size    
    rrotor_out = plotVar/2 - (wallthickness + hrotor_out);
    % Place rotor next to wall
    d = plotVar/2 - (wallthickness + hrotor_out/2);
    [Pmax, Pavg, wrotorMax,RPM,RPS,mrotor, E, warning] = Model(t,mUnit,unitSize,0.9*plotVar, plotVar, rotorDensity,d,wallthickness, hrotor_in, hrotor_out);
    if(warning == 0)
        i=i+1;
        good_x(i) = plotVar;
        good_y(i) = RPM;
        bad_x(i) = NaN;
        bad_y(i) = NaN;
    else
        localWarning = 1;
        i=i+1;
        good_x(i) = NaN;
        good_y(i) = NaN;
        bad_x(i) = plotVar;
        bad_y(i) = RPM;
    end
end
figure(nFig)
hold on
plot(good_x, good_y, 'g')
if(localWarning == 1)
    plot(bad_x, bad_y, 'r')
    legend('Acceptable parameters','Rotor collision')
end
title(['ANgular velocity per rotor radius for a ',num2str(mrotor),'kg rotor mass' ]);
xlabel('Rotor radius [m]');
ylabel('Angular velocity [RPM]');
clear good_x
clear good_y
clear bad_x
clear bad_y
nFig = nFig+1;

%% Plot satSize
localWarning = 0;
i=0;
for plotVar = 100e-3:1e-3:200e-3 % [m]
    % Increase rrotor based on satsize    
    rrotor_out = plotVar/2 - (wallthickness + hrotor_out);
    % Place rotor next to wall
    d = plotVar/2 - (wallthickness + hrotor_out/2);
    
   [Pmax, Pavg, wrotorMax,RPM,RPS,mrotor, E, warning] =Model(t,mUnit,plotVar,rrotor_out*0.9, rrotor_out, rotorDensity,d,wallthickness, hrotor_in, hrotor_out);
    if(warning == 0)
        i=i+1;
        good_x(i) = plotVar;
        good_y(i) = Pmax;
        bad_x(i) = NaN;
        bad_y(i) = NaN;
    else
        localWarning = 1;
        i=i+1;
        good_x(i) = NaN;
        good_y(i) = NaN;
        bad_x(i) = plotVar;
        bad_y(i) = Pmax;
    end
end
figure(nFig)
hold on
plot(good_x, good_y, 'g')
if(localWarning == 1)
    plot(bad_x, bad_y, 'r')
    legend('Acceptable parameters','Rotor collision')
end
title(['Peak power for different body sizes with optimized rotor mass and radius' ]);
xlabel('Satellite size [m]');
ylabel('Peak power [W]');
clear good_x
clear good_y
clear bad_x
clear bad_y
nFig = nFig+1;

