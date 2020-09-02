
clc ; close all ; clear all 


%% MINTS Definitions 

display(newline)
display("---------------------MINTS---------------------")

addpath("../../functions/")

addpath("YAMLMatlab_0.4.3")
mintsDefinitions  = ReadYaml('mintsDefinitions.yaml')

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


%% Functions Used 
function [] = syncFromNas(sshPW,referenceFolder)

    %% Setup the Import Options and import the data
    system(strcat("sshpass -p ",sshPW,' rsync -avzrtu -e ssh --include="*.csv" --include="*/" --exclude="*" mintsdata@192.168.1.176:/volume1/MINTSNASCAR/reference/ '," ",referenceFolder))

end

function mintsData = gpggaRead(fileName,timeSpan)

    %% Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 17);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["dateTime", "timestamp", "latitudeCoordinate", "longitudeCoordinate", "latitude", "latitudeDirection", "longitude", "longitudeDirection", "gpsQuality", "numberOfSatellites", "HorizontalDilution", "altitude", "altitudeUnits", "undulation", "undulationUnits", "age", "stationID"];
    opts.VariableTypes = ["datetime", "datetime", "double", "double", "double", "categorical", "double", "categorical", "double", "double", "double", "double", "categorical", "double", "categorical", "string", "string"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, ["age", "stationID"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["latitudeDirection", "longitudeDirection", "altitudeUnits", "undulationUnits", "age", "stationID"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "dateTime", "InputFormat", "yyyy-MM-dd HH:mm:ss.SSS");
    opts = setvaropts(opts, "timestamp", "InputFormat", "HH:mm:ss");

    % Import the data
    mintsData = readtable(fileName, opts);
      
           
    mintsData = removevars( mintsData,{...    
                   'timestamp'          ,...
                   'latitude'           ,...
                   'latitudeDirection'  ,...
                   'longitude'          ,...
                   'longitudeDirection' ,...
                   'gpsQuality'         ,...
                   'numberOfSatellites' ,...
                   'HorizontalDilution' ,...       
                   'altitude'           ,...
                   'altitudeUnits'      ,...
                   'undulation'         ,...
                   'undulationUnits'    ,...
                   'age'                ,...
                   'stationID'          }...
               );
           
    
    mintsData.dateTime.TimeZone = "utc";

    mintsData   =  retime(table2timetable(mintsData),'regular',@nanmean,'TimeStep',timeSpan);
    
    
    
     %% Clear temporary variables
    clear opts

end


function mintsData = gprmcRead(fileName,timeSpan)
    %% Import data from text file
    % Script for importing data from the following text file:
    %
    %    filename: /media/teamlary/teamlary1/gitHubRepos/carMintsML/firmware/dataProcessing/MINTS_001e0610c2e7_GPSGPRMC1_2020_04_04.csv
    %
    % Auto-generated by MATLAB on 26-Aug-2020 10:40:43

    %% Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 13);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["dateTime", "timestamp", "status", "latitudeCoordinate", "longitudeCoordinate", "latitude", "latitudeDirection", "longitude", "longitudeDirection", "speedOverGround", "trueCourse", "dateStamp", "magVariationDirection"];
    opts.VariableTypes = ["datetime", "datetime", "categorical", "double", "double", "double", "categorical", "double", "categorical", "double", "string", "datetime", "string"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, ["trueCourse", "magVariationDirection"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["status", "latitudeDirection", "longitudeDirection", "trueCourse", "magVariationDirection"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "dateTime", "InputFormat", "yyyy-MM-dd HH:mm:ss.SSS");
    opts = setvaropts(opts, "timestamp", "InputFormat", "HH:mm:ss");
    opts = setvaropts(opts, "dateStamp", "InputFormat", "yyyy-MM-dd");

    % Import the data
    mintsData = readtable(fileName, opts);
        
    mintsData = removevars( mintsData,{...    
                    'timestamp',...
                    'status'               ,...
                    'latitude'             ,...
                    'latitudeDirection'    ,...
                    'longitude'            ,...
                    'longitudeDirection'   ,...
                    'speedOverGround'      ,...
                    'trueCourse'           ,...
                    'dateStamp'            ,...
                    'magVariationDirection'}...
                    );
        
    mintsData.dateTime.TimeZone = "utc";

    mintsData   = retime(table2timetable(mintsData),'regular',@nanmean,'TimeStep',timeSpan);
 %% Clear temporary variables
    clear opts      

end



%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /media/teamlary/teamlary1/gitHubRepos/carMintsML/firmware/dataProcessing/MINTS_001e0610c2e9_GPGGA_2020_06_27.csv
%
% Auto-generated by MATLAB on 27-Aug-2020 08:12:37

function mintsData = gpggaAMRead(fileName,timeSpan)
%% Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 16);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["dateTime", "UTCTimeStamp", "latitude", "latDirection", "longitude", "lonDirection", "gpsQuality", "numberOfSatellites", "horizontalDilution", "altitude", "AUnits", "geoidalSeparation", "GSUnits", "ageOfDifferential", "stationID", "checkSum"];
    opts.VariableTypes = ["datetime", "double", "double", "categorical", "double", "categorical", "double", "double", "double", "double", "categorical", "double", "categorical", "string", "string", "double"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, ["ageOfDifferential", "stationID"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["latDirection", "lonDirection", "AUnits", "GSUnits", "ageOfDifferential", "stationID"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "dateTime", "InputFormat", "yyyy-MM-dd HH:mm:ss.SSS");

    % Import the data
    mintsData = readtable(fileName, opts);
    
    mintsData.dateTime.TimeZone = "utc";

        
    % Conversion to Coordinates 
    mintsData.latitudeCoordinate = floor(mintsData.latitude/100)+ rem(mintsData.latitude,100)/60 ;
    if mintsData.latDirection == 'S'
        mintsData.latitudeCoordinate= mintsData.latitudeCoordinate *-1; 
    end
    mintsData.longitudeCoordinate = floor(mintsData.longitude/100)+ rem(mintsData.longitude,100)/60 ;
    if mintsData.lonDirection == 'W'
        mintsData.longitudeCoordinate= mintsData.longitudeCoordinate *-1; 
    end
    
    mintsData = removevars( mintsData,{...    
                      'latitude'          ,...
                      'latDirection'      ,...
                      'longitude'         ,...
                      'lonDirection'      ,...
                     'UTCTimeStamp'      ,...
                     'gpsQuality'        ,...
                     'numberOfSatellites',...
                     'horizontalDilution',...
                     'altitude'          ,...
                     'AUnits'            ,...
                     'geoidalSeparation' ,...
                     'GSUnits'           ,...
                     'ageOfDifferential' ,...
                     'stationID'         ,...
                     'checkSum'          ...
                                    });
                                

     mintsData   =  retime(table2timetable(mintsData),'regular',@nanmean,'TimeStep',timeSpan);

    %% Clear temporary variables
    clear opts
    
end

function mintsData = gpvtgAMRead(fileName,timeSpan)
    
    %% Import data from text file
    % Script for importing data from the following text file:
    %
    %    filename: /media/teamlary/teamlary1/gitHubRepos/airMarMintsML/firmware/dataProcessing/MINTS_001e0610c0e4_GPVTG_2020_08_12.csv
    %
    % Auto-generated by MATLAB on 28-Aug-2020 11:56:01

    %% Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 11);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["dateTime", "courseOGTrue", "relativeToTN", "courseOGMagnetic", "relativeToMN", "speedOverGroundKnots", "SOGKUnits", "speedOverGroundKMPH", "SOGKMPHUnits", "mode", "checkSum"];
    opts.VariableTypes = ["datetime", "double", "categorical", "double", "categorical", "double", "categorical", "double", "categorical", "categorical", "double"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, ["relativeToTN", "relativeToMN", "SOGKUnits", "SOGKMPHUnits", "mode"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "dateTime", "InputFormat", "yyyy-MM-dd HH:mm:ss.SSS");

    % Import the data
    mintsData = readtable(fileName, opts);
    mintsData.dateTime.TimeZone = "utc";

    mintsData = removevars( mintsData,{...    
                                'relativeToTN'        ,...
                                'relativeToMN'       ,...
                                'SOGKUnits'           ,...
                                'SOGKMPHUnits'        ,...
                                'mode'                ,...
                                'checkSum'            ,...
                                });

    mintsData   =  retime(table2timetable(mintsData),'regular',@nanmean,'TimeStep',timeSpan);
    
    %% Clear temporary variables
    clear opts
    
end

function mintsData =hchdtAMRead(fileName,timeSpan)

    %% Import data from text file
    % Script for importing data from the following text file:

    % Auto-generated by MATLAB on 31-Aug-2020 08:01:46

    %% Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 4);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["dateTime", "heading", "HID", "checkSum"];
    opts.VariableTypes = ["datetime", "double", "categorical", "double"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, "HID", "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "dateTime", "InputFormat", "yyyy-MM-dd HH:mm:ss.SSS");
    opts = setvaropts(opts, "checkSum", "TrimNonNumeric", true);
    opts = setvaropts(opts, "checkSum", "ThousandsSeparator", ",");

    % Import the data
    mintsData = readtable(fileName, opts);
    mintsData = removevars( mintsData,{'HID'    ,...
                                      'checkSum'});
        mintsData.dateTime.TimeZone = "utc";


    mintsData   =  retime(table2timetable(mintsData),'regular',@nanmean,'TimeStep',timeSpan);

    %% Clear temporary variables
    clear opts
    
end

function mintsData = wimdaAMRead(fileName,timeSpan)
    %% Import data from text file
    % Script for importing data from the following text file:
    %
    %    filename: /media/teamlary/teamlary1/gitHubRepos/airMarMintsML/firmware/dataProcessing/MINTS_001e0610c0e4_WIMDA_2020_08_12.csv
    %
    % Auto-generated by MATLAB on 31-Aug-2020 08:05:08

    %% Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 22);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["dateTime", "barrometricPressureMercury", "BPMUnits", "barrometricPressureBars", "BPBUnits", "airTemperature", "ATUnits", "waterTemperature", "WTUnits", "relativeHumidity", "absoluteHumidity", "dewPoint", "DPUnits", "windDirectionTrue", "WDTUnits", "windDirectionMagnetic", "WDMUnits", "windSpeedKnots", "WSKUnits", "windSpeedMetersPerSecond", "WSMPSUnits", "checkSum"];
    opts.VariableTypes = ["datetime", "double", "categorical", "double", "categorical", "double", "categorical", "string", "string", "double", "string", "double", "categorical", "double", "categorical", "double", "categorical", "double", "categorical", "double", "categorical", "double"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, ["waterTemperature", "WTUnits", "absoluteHumidity"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["BPMUnits", "BPBUnits", "ATUnits", "waterTemperature", "WTUnits", "absoluteHumidity", "DPUnits", "WDTUnits", "WDMUnits", "WSKUnits", "WSMPSUnits"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "dateTime", "InputFormat", "yyyy-MM-dd HH:mm:ss.SSS");

    % Import the data
    mintsData = readtable(fileName, opts);

    mintsData = removevars( mintsData,  {...
                                         'BPMUnits'                  ,...
                                         'BPBUnits'                  ,...
                                         'ATUnits'                   ,...
                                         'waterTemperature'          ,...
                                         'WTUnits'                   ,...
                                         'absoluteHumidity'          ,...
                                         'DPUnits'                   ,...
                                         'WDTUnits'                  ,...
                                         'WDMUnits'                  ,...
                                         'WSKUnits'                  ,...
                                         'WSMPSUnits'                ,...
                                         'checkSum'                  ,...
                                        });

                                    mintsData.dateTime.TimeZone = "utc";

                                    
    mintsData  =  retime(table2timetable(mintsData),'regular',@nanmean,'TimeStep',timeSpan);
           
    %% Clear temporary variables
    clear opts

end


function mintsData = wimwvAMRead(fileName,timeSpan)

    %% Import data from text file
    % Script for importing data from the following text file:
    %
    %    filename: /media/teamlary/teamlary1/gitHubRepos/airMarMintsML/firmware/dataProcessing/MINTS_001e0610c0e4_WIMWV_2020_08_12.csv
    %
    % Auto-generated by MATLAB on 31-Aug-2020 08:11:25

    %% Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 7);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["dateTime", "windAngle", "WAReference", "windSpeed", "WSUnits", "status", "checkSum"];
    opts.VariableTypes = ["datetime", "double", "categorical", "double", "categorical", "categorical", "double"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, ["WAReference", "WSUnits", "status"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "dateTime", "InputFormat", "yyyy-MM-dd HH:mm:ss.SSS");

    % Import the data
    mintsData = readtable(fileName, opts);
                                        
    mintsData = removevars( mintsData,{...
                                         'WAReference',...
                                         'WSUnits',...    
                                         'status' ,...
                                         'checkSum'});

    mintsData  =  retime(table2timetable(mintsData),'regular',@nanmean,'TimeStep',timeSpan);
    mintsData.dateTime.TimeZone = "utc";

    %% Clear temporary variables
    clear opts

end


function mintsData = yxxdrAMRead(fileName,timeSpan)

    %% Import data from text file
    % Script for importing data from the following text file:
    %
    %    filename: /media/teamlary/teamlary1/gitHubRepos/airMarMintsML/firmware/dataProcessing/MINTS_001e0610c0e4_YXXDR_2020_08_12.csv
    %
    % Auto-generated by MATLAB on 31-Aug-2020 08:17:32

    %% Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 18);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["dateTime", "temperature", "relativeWindChillTemperature", "TUnits", "RWCTID", "RWCTUnits", "theoreticalWindChillTemperature", "TUnits2", "TWCTID", "TWCTUnits", "heatIndex", "HIUnits", "HIID", "pressureUnits", "barrometricPressureBars", "BPBUnits", "BPBID", "checkSum"];
    opts.VariableTypes = ["datetime", "categorical", "string", "categorical", "categorical", "categorical", "string", "categorical", "categorical", "categorical", "string", "categorical", "categorical", "categorical", "double", "categorical", "categorical", "double"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, ["relativeWindChillTemperature", "theoreticalWindChillTemperature", "heatIndex"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["temperature", "relativeWindChillTemperature", "TUnits", "RWCTID", "RWCTUnits", "theoreticalWindChillTemperature", "TUnits2", "TWCTID", "TWCTUnits", "heatIndex", "HIUnits", "HIID", "pressureUnits", "BPBUnits", "BPBID"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "dateTime", "InputFormat", "yyyy-MM-dd HH:mm:ss.SSS");

    % Import the data
    mintsData = readtable(fileName, opts);

    mintsData = removevars( mintsData,{...
                                'temperature'                    ,...
                                'relativeWindChillTemperature'   ,...
                                'TUnits'                         ,...
                                'RWCTID'                         ,...
                                'RWCTUnits'                      ,...
                                'theoreticalWindChillTemperature',...
                                'TUnits2'                        ,...
                                'TWCTID'                         ,...
                                'TWCTUnits'                      ,...
                                'heatIndex'                      ,...
                                'HIUnits'                        ,...
                                'HIID'                           ,...
                                'pressureUnits'                  ,...
                                'BPBUnits'                       ,...
                                'BPBID'                          ,...
                                'checkSum'                       });
    
    mintsData  =  retime(table2timetable(mintsData),'regular',@nanmean,'TimeStep',timeSpan);
    mintsData.dateTime.TimeZone = "utc";

    %% Clear temporary variables
    clear opts

end


