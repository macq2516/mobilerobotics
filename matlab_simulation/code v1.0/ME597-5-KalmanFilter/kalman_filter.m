function [mu,S,mup, K] = kalman_filter(A,B,C,D,mu,S,R,u,y,Q)

% Performs one iteration of Kalman Filtering

% Inputs:
%       motion_model       : Function reference for motion model
%       mean_              : Mean of current state
%       covariance         : Covariance of current state
%       R                  : Motion disturbance
%       measurement_model  : Function reference for measurement model
%       measurement        : Measurment of current time step 
%       Q                  : Measurement disturbance
%       example            : Which example we want to test

% Outputs:
%       mean_predicted     : Predicted mean after motion update
%       kalman_gain        : Kalman gain for current time step
%       mean_              : Final estimated mean after iteration
%       covariance         : Final estimated covariance after iteration 

% Prediction Step:

% Get dimension of state
n = length(A(1,:));

% Predict new mean based on motion
mup = A*mu + B*u;

% Predict new covariance based on motion
Sp = A*S*A' + R;

% Measurement Step:

% Calculate kalman gain
K = Sp*C'*inv(C*Sp*C'+Q.Q);

% Get new mean of state after measurement
mu = mup + K*(y-C*mup);

% Get new covaraince of state after measurement
S = (eye(n)-K*C)*Sp;
