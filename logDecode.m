function [y] = logDecode(logNodePot,logEdgePot)

[num_nodes,num_states] = size(logNodePot);

% Forward Pass
alpha = zeros(num_nodes,num_states);
alpha(1,:) = logNodePot(1,:);
for n = 2:num_nodes 
	tmp = repmat(alpha(n-1,:)',1,num_states) + logEdgePot; % create a matrix with num_states equal columns (the n-1 row) and add the values of the edge state to state
	alpha(n,:) = logNodePot(n,:) + max(tmp); % add to the potential the max value of the previous computation and store it in alpha n
	[~, mxState(n,:)] = max(tmp); % store the maximum values for each column of tmp 
end

% Backward Pass
y = zeros(num_nodes,1);
[~, y(num_nodes)] = max(alpha(num_nodes,:));
for n = num_nodes-1:-1:1
	y(n) = mxState(n+1,y(n+1));
end

end