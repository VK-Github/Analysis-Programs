function  GetmyStats;

%1)Get the selected folder, 2) calculate mean,median and mode for VSI,VDI
%and VVF 3) write values to appropriate xls files [VSI.xls=> mean
%sheet,median sheet etc] with fieldname: Animal #



load VSI.xls
load VVF.xls
load VDI.xls
load VSI32.xls

mymeanVSI = mean(VSI);
mymedianVSI = median(VSI);
mymodeVSI = mode(VSI);
myvarVSI = var(VSI);
mystdVSI = std(VSI);


mymeanVSI32 = mean(VSI32);
mymedianVSI32 = median(VSI32);
mymodeVSI32 = mode(VSI32);
myvarVSI32 = var(VSI32);
mystdVSI32 = std(VSI32);

mymeanVDI = mean(VDI);
mymedianVDI = median(VDI);
mymodeVDI = mode(VDI);
myvarVDI = var(VDI);
mystdVDI = std(VDI);

mymeanVVF = mean(VVF);
mymedianVVF = median(VVF);
mymodeVVF = mode(VVF);
myvarVVF = var(VVF);
mystdVVF = std(VVF);

VSIS.LOS020307WTSl2.mean = mymeanVSI;VSIS.LOS020307WTSl2.median = mymedianVSI;VSIS.LOS020307WTSl2.mode = mymodeVSI;VSIS.LOS020307WTSl2.var = myvarVSI;VSIS.LOS020307WTSl2.std = mystdVSI;
VSIS32.LOS020307WTSl2.mean = mymeanVSI32;VSIS32.LOS020307WTSl2.median = mymedianVSI32;VSIS32.LOS020307WTSl2.mode = mymodeVSI32;VSIS32.LOS020307WTSl2.var = myvarVSI32;VSIS32.LOS020307WTSl2.std = mystdVSI32;
VDIS.LOS020307WTSl2.mean = mymeanVSI;VDIS.LOS020307WTSl2.median = mymedianVSI;VDIS.LOS020307WTSl2.mode = mymodeVSI;VDIS.LOS020307WTSl2.var = myvarVSI;VDIS.LOS020307WTSl2.std = mystdVSI;
VVFS.LOS020307WTSl2.mean = mymeanVVF;VVFS.LOS020307WTSl2.median = mymedianVVF;VVFS.LOS020307WTSl2.mode = mymodeVVF;VVFS.LOS020307WTSl2.var = myvarVVF;VVFS.LOS020307WTSl2.std = mystdVVF;


VSISData =  VSIS.LOS020307WTSl2
VSI32Data = VSIS32.LOS020307WTSl2
VDIData = VDIS.LOS020307WTSl2
VVFData = VVFS.LOS020307WTSl2