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

% Costs of potentia wood choices
wood(1).cost = .5;
wood(2).cost = .6;
wood(3).cost = .7;
wood(4).cost = .9;

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
                   
% Initializing weights & costs
[weight(1).totalWeight, weight(2).totalWeight, ...
    weight(3).totalWeight, weight(4).totalWeight, weight(1).totalCost, ...
    weight(2).totalCost, weight(3).totalCost, weight(4).totalCost] = ...
    deal(zeros(1, 4));

% Calculating weight for all different core variations
for ii = 1:length(weight)
    for jj = 1:size(weight(1).variation, 1)
        for kk = 1:size(weight(1).variation, 2)
            
            weight(ii).totalWeight(jj) = weight(ii).totalWeight(jj) + ...
                (core.stringerVol * ...
                wood(weight(ii).variation(jj, kk)).density);
            
            weight(ii).totalCost(jj) = weight(ii).totalCost(jj) + ...
                (core.stringerVol * ...
                wood(weight(ii).variation(jj, kk)).cost);
            
        end
    end
end

%% Plotting Weight of Core Variations

% Concatenating bar graph data
barGraph.weightData = [weight(2).totalWeight; ...
                       weight(3).totalWeight; weight(4).totalWeight];

% Creating new figure
figure(1)

% Defining categories for bar chart
barGraph.categories = categorical({weight(2).type, ...
    weight(3).type, weight(4).type});
barGraph.categories = reordercats(barGraph.categories,{weight(2).type, ...
    weight(3).type, weight(4).type});

% Plotting bar graph
barGraph.weightGraph = bar(categorical({weight(1).type}), ...
    weight(1).totalWeight);
hold on 
barGraph.weightGraph = bar(barGraph.categories, barGraph.weightData); 

% Plot characteristics
grid on
grid minor

% Plot descriptors
title('\emph{Weight of Core for Wood and Layup Variations}', 'fontsize', ...
    16, 'Interpreter', 'Latex')
ylabel('\emph{Weight (g)}',...
    'fontsize', 14, 'Interpreter', 'Latex')
xlabel('\emph{Core Type}',...
    'fontsize', 14, 'Interpreter', 'Latex')
legendLabels = {'Poplar', 'Aspen', 'Beech', 'Birch', ...
    'Poplar \& Beech', 'Poplar \& Birch', 'Aspen \& Beech', ...
    'Aspen \& Birch'};
legend(legendLabels, 'location', 'southoutside', 'NumColumns', 8, ...
    'Interpreter', 'Latex')

%% Plotting Cost of Core Variations
% Concatenating bar graph data
barGraph.costData = [weight(2).totalCost; ...
                       weight(3).totalCost; weight(4).totalCost];

% Creating new figure
figure(2)

% Defining categories for bar chart
barGraph.categories = categorical({weight(2).type, ...
    weight(3).type, weight(4).type});
barGraph.categories = reordercats(barGraph.categories,{weight(2).type, ...
    weight(3).type, weight(4).type});

% Plotting bar graph
barGraph.costGraph = bar(categorical({weight(1).type}), ...
    weight(1).totalCost);
hold on
barGraph.costGraph = bar(barGraph.categories, barGraph.costData); 


% Plot characteristics
grid on
grid minor

% Plot descriptors
title('\emph{Cost of Core Raw Material}', 'fontsize', ...
    16, 'Interpreter', 'Latex')
ylabel('\emph{U.S Dollars}',...
    'fontsize', 14, 'Interpreter', 'Latex')
xlabel('\emph{Core Type}',...
    'fontsize', 14, 'Interpreter', 'Latex')
legend(legendLabels, 'location', 'southoutside', 'NumColumns', 8, ...
    'Interpreter', 'Latex')
