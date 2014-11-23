function [mySE,myGRE] = PDAC_Data(SEPix,GREPix)%PixDataPre,PixDataPost,PixInfoPre,PixInfoPost)
%[Analysis] = PDAC_Data(SEPix,GREPix)
%T2 Analysis: T2,T2*,VSI
%Prep Structure data to run in T2Map.m


%-------------------------------------------------------------------------%
%Generate T2 and T2* Maps
%Output: Top Image-Threshold Image,Middle Image-T2 Map, Bottom Map-T2* Map
%Prep for T2MapNew: 
minimum=0;maxT2=3000;
tespre = zeros(1,4);
tespost = zeros(1,4);
V = 21;
myFileV = '/Users/VK/Desktop/MGH_Martinos2013/Projects/PDAC/Data/Analysis/AnalyzedData/';
    %1)Grab consecutive sets of 4 images and save as indata
choice = menu('Lets Generate your T2 and T2* Maps! Would you like to display figures?','Yes','No')
if choice == 1
    display = 1;
else
    display = 0;
end

%Calculate T2 and R2 Maps 
for k = 0:(V-1)
    if k < 20
      SLindex = k+1;
        for j = 1:6
            index = j;
            indatapretemp(:,:,index) = SEPix.Pre(6*k+j).Data;
            temp1 = SEPix.Pre(6*k+j).Info.EchoTime;
            tespre(index) = temp1;
            indataposttemp(:,:,index) = SEPix.Post(6*k+j).Data;
            temp = SEPix.Post(6*k+j).Info.EchoTime;
            tespost(index) = temp;
            %mySE.Post.Slice(k).Echo(j).Data(:,:)=indataposttemp;
        end
      mySE.Pre.Slice(SLindex).Data(:,:,:)=indatapretemp;
      mySE.Post.Slice(SLindex).Data(:,:,:)=indataposttemp;
      mySE.Pre.Slice(SLindex).Echo=tespre;
      mySE.Post.Slice(SLindex).Echo=tespost;
    end
end


%      [Analysis.T2.Pre(k+1).Maps Analysis.T2.Pre(k+1).Thresh] = T2MapNew(indatapre, tespre, minimum, maxT2, display );
      %[Solved.T2.Pre(k+1)] = PDAC_chooseROIs(SEPix.Pre)
      %[Analysis.myT2.Pre(k+1).fitresult,Analysis.myT2.Pre(k+1).gof, Analysis.myT2.Pre(k+1).Val] = myT2fits(tespre,indatapre);
 %     indatapost=double(indataposttemp);
 %     [Analysis.T2.Post(k+1).Maps Analysis.T2.Post(k+1).Thresh] = T2MapNew(indatapost, tespost, minimum, maxT2, display );
      %[Analysis.myT2.Post(k+1).fitresult,Analysis.myT2.Post(k+1).gof, Analysis.myT2.Post(k+1).Val] = myT2fits(tespost,indatapost);
 %     PreMaps = strcat(myFileV,'T2_Pre_Slice_',mySlice,'Map');  
 %     csvwrite(PreMaps,Analysis.T2.Pre(k+1).Maps);
 %     PostMaps = strcat(myFileV,'T2_Post_Slice_',mySlice,'Map');
 %     csvwrite(PostMaps,Analysis.T2.Post(k+1).Maps);
 %     clear Analysis
 %   else
 %       sprintf('%s','T2 Maps Generated...Yay!')
 %   end
%end
%close all

%Calculate T2* and R2* Maps 
for k = 0:(V-1)
    if k < 20
      SLindex = k+1;
        for j = 1:4
            index = j;
            indatapretemp(:,:,index) = GREPix.Pre(4*k+j).Data;
            temp1 = GREPix.Pre(4*k+j).Info.EchoTime;
            tespre(index) = temp1;
            indataposttemp(:,:,index) = GREPix.Post(4*k+j).Data;
            temp = GREPix.Post(4*k+j).Info.EchoTime;
            tespost(index) = temp;
        end
      myGRE.Pre.Slice(SLindex).Data(:,:,:)=indatapretemp;
      myGRE.Post.Slice(SLindex).Data(:,:,:)=indataposttemp;
      myGRE.Pre.Slice(SLindex).Echo=tespre;
      myGRE.Post.Slice(SLindex).Echo=tespost;
    end
end

%      indatapre=double(indatapretemp);
%      [Analysis.T2Star.Pre(k+1).Maps Analysis.T2Star.Pre(k+1).Thresh] = T2MapNew(indatapre, tespre, minimum, maxT2, display );
%      indatapost=double(indataposttemp);
%      [Analysis.T2Star.Post(k+1).Maps Analysis.T2Star.Post(k+1).Thresh] = T2MapNew(indatapost, tespost, minimum, maxT2, display );
%      mySlice = num2str(k+1);
%      PreMapsStar = strcat(myFileV,'T2Star_Pre_Slice_',mySlice,'Map');  
%      csvwrite(PreMapsStar,Analysis.T2Star.Pre(k+1).Maps);
%      PostMaps = strcat(myFileV,'T2Star_Post_Slice_',mySlice,'Map');
%      csvwrite(PostMapsStar,Analysis.T2Star.Post(k+1).Maps);
%      clear Analysis
%    else
%        sprintf('%s','T2* Maps Generated...Yay!')
%    end
%end

%close all
%Calculate deltaT2,deltaT2*,deltaR2 and deltaR2*

%for n = 1:numel(Analysis.T2.Pre)
%    Analysis.deltaT2(n).Maps = Analysis.T2.Pre(n).Maps(:,:,1)./Analysis.T2.Post(n).Maps(:,:,1);
%    Analysis.deltaR2(n).Maps = Analysis.T2.Pre(n).Maps(:,:,2)./Analysis.T2.Post(n).Maps(:,:,2);
%end

%for n = 1:numel(Analysis.T2Star.Pre)
%    Analysis.deltaT2Star(n).Maps = Analysis.T2Star.Pre(n).Maps(:,:,1)./Analysis.T2Star.Post(n).Maps(:,:,1);
%    Analysis.deltaR2Star(n).Maps = Analysis.T2Star.Pre(n).Maps(:,:,2)./Analysis.T2Star.Post(n).Maps(:,:,2);
%end

%for n = 1:numel(Analysis.deltaR2)
%    Analysis.VSI(n).Maps = Analysis.deltaR2Star(n).Maps./Analysis.deltaR2(n).Maps;
%    Analysis.VDI(n).Maps = Analysis.VSI(n).Maps.^(-1);
%    Analysis.VSI32(n).Maps = (sqrt(Analysis.deltaR2Star(n).Maps./Analysis.deltaR2(n).Maps)).^3;
%end

end

