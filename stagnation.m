%===================================================== Stagnation detection
function stagn=stagnation(fMinPrev,fMin, FEprev, FEs)
% 	Normalised pseudo-gradient of the fitness evolution
delta=2*(fMinPrev-fMin)/abs(fMinPrev+fMin);
delta=delta/(FEs-FEprev);
expBeta=1;
stagProba=expBeta*exp(-delta);

% Probabilistic decision
stagn= rand<stagProba;
end