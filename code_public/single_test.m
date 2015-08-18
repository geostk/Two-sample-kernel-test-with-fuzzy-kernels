% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or
% (at your option) any later version.
% 
% Written (W) 2012 Heiko Strathmann

% Takes data parameters and algorithm parameters struct and performs a
% number of two-sample tests. Prints some results and saves the latest
% state in a file which can be loaded and further be processed
function single_test(data_params,alg_params)

% easier to read code
m=data_params.m;

% generate filenames for temporary saving the current state for all data
% types
state_dir=strcat(alg_params.path_prefix, 'states/');
filename = strcat('state_',...
    data_params.which_data, ...
    '_m=', num2str(m), ...
    '_num_trials=', num2str(alg_params.num_trials), ...
    '_sigma_from=', num2str(alg_params.sigma_from), ...
    '_sigma_to=', num2str(alg_params.sigma_to), ...
    '_sigma_step=', num2str(alg_params.sigma_step),...
    '_do_xval=', num2str(alg_params.do_xval), ...
    '_check_type1=', num2str(alg_params.check_type1) ...
    );

if strcmp(data_params.which_data, 'mean') || strcmp(data_params.which_data, 'var')
     filename=strcat(filename, ...
     '_dimension=', num2str(data_params.dimension) ...
    );
end

if strcmp(data_params.which_data, 'mean') ...
        || strcmp(data_params.which_data, 'var') ...
        || strcmp(data_params.which_data, 'sine')
    filename=strcat(filename, ...
    '_difference=', num2str(data_params.difference) ...
    );
end

if strcmp(data_params.which_data, 'blobs')
    filename=strcat(filename, ...
    '_stretch=', num2str(data_params.stretch), ...
    '_angle=', num2str(data_params.angle), ...
    '_blob_distance=', num2str(data_params.blob_distance), ...
    '_num_blobs=', num2str(data_params.num_blobs) ...
    );
end

if strcmp(data_params.which_data, 'am')
    filename=strcat(filename, ...
        '_wav1=', num2str(data_params.wav1), ...
        '_wav2=', num2str(data_params.wav2), ...
        '_window_length=', num2str(data_params.window_length), ...
        '_added_noise=', num2str(data_params.added_noise), ...
        '_f_multiple=', num2str(data_params.f_multiple), ...
        '_f_transmit_multiple=', num2str(data_params.f_transmit_multiple), ...
        '_offset=', num2str(data_params.offset), ...
        '_envelope_scale=', num2str(data_params.envelope_scale) ...
    );
end

state_filename=strcat(state_dir, filename, '.mat');

% check whether state dir exists and create if not
if exist('states', 'dir')==0
    mkdir 'states';
end

% code readability
sigmas=2.^[alg_params.sigma_from:alg_params.sigma_step:alg_params.sigma_to];

% check if a state file exists and continue in this case
if ~exist(state_filename,'file')
    start=1;
else
    load(state_filename);
    start=nn+1;
end

% do a number of two-sample tests to estimate errors
for nn=start:alg_params.num_trials;
    % extract data, two halfs: training and test data
    [X,Y] = get_data(2*m,data_params);
    
    % if type 1 error should be checked, merge samples
    if alg_params.check_type1
        Z=[X;Y];
        inds=randperm(size(Z,1));
        Z=Z(inds,:);
        X=Z(1:2*data_params.m,:);
        Y=Z(2*m+1:4*m,:);
    end

    % learn kernel on training data
    [ws_maxmmd(:,nn),ws_maxrat(:,nn),ws_l2(:,nn),ws_opt(:,nn),ws_med(:,nn),ws_xvalc(:,nn)]=...
        opt_kernel_comb(X(1:m,:),Y(1:m,:),sigmas, alg_params.lambda, alg_params.do_xval);
    
    % evaluate kernel on test data
    X=X(m+1:2*m,:);
    Y=Y(m+1:2*m,:);
    
    % compute test statistics and threshold on test data
    [testStat_maxmmd(nn),thresh_maxmmd(nn)]=mmd_linear_combo(X,Y,sigmas,ws_maxmmd(:,nn));
    [testStat_maxrat(nn),thresh_maxrat(nn)]=mmd_linear_combo(X,Y,sigmas,ws_maxrat(:,nn));
    [testStat_l2(nn),thresh_l2(nn)]=mmd_linear_combo(X,Y,sigmas,ws_l2(:,nn));
    [testStat_opt(nn),thresh_opt(nn)]=mmd_linear_combo(X,Y,sigmas,ws_opt(:,nn));
    [testStat_med(nn),thresh_med(nn)]=mmd_linear_combo(X,Y,sigmas,ws_med(:,nn));
    [testStat_xvalc(nn),thresh_xvalc(nn)]=mmd_linear_combo(X,Y,sigmas,ws_xvalc(:,nn));
    
    % output some statistics
    fprintf('OPT: %f (stat); %f(thresh)\n', testStat_opt(nn), thresh_opt(nn));
    fprintf('MxRt: %f (stat); %f(thresh)\n', testStat_maxrat(nn), thresh_maxrat(nn));
    fprintf('MxMMD: %f (stat); %f(thresh)\n', testStat_maxmmd(nn), thresh_maxmmd(nn));
    fprintf('L2: %f (stat); %f(thresh)\n', testStat_l2(nn), thresh_l2(nn));
    fprintf('xvalc: %f (stat); %f(thresh)\n', testStat_xvalc(nn), thresh_xvalc(nn));
    fprintf('med: %f (stat); %f(thresh)\n', testStat_med(nn), thresh_med(nn));

    fprintf('acceptance rates (type II error)\n');
    fprintf('OPT: %d/%d=%f; ',    sum(testStat_opt<=thresh_opt),nn, sum(testStat_opt<=thresh_opt)/nn);
    fprintf('MxRt: %d/%d=%f; ', sum(testStat_maxrat<=thresh_maxrat),nn, sum(testStat_maxrat<=thresh_maxrat)/nn);
    fprintf('MxMMD: %d/%d=%f; ', sum(testStat_maxmmd<=thresh_maxmmd),nn, sum(testStat_maxmmd<=thresh_maxmmd)/nn);
    fprintf('L2: %d/%d=%f; ', sum(testStat_l2<=thresh_l2),nn, sum(testStat_l2<=thresh_l2)/nn);
    fprintf('xvalc: %d/%d=%f; ', sum(testStat_xvalc<=thresh_xvalc),nn, sum(testStat_xvalc<=thresh_xvalc)/nn);
    fprintf('med: %d/%d=%f\n', sum(testStat_med<=thresh_med),nn, sum(testStat_med<=thresh_med)/nn);
        
    % save variables for current state
    save(state_filename, 'nn', ...
        'thresh_maxmmd', 'thresh_maxrat', 'thresh_l2', 'thresh_opt','thresh_med','thresh_xvalc',...
        'testStat_maxmmd', 'testStat_maxrat', 'testStat_l2', 'testStat_opt','testStat_med','testStat_xvalc',...
        'ws_maxmmd', 'ws_maxrat', 'ws_l2', 'ws_opt','ws_med', 'ws_xvalc'...
        );
end
