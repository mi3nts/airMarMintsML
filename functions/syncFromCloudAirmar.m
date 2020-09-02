function [] = syncFromCloudAirmar(airMarID,mintsDataFolder)
    airMarFolder = strcat(mintsDataFolder,"/reference/",airMarID);

    folderCheck(airMarFolder);
    system(strcat('rsync -avzrtu --exclude={"*.png","*.jpg"} -e "ssh -p 2222" mints@mintsdata.utdallas.edu:Downloads/reference/',...
                airMarID,"/ ",airMarFolder,"/"));

end
    


