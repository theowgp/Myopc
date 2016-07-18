function res = lambda(T, t)

% res = t/T;
% res = 0;
% res = 1;

% for T=300
% if t > 0.5*T
% for T=600
% if t > 0.01*T
% %     res = 1;
%     res = 0;
% else
% %     res = 0; 
%     res = 1;
% end

% for T = 600
% if t < 0.25*T
%     res = 0;
% else
%     if t < 0.75*T 
%         res = 1;
%     else
%         res = 0;
%     end
% end

% % for T = 1200
% if t < 0.25*0.5*T
%     res = 0;
% else
%     if t < 0.75*0.5*T 
%         res = 1;
%     else
%         res = 0;
%     end
% end


% gamma = 2/3;
%  gamma = 1/5;
%   gamma = 1/9;
   gamma = 1/100;
   
if t < gamma * T
    res = t / (gamma * T);
else
    res = 1;
end

end

