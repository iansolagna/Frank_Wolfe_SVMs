function [nodePot,edgePot] = makeLogNodePotentials(xi,w,v_start,v_end,v)
% Make Log-Potentials for given sentence

% Parameters inizialization
num_states = xi.num_states;
num_features = xi.num_features;
featureStart = xi.featureStart;
num_featuresTotal = featureStart(end)-1;
num_nodes = size(xi.data,1);

% Make node potentials
nodePot = zeros(num_nodes,num_states); % words X states matrix
for n = 1:num_nodes % For each word
    features = xi.data(n,:); % features for word considered
    for state = 1:num_states % for each state
        pot = 0; % inizializate the potential
        for f = 1:length(num_features) % for each feature
            if features(f) ~= 0 % we ignore features that are 0
                featureParam = featureStart(f)+features(f)-1; 
                index_w = featureParam+num_featuresTotal*(state-1); % Index of the weight to add. We have the index of the value of the feature w.r.t. the state considered 
                pot = pot+w(index_w); % Add to the potential the regarding weight value
            end
        end
        nodePot(n,state) = pot; % update node potentials
    end
end
nodePot(1,:) = nodePot(1,:) + v_start'; % Modification for beginning of sentence
nodePot(end,:) = nodePot(end,:) + v_end'; % Modification for end of sentence

% Transitions are not dependent on features, so are position independent
% We take the exponential of the coordinates of w related to the matrix bin
edgePot = exp(v); 

