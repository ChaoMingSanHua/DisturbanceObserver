function [sys,x0,str,ts] = NDOB(t,x,u,flag)
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
sizes.NumContStates = 1;
sizes.NumDiscStates = 0;
sizes.NumOutputs    = 1;
sizes.NumInputs     = 3;
sizes.DirFeedthrough= 1;
sizes.NumSampleTimes= 0;
sys = simsizes(sizes);
x0 = [0];
str = [];
ts = [];

function sys = mdlDerivatives(t,x,u)
z = x(1);
x1 = u(1);
x2 = u(2);
torq = u(3);
k = 1; b = 1;

c = 50;

dz = - c * z - c * (- k * x2 + b * torq + c * x2);


sys(1) = dz;

function sys = mdlOutputs(t,x,u)
x1 = u(1);
x2 = u(2);
torq = u(3);

c = 50;
z = x(1);
d_hat = z + c * x2;
sys(1) = d_hat;