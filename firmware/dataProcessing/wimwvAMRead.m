
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

    mintsData  =  rmmissing(retime(table2timetable(mintsData),'regular',@nanmean,'TimeStep',timeSpan));

    %% Clear temporary variables
    clear opts

end
