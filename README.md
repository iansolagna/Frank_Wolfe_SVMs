# Frank_Wolfe_SVMs

The name of the project is "BCFW for Structured SVMs"

The code comprehends three main scripts: one to run everything, one to perform classic Frank-Wolfe and one to perform Block Coordinate Frank-Wolfe

In particular, we have:
	
	-main this is the main script where the three methods are called to solve
	the minimisation problem

	-solverFW uses classic FW to solve the problem

	-solverBCFW uses block coordinate FW to solve the problem

	-subplus takes in input a vector and sets all negative values to zero

	-randsample_fast performs gap sampling in an efficient way

	-plot_fw plots the results obtained by the algorithms

	-oracle solves the linear subproblem in the Frank-Wolfe method

	-makeLogNodePotentials creates transition matrix with a posteriori probability

	-loss loss function 

	-logDecode  finds the best solution using Viterbi algorithm

	-load_toydataset loads only a fixed number of sentences from the training set
	and the test set
	
	-initSentences_train  gets indices of starts of sentences for training set

	-initSentences_test gets indices of starts of sentences for test set

	-featuremap creates the feature map for the given sentences

	-duality_gap computes the duality gap

	-average_loss computes the average loss for the predictions on input data

	-project_workspace Matlab environment with the results with 1000 sentences
