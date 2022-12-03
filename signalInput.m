function [sys,x0,str,ts] = signalInput(t,x,u,flag)
switch flag
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 1
        sys = mdlDerivatives(t,x,u);
    case 3
        sys = mdlOutputs(t,x,u);
    case {2,4,9}
        sys = [];
    otherwise
        error(['Unhandled flag = ', num2str(flag)]);
end

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates = 0;
sizes.NumDiscStates = 0;
sizes.NumOutputs    = 3;
sizes.NumInputs     = 0;
sizes.DirFeedthrough= 1;
sizes.NumSampleTimes= 1;
sys = simsizes(sizes);
x0 = [];
str = [];
ts = [0, 0];

function sys = mdlOutputs(t,x,u)
omega = 2 * pi; A = 1;
x1_d = A * (1 - cos(omega * t));
x2_d = A * omega * sin(omega * t);
dx2_d = A * omega^2 * cos(omega * t);
sys(1) = x1_d;
sys(2) = x2_d;
sys(3) = dx2_d;