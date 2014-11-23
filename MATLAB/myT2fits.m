function [fitresult,gof,T2] = myT2fits(TEs,Data)

%Prep Data
[xData, yData] = prepareCurveData( TEs, Data );

%Define some Fit options
ft = fittype( 'exp1' );
opts = fitoptions( ft );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf];
opts.StartPoint = [12986.9125442292 -0.242171317822978];
opts.Upper = [Inf Inf];
opts.Normalize = 'on';

%Do Fit
[fitresult, gof] = fit( xData, yData, ft)%, opts );
mycoeffs = coeffvalues(fitresult);
T2 = -1/mycoeffs(2);

end