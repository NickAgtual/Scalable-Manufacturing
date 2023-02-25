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
core.stringerVol = core.stringerLength * core.stringerWidth * ...
    core.stringerThickness; %[cc]

%% Weight Analysis

% ----- Defining different core combinations -----
% Variation type
weight(1).type = 'Solid Core';
weight(2).type = 'Reinforced Edge';
weight(3).type = 'Reinforced Center';
weight(4).type = 'Reinforced Edge and Center';

% Variation identification matrices
% 1 = Poplar
% 2 = Aspen
% 3 Beech
% 4 Birch
weight(1).variation = [ones(1, core.numStringers); ...
                       2 * ones(1, core.numStringers); ...
                       3 * ones(1, core.numStringers); ...
                       4 * ones(1, core.numStringers)];
weight(2).variation = [3 1 1 1 1 1 1 3; ...
                       4 1 1 1 1 1 1 3; ...
                       3 2 2 2 2 2 2 3; ...
                       4 2 2 2 2 2 2 4];
weight(3).variation = [1 1 1 3 3 1 1 1; ...
                       1 1 1 4 4 1 1 1; ...
                       2 2 2 3 3 2 2 2; ...
                       2 2 2 4 4 2 2 2];
weight(4).variation = [3 1 1 3 3 1 1 1; ...
                       4 1 1 4 4 1 1 1; ...
                       3 2 2 3 3 2 2 2; ...
                       4 2 2 4 4 2 2 2];
                   
% Initializing weights
[weight(1).totalWeight, weight(2).totalWeight, ...
    weight(3).totalWeight, weight(4).totalWeight] = deal(zeros(1, 4));

% Calculating weight for all different core variations
for ii = 1:length(weight)
    for jj = 1:size(weight(1).variation, 1)
        for kk = 1:size(weight(1).variation, 2)
            
            weight(ii).totalWeight(jj) = weight(ii).totalWeight(jj) + ...
                (core.stringerVol * ...
                wood(weight(ii).variation(jj, kk)).density);
            
        end
    end
end

%% Plotting Weight of Core Variations

% Concatenating bar graph data
barGraph.weightData = [weight(1).totalWeight; weight(2).totalWeight; ...
                       weight(3).totalWeight; weight(4).totalWeight];

% Creating new figure
figure(1)

barGraph.categories = categorical({weight(1).type, weight(2).type, ...
    weight(3).type, weight(4).type});
barGraph.categories = reordercats(barGraph.categories,{weight(1).type, ...
    weight(2).type, weight(3).type, weight(4).type});

% Plotting bar graph
barGraph.graph = bar(barGraph.categories, barGraph.weightData); 

% Plot characteristics
grid on
grid minor

% Plot descriptors
title('\emph{Weight of Core Wood and Layup Variations}', 'fontsize', ...
    16, 'Interpreter', 'Latex')
ylabel('\emph{Weight (g)}',...
    'fontsize', 14, 'Interpreter', 'Latex')








