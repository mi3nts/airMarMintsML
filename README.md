# airMarMintsML
Download and Analyize data from Airmar Weather Sensor located at the WSTC building at UTD. 


## Operation Pre Requisites 
The only requirement for the collection of airmar data is having rsync installed on your PC. 
```sudo apt install rsync grsync```


#### Example shell script to get NAS Drive data under in its raw form

```
rsync -avzrtu --exclude={"*.png","*.jpg"} -e "ssh -p 2222" mints@mintsdata.utdallas.edu:Downloads/reference/001e0610c0e4/ /media/teamlary/teamlary3/air930/mintsData/reference/001e0610c0e4/
```
**(SSH Pw for the NAS Drive will be provided on request)**

## Operation

As an initial step the YAML given should be modified. An example YAML File is given below 
<pre>── <font color="#729FCF"><b>palasAirML</b></font>
│   ├── <font color="#729FCF"><b>firmware</b></font>
│   │   └── <font color="#729FCF"><b>dataProcessing</b></font>
│   │       ├── mintsDefinitions.yaml
│   │       ├── gps0001.m
</pre>

Please choose a directory where you need to create the mints data files with the name 'mintsData'. **Make sure to keep a common 'mintsData' for all MINTS Projects**. Then point to the said folder on the yaml file under the label 'dataFolder'. Most Mints Data packages are resampled within a pre defined period for synchronizing multiple data samples. To do so the data should be resampled to a unique time period. For Airmar data and Mints Air Monitoring data sources its fit to resample to a period of 30 seconds. As such 30 can be put under timeSpan. An example implimentation of the YAML file is given below and is also given on the Repo.

```
dataFolder: "/media/teamlary/teamlary3/air930/mintsData"
c1PlusID: "001e0610c2e7"
airMarID: "001e0610c2e9"
timeSpan: 30
sshPW: "PW" 
```
Once the YAML file is updated you can run the 'airMar0001.m' file under matlab **(Make sure you point to the proper YAML file on the matlab script)**. This should result in creating a .mat file which concatinates all airmar files from the WSTC location at UTD. The file is named 'airMar_001e0610c0e4.mat' and can be found within the folder structure described below.

<pre>── <font color="#729FCF"><b>mintsData</b></font>
│   ├── <font color="#729FCF"><b>referenceMats</b></font>
│   │   └── <font color="#729FCF"><b>airmar</b></font>
│   │       ├── airMar_001e0610c0e4.mat

</pre>
The 'carMintsGPS.mat' files contains Climate data with its respective date time values. 
