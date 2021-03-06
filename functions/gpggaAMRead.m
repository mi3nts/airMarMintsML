
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