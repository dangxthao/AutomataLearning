% Function that takes an input word and returns the last output float
function [out] = NN_MembershipQuery(inputseq, BrSD)

BrSD_temp=BrSD.copy();

n = length(inputseq);
time = 0:n;
  
 
%In1 = [0 1 2 3 4 5; 20 4 6 -2 -4 -6]';
  
  
%   In1 = [time; inputseq]' 
%   assignin('base', 'In1', In1)
%   timeSim = In1(:,1);
%   timeSim = timeSim-timeSim(1)
%   sg_in = from_workspace_signal_gen({'In1'})
%   
  

  
%BrSD_temp.SetInputGen({sg_in});
  
    
    nbinputsig =1;
    nbctrpt = n;
    input_str = {};
    input_cp = [];
    input_intp = {};
    for ii = 1:nbinputsig %only one input
      input_str{end+1} = ['In' num2str(ii)];
      input_cp = [input_cp nbctrpt];
      input_intp{end+1} = 'previous';
    end
    Br_input_gen = var_cp_signal_gen(input_str, input_cp, input_intp);
    BrSD_temp.SetInputGen(BreachSignalGen({Br_input_gen}));
    input_param = {};
    input_range = [];
     for ii = 1:nbinputsig
        for jj = 0:(nbctrpt-1)
          input_param{end+1} = ['In' num2str(ii) '_u' num2str(jj)];
    %     input_range = [input_range; invalmin invalmax];
%           if (jj<(nbctrpt-1))
%             input_param{end+1} = ['In' num2str(ii) '_dt' num2str(jj)];
%            input_range = [input_range; (jj+1)*sim_time/nbctrpt  (jj+1)*sim_time/nbctrpt ];
%            end
        end
        input_param
     end
    BrSD_temp.SetParam(input_param, inputseq);
    
    
    

  
    BrSD_temp.Sim(0:1:n-1);
    BrSD_temp.PlotSignals({'In1', 'Out1'});

  
  
  
  %get the index of the ouput signal in the Log
  output_name='Out1';
  index_output=find(strcmp(BrSD_temp.P.ParamList,...
                                       output_name));
  word=[ BrSD_temp.P.traj{1, 1}.time'...
                  BrSD_temp.P.traj{1, 1}.X(index_output,:)' ];

  word = word(:,2);
  out = word(length(word));
end


