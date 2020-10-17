function [sm] = fins(n,rc,span,tc,sweep,xb)
% all dimensions in meteres

% % Inputs
% n = number of fins
% rc = fin root chord
% span = fin span
% tc = fin tip chord
% sweep = sweep distance
% xb	= distance from nose tip to fin root chord leading edge

% % Outputs
% sm = stability margin

% Rocket Dimensions
lNose = 12.5;	% length of nose
dNose = 5.54;	% diameter at base of nose
dfTransition = 0;	% diameter at front of transition
drTransition = 0;	% diameter at rear of transition
lTransition	= 0;	% length of transition
dnTransition = 0;	% distance from tip of nose to front of transition
rRocket = 2.77;	% radius of body at aft end
noseCone = 'ogive'; % Either 'cone' or 'ogive'

% Nose Cone CP
cpNose = 2;
switch noseCone
    case 'ogive'
        xcpNose = 0.466 * lNose;
    case 'cone'
        xcpNose = 0.666 * lNose;
end

% Transition Cone CP
if lTransition ~= 0
    cpTransition = 2 * ( (drTransition/dNose)^2 - (dfTransition/dNose)^2 );
    xcpTransition = dnTransition + lTransition/3 * ...
        (1+((1-dfTransition/drTransition))/(1+(1-dfTransition/drTransition)^2));
else
    cpTransition = 0;
    xcpTransition = 0;
end

% Fins CP
mc = ( (abs(rc/2 - (sweep+tc/2)))^2 + span^2 )^0.5; % length of mid-chord line
% mc = 6.5 % Manually set mid-chord length here
cpFins = ( 1 + (rRocket/(span+rRocket)) ) * ...
    ( 4*n*(span/dNose)^2 )/( 1 + ( 1 + (2*mc/(rc+tc))^2 )^0.5 );
xcpFins = xb + (sweep/3) * (rc+2*tc)/(rc+tc) + ( (rc+tc) - (rc*tc)/(rc+tc) )/6;

% Rocket CP
cpRocket = cpNose + cpTransition + cpFins;
xcpRocket = (cpNose*xcpNose + cpTransition*xcpTransition + cpFins*xcpFins) / cpRocket;

% Rocket CG
xcgRocket = 8.1174 ;%enter manually

% Rocket Stability Margin (sm)
sm = (xcpRocket - xcgRocket)/ 2*rRocket;

end