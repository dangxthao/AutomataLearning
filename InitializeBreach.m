function [] = initializeBreach()
  %close all;
  %clear;
  %clc;
  %warning('OFF', 'ALL')
  
  global BrSD
  %% Add the path to $ROOTDIR/breach-dev, better to be absolute
  addpath('../breach-dev')

  InitBreach
  model_name = 'NN_2019';


  %% set the seed
  %rng(15000,'twister');
  BrSD = BreachSimulinkSystem(model_name);
  %, 'all', [], {}, [], 'Verbose',0,'SimInModelsDataFolder', true);
tic  
  for k=1:1:1
   NN_MembershipQuery([0.2 0.3 0.4], BrSD);
  end
timeElapsed = toc
end
