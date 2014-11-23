function PDAC_Data_SingleSlice(PixDataPre,PixInfoPre,PixDataPost,PixInfoPost,SliceIndex)

%T2 Analysis: T2,T2*,VSI
%-------------------------------------------------------------------------%
%Generate T2 and T2* Maps
%Output: Top Image-Threshold Image,Middle Image-T2 Map, Bottom Map-T2* Map
%Prep for T2MapNew: 
minimum=100;maxT2=2000;
tespre = zeros(1,4);
tespost = zeros(1,4);
V = floor((numel(PixDataPre))/4)
    %1)Grab consecutive sets of 4 images and save as indata
sprintf('Lets Generate your T2 Maps!')


for k = 0:(V-1)
    for j = 3:6
        if SliceIndex == 4*k+j
            display = 1;
        else
            display = 0;
        end
        index = j-2;
        indatapretemp(:,:,index) = PixDataPre(4*k+j).Data;
        temp =PixInfoPre(4*k+j).EchoTime;
        tespre(index) = temp;
    end
    indatapre=double(indatapretemp);
    [Analysis.Pre(k+1).Maps Analysis.Pre(k+1).Thresh] = T2MapNew(indatapre, tespre, minimum, maxT2, display );
    end
for k = 0:(V-1)
    for j = 3:6
        if SliceIndex == 4*k+j
            display = 1;
        else
            display = 0;
        end
        index = j-2;
        indataposttemp(:,:,index) = PixDataPost(4*k+j).Data;
        temp =PixInfoPost(4*k+j).EchoTime;
        tespost(index) = temp;
    end
    indatapre=double(indatapretemp);
    [Analysis.Post(k+1).Maps Analysis.Post(k+1).Thresh] = T2MapNew(indatapost, tespost, minimum, maxT2, display );
end



%Generate Delta T2* Maps
%Note: T2 Values=> Maps(:,:,1) && T2* Values=>Maps(:,:,2)
for M = 1:length(Analysis.Post)
    DeltaT2Star = [Analysis.Pre(M).Maps(:,:,2)./Analysis.Post(M).Maps(:,:,2)];
end


%VSI Calculations: R2/R2*, R2 = 1/T2; R2* = 1/T2*
T2 = Maps(:,:,1);
T2Star = Maps(:,:,2);
R2 = 1./T2;
R2Star = 1./T2Star;
VSI = R2/R2Star;

