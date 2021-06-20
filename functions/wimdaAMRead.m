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