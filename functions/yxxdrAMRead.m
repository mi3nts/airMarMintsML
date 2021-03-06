
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


