function [sys,x0,str,ts] = plant(t,x,u,flag)
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
sizes.NumContStates = 2;
sizes.NumDiscStates = 0;
sizes.NumOutputs    = 2;
sizes.NumInputs     = 2;
sizes.DirFeedthrough= 0;
sizes.NumSampleTimes= 0;
sys = simsizes(sizes);
x0 = [0, 0];
str = [];
ts = [];

function sys = mdlDerivatives(t,x,u)
x1 = x(1);
x2 = x(2);
torq = u(1);
d = u(2);

k = 1; b = 1;

dx1 = x2;
dx2 = - k * x2 + b * torq + d;

sys(1) = dx1;
sys(2) = dx2;


function sys = mdlOutputs(t,x,u)
sys(1) = x(1);
sys(2) = x(2);