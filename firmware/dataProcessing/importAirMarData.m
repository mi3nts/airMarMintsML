function [] = importAirMarData(yamlFile)
%GETAIRMARDATA Summary of this function goes here
%   Detailed explanation goes here
    %% MINTS Definitions 

    display(newline)
    display("---------------------MINTS---------------------")

    addpath("../../functions/")

    addpath("YAMLMatlab_0.4.3")
    mintsDefinitions  = ReadYaml(yamlFile)

    dataFolder = mintsDefinitions.dataFolder;
    airMarID   = mintsDefinitions.airMarID;
    timeSpan   = seconds(mintsDefinitions.timeSpan);

    referenceFolder          =  dataFolder + "/reference";
    referenceDotMatsFolder   =  dataFolder + "/referenceMats/airmar";

    display(newline)
    display("Data Folder Located @:"+ dataFolder)
    display("Reference Data Located @: "+ referenceFolder)
    display("Reference DotMat Data Located @ :"+ referenceDotMatsFolder)


    display(newline)

    %% Syncing Process 

    % Needs to be connected to AV 
    syncFromCloudAirmar(airMarID,dataFolder)


    %% Finding Files 

    gpggaAMFiles =  dir(strcat(referenceFolder,'/*/*/*/*/MINTS_',airMarID,'_GPGGA','*.csv'))
    gpvtgAMFiles =  dir(strcat(referenceFolder,'/*/*/*/*/MINTS_',airMarID,'_GPVTG','*.csv'))
    hchdtAMFiles =  dir(strcat(referenceFolder,'/*/*/*/*/MINTS_',airMarID,'_HCHDT','*.csv'))
    wimdaAMFiles =  dir(strcat(referenceFolder,'/*/*/*/*/MINTS_',airMarID,'_WIMDA','*.csv'))
    wimwvAMFiles =  dir(strcat(referenceFolder,'/*/*/*/*/MINTS_',airMarID,'_WIMWV','*.csv'))
    yxxdrAMFiles =  dir(strcat(referenceFolder,'/*/*/*/*/MINTS_',airMarID,'_YXXDR','*.csv'))


    display(" ---- ")

    %% GPSGPGGA File Record  


    if(length(gpggaAMFiles) >0)
        parfor fileNameIndex = 1: length(gpggaAMFiles)
             try
                display("Reading: "+gpggaAMFiles(fileNameIndex).name+ " " +string(fileNameIndex)) 
                GPGGAAMData{fileNameIndex} =  gpggaAMRead(strcat(gpggaAMFiles(fileNameIndex).folder,"/",gpggaAMFiles(fileNameIndex).name),timeSpan)
             catch e
                display("Error With : "+gpggaAMFiles(fileNameIndex).name+"- "+string(fileNameIndex))
                fprintf(1,'The identifier was:\n%s',e.identifier);
                fprintf(1,'There was an error! The message was:\n%s',e.message);
            end   
        end      
    end  

    concatStr  =  "mintsDataGpgga = [";

     for fileNameIndex = 1: length(gpvtgAMFiles)
         concatStr = strcat(concatStr,"GPGGAAMData{",string(fileNameIndex),"};");
     end    

    concatStr  =  strcat(concatStr,"];");

    display(concatStr);
    eval(concatStr);

    %% GPVTG File Record  

    if(length(gpvtgAMFiles) >0)
        parfor fileNameIndex = 1: length(gpvtgAMFiles)
             try
                display("Reading: "+gpvtgAMFiles(fileNameIndex).name+ " " +string(fileNameIndex)) 
                GPVTGAMData{fileNameIndex} =  gpvtgAMRead(strcat(gpvtgAMFiles(fileNameIndex).folder,"/",gpvtgAMFiles(fileNameIndex).name),timeSpan)
             catch e
                display("Error With : "+gpvtgAMFiles(fileNameIndex).name+"- "+string(fileNameIndex))
                fprintf(1,'The identifier was:\n%s',e.identifier);
                fprintf(1,'There was an error! The message was:\n%s',e.message);
            end   
        end      
    end  


    concatStr  =  "mintsDataGpvtg = [";

     for fileNameIndex = 1: length(gpvtgAMFiles)
         concatStr = strcat(concatStr,"GPVTGAMData{",string(fileNameIndex),"};");
     end    

    concatStr  =  strcat(concatStr,"];");

    display(concatStr);
    eval(concatStr);

    %% WIMDA File Record  

    if(length(wimdaAMFiles) >0)
        parfor fileNameIndex = 1: length(wimdaAMFiles)
             try
                display("Reading: "+wimdaAMFiles(fileNameIndex).name+ " " +string(fileNameIndex)) 
                WIMDAAMData{fileNameIndex} =  wimdaAMRead(strcat(wimdaAMFiles(fileNameIndex).folder,"/",wimdaAMFiles(fileNameIndex).name),timeSpan)
             catch e

                display("Error With : "+wimdaAMFiles(fileNameIndex).name+"- "+string(fileNameIndex))
                fprintf(1,'The identifier was:\n%s',e.identifier);
                fprintf(1,'There was an error! The message was:\n%s',e.message);
             end   
        end      
    end  


    concatStr  =  "mintsDataWimda = [";

     for fileNameIndex = 1: length(wimwvAMFiles)
         concatStr = strcat(concatStr,"WIMDAAMData{",string(fileNameIndex),"};");
     end    

    concatStr  =  strcat(concatStr,"];");

    display(concatStr);
    eval(concatStr);


    %% WIMWV File Record  

    if(length(wimwvAMFiles) >0)
        parfor fileNameIndex = 1: length(wimwvAMFiles)
             try
                display("Reading: "+wimwvAMFiles(fileNameIndex).name+ " " +string(fileNameIndex)) ;
                WIMWVAMData{fileNameIndex} =  wimwvAMRead(strcat(wimwvAMFiles(fileNameIndex).folder,"/",wimwvAMFiles(fileNameIndex).name),timeSpan);
             catch e
                display("Error With : "+wimwvAMFiles(fileNameIndex).name+"- "+string(fileNameIndex))
                          fprintf(1,'The identifier was:\n%s',e.identifier);
                fprintf(1,'There was an error! The message was:\n%s',e.message);
            end   
        end      
    end  



    concatStr  =  "mintsDataWimwv = [";

     for fileNameIndex = 1: length(wimwvAMFiles)
         concatStr = strcat(concatStr,"WIMWVAMData{",string(fileNameIndex),"};");
     end    

    concatStr  =  strcat(concatStr,"];");

    display(concatStr);
    eval(concatStr);



    %% HCHDT File Record  

    if(length(hchdtAMFiles) >0)
        parfor fileNameIndex = 1: length(hchdtAMFiles)
             try
                display("Reading: "+hchdtAMFiles(fileNameIndex).name+ " " +string(fileNameIndex)) 
                HCHDTAMData{fileNameIndex} = hchdtAMRead(strcat(hchdtAMFiles(fileNameIndex).folder,"/",hchdtAMFiles(fileNameIndex).name),timeSpan)
             catch e
                display("Error With : "+hchdtAMFiles(fileNameIndex).name+"- "+string(fileNameIndex))
                fprintf(1,'The identifier was:\n%s',e.identifier);
                fprintf(1,'There was an error! The message was:\n%s',e.message);
            end   
        end      
    end  

    concatStr  =  "mintsDataHchdt = [";

     for fileNameIndex = 1: length(hchdtAMFiles)
         concatStr = strcat(concatStr,"HCHDTAMData{",string(fileNameIndex),"};");
     end    

    concatStr  =  strcat(concatStr,"];");

    display(concatStr);
    eval(concatStr);



    %% YXXDR File Record  

    if(length(yxxdrAMFiles) >0)
        parfor fileNameIndex = 1: length(yxxdrAMFiles)
             try
                display("Reading: "+yxxdrAMFiles(fileNameIndex).name+ " " +string(fileNameIndex)) 
                YXXDRAMData{fileNameIndex} =  yxxdrAMRead(strcat(yxxdrAMFiles(fileNameIndex).folder,"/",yxxdrAMFiles(fileNameIndex).name),timeSpan)
             catch e
                display("Error With : "+yxxdrAMFiles(fileNameIndex).name+"- "+string(fileNameIndex))
                          fprintf(1,'The identifier was:\n%s',e.identifier);
                fprintf(1,'There was an error! The message was:\n%s',e.message);
            end   
        end      
    end  


    concatStr  =  "mintsDataYxxdr = [";

     for fileNameIndex = 1: length(yxxdrAMFiles)
         concatStr = strcat(concatStr,"YXXDRAMData{",string(fileNameIndex),"};");
     end    

    concatStr  =  strcat(concatStr,"];");

    display(concatStr);
    eval(concatStr);

    %% Synchrizing all Data 

    display("Saving Air Mar Data");

    mintsDataPre   = synchronize(mintsDataGpgga,mintsDataGpvtg,mintsDataHchdt,mintsDataWimda,mintsDataWimwv,mintsDataYxxdr,'union');
    mintsDataAll   = rmmissing(mintsDataPre,'MinNumMissing',width(mintsDataPre)-1);
    mintsData      = rmmissing(mintsDataAll);


    %% Saving All Data 
    display("Saving Airmar Data");
    saveName  = strcat(referenceDotMatsFolder,'/airMar_',airMarID,'.mat');
    folderCheck(saveName)
    save(saveName,'mintsDataAll','mintsData');




end

