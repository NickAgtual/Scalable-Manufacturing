clear; clc; close all;

%% Defining Properties of Wood

% Names of potential wood choices
wood(1).name = 'Poplar';
wood(2).name = 'Aspen';
wood(3).name = 'Beech';
wood(4).name = 'Birch';

% Densities of potential wood choices [g/cc]
wood(1).density = .427;
wood(2).density = .401;
wood(3).density = .655;
wood(4).density = .552;

%% Defining Properties of Snowboard Core

% Dimesnions of core stringers
core.stringerLength = 153; %[cm]
core.stringerWidth = 1; % [cm]
core.stringerThickness = 1; % [cm]

% Number of stringers in snowbaord core
core.numStringers = 8;

% Total volume of snowbaord core
core.totalVolume = core.stringerLength * core.stringerWidth * ...
    core.stringerThickness * core.numStringers; %[cc]

%% Weight Analysis

% ----- Defining different core combinations ------
% Solid core
% Reinforced edge
% Reinforced center
% Reinforced edge and center






