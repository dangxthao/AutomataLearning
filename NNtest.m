  close all;
  clear all;
  clear;
  clc;
  warning('OFF', 'ALL')
  
  %% Add the path to $ROOTDIR/breach-dev, better to be absolute
  addpath('../breach-dev')

  InitBreach
  model_name = 'NN_2019';


  %% set the seed
  %rng(15000,'twister');
  BrSD = BreachSimulinkSystem(model_name);
  %, 'all', [], {}, [], 'Verbose',0,'SimInModelsDataFolder', true);

BrSD_temp=BrSD.copy();
  
tic  
kmax = 10;
nbctrpt = 1000;

for k=1:1:kmax
   inputseq = ones(nbctrpt,1);
   
   for i=1:nbctrpt
        inputseq(i)= mod(i,5) + rand*5;
   end
   
   
   
   time = 0:nbctrpt;
  
 
    

    %   In1 = [time; inputseq]' 
    %   assignin('base', 'In1', In1)
    %   timeSim = In1(:,1);
    %   timeSim = timeSim-timeSim(1)
    %   sg_in = from_workspace_signal_gen({'In1'})
    %   BrSD_temp.SetInputGen({sg_in});


%         nbinputsig =1;
%         input_str = {};
%         input_cp = [];
%         input_intp = {};
%         for ii = 1:nbinputsig %only one input
%           input_str{end+1} = ['In' num2str(ii)];
%           input_cp = [input_cp nbctrpt];
%           input_intp{end+1} = 'previous';
%         end
%         Br_input_gen = fixed_cp_signal_gen(input_str, input_cp, input_intp);    
%         %Br_input_gen = var_cp_signal_gen(input_str, input_cp, input_intp);   
%         BrSD_temp.SetInputGen(BreachSignalGen({Br_input_gen}));
%         input_param = {};
%         input_range = [];
%          for ii = 1:nbinputsig
%             for jj = 0:(nbctrpt-1)
%               input_param{end+1} = ['In' num2str(ii) '_u' num2str(jj)];
%               % input_range = [input_range; invalmin invalmax];
%               %if (jj<(nbctrpt-1))
%                 %input_param{end+1} = ['In' num2str(ii) '_dt' num2str(jj)];
%                 %input_range = [input_range; (jj+1)*sim_time/nbctrpt  (jj+1)*sim_time/nbctrpt ];
%               %end
%             end
%             input_param
%          end
%         BrSD_temp.SetParam(input_param, inputseq);

    
    %Input_Gen.type = 'UniStep';     
    %Input_Gen.cp = nbctrpt;
    %BrSD_temp.SetInputGen(Input_Gen);
    %fprintf('Number of control points is %d\n', nbctrpt)

    Input_Gen = fixed_cp_signal_gen('In1', nbctrpt, 'previous');
    BrSD_temp.SetInputGen(Input_Gen);

    %% Specifying parameter names, which correspond to 
    %% values of input signals at each discrete time point
    for i=0:nbctrpt-1
        signal_u0{1,i+1}=strcat('In1_u', num2str(i));
    end
    
    % Assign values of input signals at each discrete time point
    BrSD_temp.SetParam(signal_u0, inputseq);   
 
    BrSD_temp.Sim(0:1:nbctrpt);
    BrSD_temp.PlotSignals({'In1', 'Out1'});
   
   
   
   
   
end
Simtime = toc
averageSimtime  = Simtime/kmax