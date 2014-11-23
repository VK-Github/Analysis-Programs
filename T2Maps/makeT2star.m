% makeT2star - make a T2* map by calling Mark Cohen's T2Map.m
% requires .nii files in same folder as makeT2star and T2map, and SPM5 or
% SPM8, cd to this directory for wd


%% User Inputs %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datapath    	= '/fMRI_data/UCLA_NITP/GREEN_MRI_DATA/T2Maps';                 % Root-directory

imgtype = 'nii';    % what kind of image? 'img' = img/hdr, 'nii' = nii
imgpreid = 'TE';   % string shared by all image names
tes=[2.7 5 10 20 40]; % TE values
base_dir = pwd;
minimum = 10;    %set the minimum threshold to filter noise; fed directly into T2Map
maximum = 250; %set maximum threshold; fed directly into T2Map

%%% For Multiple Subjects %%%

subjs = {'SUBJ01','SUBJ02','SUBJ03','SUBJ04','SUBJ05','SUBJ06','SUBJ07'};    %input all subjects; ensure data structure: T2Map > T2map.m, makeT2star.m, SUBJ01[folder], SUBJ02[folder]
nsubjs = length(subjs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% End User Inputs %%


% run through analysis for each subject
for n = 1:nsubjs
    subjDir=strcat(datapath,'/',subjs{n});
    cd(subjDir); 
 
    fprintf('Starting T2star map calculations for %s\n',subjs{n});
 
    % get data from images, put into cell array
    for r = 1:length(tes)

        % load in data from each volume
        imgString=['^' imgpreid num2str(tes(r)) '.*\.' imgtype '$'];
        if imgtype=='img'
            [raw_func_filenamesdirs] = spm_select('List',subjDir,imgString);
        elseif imgtype=='nii'
            [raw_func_filenames,dirs] = spm_select('ExtFPList',subjDir,imgString,1:10000);
        end;
        vrun=spm_vol(raw_func_filenames);       %pulls out volume dimensions; formats in a way that spm_read_vols can read

        run(:,:,:,r)=spm_read_vols(vrun);  %this is the matrix of intensity values from the 5 slices, where r is the te# (1-5)
        %     run{r}=spm_read_vols(vrun);

    end

    star=zeros(size(run(:,:,:,1)));
    nplane=size(run,3); %e.g., the # of slices in r (e.g., n=23 slices)

    for s = 1:nplane  %iterates through slices

        indata = zeros(vrun.dim(1),vrun.dim(2),length(tes));    %makes empty matrix where each slice calc is stored

        for r = 1:length(tes)

            indata(:,:,r) = run(:,:,s,r);   %gets the data from run into the (previously) empty matrix

        end

        %cd(datapath);
        
        %[star(:,:,s) thresh]=T2Map(indata,tes,10,100,0);
        [map thresh]=T2Map(indata,tes,minimum,2000,0);
        star(:,:,s)=map(:,:,2);

    end;

    newvol=vrun;
    newvol.fname=[subjDir '/star_map2.img'];
    spm_write_vol(spm_create_vol(newvol), star);
    
    fprintf('Completed T2star map for %s\n',subjs{n});
    
end;
  