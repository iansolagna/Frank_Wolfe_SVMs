function phi = featuremap(xi, yi)
% FEATUREMAP 
% xi is a sentence, composed of a number of words. Vector of vectors.
% yi is the label for each word. Vector.

% Inizialization data variables
num_states = xi.num_states; % number of possible state for the dataset considered
featureStart = xi.featureStart; % vector with cumulative sum of possible params for each word of xi
num_featuresTotal = featureStart(end)-1; % number of total features, binary representation for sparsity | -1 because featureStart has been created including 1 (see line 32 load_toydataset)
data = xi.data; % words with tags for sentence xi

% Inizilization feature map variables
unit = zeros(num_featuresTotal,num_states); % create a matrix features x states of zeros
gr_start = zeros(num_states,1);
gr_end = zeros(num_states,1);
bin = zeros(num_states);

% Note that xi.data is given already by its unary features. In the 
% following, these are transformed into a binary representation and biases
% for the beginning and the end of the sentence as well as sequential 
% features are added.

num_features = xi.num_features; % num_features is a vector with columns type of features and values the number of different possible values for regarding feature 
nNodes = size(xi.data,1); % number of words in the sentence

% Update gradient
for n = 1:nNodes % unary features   | for each word
    features = xi.data(n,:);    % we get the representation of the word | values of features for the word considered
    for feat = 1:length(num_features) % for each feature
        if features(feat) ~= 0
            % create a variable which takes the number of used variables for previous feature, and sum the value of the current feature minus 1. 
            % In this way we find the index to use in the binary representation matrix unit
            featureParam = featureStart(feat)+features(feat)-1; 
            for state = 1:num_states % for each state
                O = (state == yi(n)); % output if state is the same of word's state
                % We update the matrix unit by taking the row regarding the
                % value of the feature considered and we add 1 to the
                % column related with the state
                unit(featureParam,state) = unit(featureParam,state) + O; 
            end
         end
     end
end

% OBS: until now we have analyzed a sentence. We create a unit matrix which
% represent each feature value as row and each state as column. For each 
% word we modify the unit matrix taking the column of the word state and
% adding one to the rows which represent the word's features values.
% For example, if the word has representation vector [1 5 8 10] and state
% value 4, we modify the 4th column adding one to rows 1 - 5 - 8 - 10.

% gr_start and gr_end are vectors which describe binary the state of the
% first and last words of the sentence
for state = 1:num_states        % for each states
    O = (state == yi(1));       
    gr_start(state) = gr_start(state) + O; % beginning of sentence | this value changes only if the state is equal to the first word state
    O = (state == yi(end));     
    gr_end(state) = gr_end(state) + O; % end of sentence | this value changes only if the state is equal to the last word state
end

% Now we look at the state of the next word to add some context
for n = 1:nNodes-1 % sequential binary features 
    for state1 = 1:num_states % for each state related to the word we are considering
        for state2 = 1:num_states % for each state related to the next word
            O = ((state1 == yi(n)) && (state2 == yi(n+1))); % find state combination: O = 1 only if x_{t} has state s1 e x_{t+1} has state s2
            bin(state1,state2) = bin(state1,state2) + O; % update bin
        end
    end
end

% Bin is the transition map. It records for each state (row) how many times
% the next word has each state (column).

% Now we vectorize the unit matrix taking each column subsequently, and we
% concatanate the vector corresponding to the first and last word

phi = [unit(:); gr_start;gr_end;bin(:)];

% transform into space feature
phi = sparse(phi);

end


