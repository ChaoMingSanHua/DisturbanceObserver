function [sys,x0,str,ts] = ctrl(t,x,u,flag)
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
sizes.NumOutputs    = 1;
sizes.NumInputs     = 5;
sizes.DirFeedthrough= 1;
sizes.NumSampleTimes= 0;
sys = simsizes(sizes);
x0 = [];
str = [];
ts = [];

function sys = mdlOutputs(t,x,u)
x1_d = u(1);
x2_d = u(2);
dx2_d = u(3);
x1 = u(4);
x2 = u(5);

k = 1; b = 1;
Kp = 10; Kd = 1;

e = x1_d - x1;
de = x2_d - x2;
torq = 1 / b * (k * x2 + dx2_d + Kp * e + Kd * de);
sys(1) = torq;