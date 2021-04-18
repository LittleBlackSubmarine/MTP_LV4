%-- Ucitavanje podataka--
PID_data = load('pima-indians-diabetes.csv');

DPoz = PID_data(PID_data(:,9)==1,:);
DNeg = PID_data(PID_data(:,9)==0,:);
Features = ["Pregnancies","Plasma glucose conc.","Diastolic pressure",...
    "Tricep skin fold thickness","Serum insulin","BMI","Pedigree","Age"];
Units = [" ","[mg/dL]","[mm Hg]","[mm]","[mu U/ml]","[Weight/Height^2]",...
    " ","[Years]"];


%-- Srednja vrijednost, medijan i standarna devijacija--
DPoz_mean = [];
DPoz_median = [];
DPoz_mode = [];
DPoz_var = [];
DPoz_std = [];

DNeg_mean = [];
DNeg_median = [];
DNeg_mode = [];
DNeg_var = [];
DNeg_std = [];
 
for i=1:8
    
    DPoz_mean = [DPoz_mean, mean(DPoz(:,i))];
    DPoz_median = [DPoz_median, median(DPoz(:,i))];
    DPoz_mode = [DPoz_mode, mode(DPoz(:,i))];
    DPoz_var = [DPoz_var, var(DPoz(:,i))];
    DPoz_std = [DPoz_std, std(DPoz(:,i))];

    DNeg_mean = [DNeg_mean, mean(DNeg(:,i))]; 
    DNeg_median = [DNeg_median, median(DNeg(:,i))] ;
    DNeg_mode = [DNeg_mode, mode(DNeg(:,i))] ;
    DNeg_var = [DNeg_var, var(DNeg(:,i))] ;
    DNeg_std = [DNeg_std, std(DNeg(:,i))] ;
    
end


%-- Histogrami--
for i=1:8
   
    hist = figure(i);
    histogram(DPoz(:,i),12);
    hold on;
    histogram(DNeg(:,i),12);
    title(strcat(Features(i)," histogram"));
    ylabel("Measurements quantity")
    xlabel(strcat(Features(i),Units(i)));
    legend("Positive", "Negative")
    saveas(hist,sprintf('Histogram %d.jpg',i))
    
end


%-- Empirijska kumulativna funkcija--
for i=1:8
   
    [f,x] = ecdf(DPoz(:,i));
    [f1,x1] = ecdf(DNeg(:,i));
     EDF = figure(8 + i); plot(x,f);
     hold on; plot(x1,f1,'r');
     title(strcat(Features(i)," EDF"))
     xlabel(strcat(Features(i),Units(i)));
     ylabel("f(X)");
     legend('Positive','Negative')
     saveas(EDF,sprintf('EDF %d.jpg',i));
    
end


%-- Box-plot--
Col_names = {'Pregnancies','Plasma glucose conc.',...
        'Diastolic pressure','Tricep skin fold thickness',...
        'Serum insulin','BMI','Pedigree','Age'};
idx1 = 15;
idx2 = 16;
    
for i = 1:8

idx1 = idx1 + 2;
idx2 = idx2 + 2;
    
BPP = figure(idx1) ;   
boxplot(DPoz(:,i),'orientation','horizontal','labels',Col_names{i});
xlabel("Unit");
title('Positive')
saveas(BPP,sprintf('Box-plot++  %d.jpg',i))
    
BPN = figure(idx2);
boxplot(DNeg(:,i),'orientation','horizontal','labels',Col_names{i});
xlabel("Unit");
title('Negative')
saveas(BPN,sprintf('Box-plot--  %d.jpg',i))

end


%-- 2D dijagram rasipanja--
Features_S2D = [1,3,4,5,6];
idxs=1:700;
grpD = PID_data(idxs,9);
for i=1:5
    
    f = Features_S2D(i);
   
    S2D = figure(32+i);
    scatterhist(PID_data(idxs,2),PID_data(idxs,f),'Group',grpD,'Marker','..',...
        'Color','br');
    title(strcat(Features(2),"-",Features(f)));
    xlabel(strcat(Features(2),Units(2)));
    ylabel(strcat(Features(f),Units(f)));
    legend('Positive','Negative')
    saveas(S2D,sprintf('2D Scatter 2-x  %d.jpg',i))
    
end   

for i=1:5
    
    f = Features_S2D(i);
   
    S2D = figure(37+i);
    scatterhist(PID_data(idxs,7),PID_data(idxs,f),'Group',grpD,'Marker','..',...
        'Color','br');
    title(strcat(Features(7),"-",Features(f)));
    xlabel(strcat(Features(7),Units(7)));
    ylabel(strcat(Features(f),Units(f)));
    legend('Positive','Negative')
    saveas(S2D,sprintf('2D Scatter 7-x  %d.jpg',i))
    
end   


