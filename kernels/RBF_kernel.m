%version 04/03/2015
function k=RBF_kernel(X,Z,kernelParam)
k=exp(-kernelParam*sqdistALL(X,Z));
