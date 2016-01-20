%% startexperiment
%
%   Implements the experiment protocol.
%
% R. Calen Walshe January 14, 2016

if isempty(experimentStruct)
    experimentStruct = createxperimentStruct(); % talk between     
end

% Clear the workspace
close all;
sca;

% Setup PTB with some default values
PsychDefaultSetup(2);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle'). Look
% at the help function of rand "help rand" for more information
rand('seed', sum(100 * clock));

% Set the screen number to the external secondary monitor if there is one
% connected
screenNumber = max(Screen('Screens'));

% Define black, white and grey
white = WhiteIndex(screenNumber);
grey = white / 2;
black = BlackIndex(screenNumber);

% Open the screen
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey, [], 32, 2);

% Present cute intro
im      = imread('maskingintro.jpg');
tex     = Screen('MakeTexture', window, im);
Screen('DrawTexture', window, tex);
Screen('Flip', window);
WaitSecs(2);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Set the text size
Screen('TextSize', window, 60);

% Query the maximum priority level
topPriorityLevel = MaxPriority(window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set the blend function for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%experimentStruct = createxperimentStruct(); % talk between 

runexperimentblock(experimentStruct, stimulusArray);