#### Patient.GFA.myaparc36  ####
library(R.matlab)
library(tidyverse)
setwd("~/DSI_DTI_FA_ConnMatrix")
dsiStudio = "/Applications/dsi_studio.app/Contents/MacOS/dsi_studio"
loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/"
gfa_folder = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/P"
#DSI Parameters
connType = "pass"
parcScheme = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/Parcellations/myaparc_36_masked-in-rawavg.nii.gz"

#create empty list for connectivity data
gfa_pt_connmatrices = list()

#Save names of all files in directory 'loc'
list_of_files = list.files(path = loc)
#start count = 1 
count = 1 

for(i in list_of_files){
  
  #set wd back to ~/DSI_DTI_FA_ConnMatrix
  setwd("~/DSI_DTI_FA_ConnMatrix")
  #input file set according to count
  input_file = list.files(loc)[count]
  
  #start of generating connectivity matrices
  print("gfa connectivity matrices")
  #check which file being used
  print(paste0("calculating gfa connectivity matrix for ", input_file))
  
  ## generate connectivity matrix  
  genConn = paste0("--action=trk --source=/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/", input_file, " --connectivity=", parcScheme, " --connectivity_value=gfa --connectivity_type=", connType, " --connectivity_threshold=0 --thread_count=1 --seed_count=50000 --fa_threshold=0.1 --output=", gfa_folder) 
  system(paste(dsiStudio, genConn))
  
  #change wd so outputs stored in right place
  setwd("~/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output")
  
  # rename files for right participant 
  participant_id = sub("\\..*", "", i)
  new_file_name = paste0(participant_id, ".gfa.myaparc.36.masked.inrawavg.mat")
  file.rename("P.myaparc_36_masked-in-rawavg.gfa.pass.connectivity.mat", new_file_name) 
  
  #remove text files from output folder
  file.remove(file.path("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/", list.files("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/", pattern = "\\.txt$")))
  
  #Load matrix
  gfa_connmatrix = readMat(new_file_name)
  gfa_connmatrix = gfa_connmatrix$connectivity
  
  #rename rows and columns 
  region_names36 = read.delim("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/Parcellations/myaparc_36_masked-in-rawavg.txt", header=FALSE)
  region_names36$V1 = gsub('^[[:digit:]]+', '', region_names36$V1)
  region_names36$V1 = gsub(" ", "", region_names36$V1, fixed = TRUE)
  region_names36$V1 = gsub("-", "_", region_names36$V1, fixed = TRUE)
  rownames(gfa_connmatrix) = region_names36$V1
  colnames(gfa_connmatrix) = region_names36$V1
  
  #remove unwanted regions 
  gfa_connmatrix = gfa_connmatrix[!str_detect(colnames(gfa_connmatrix), "White_Matter|Vent|Cerebellum|Brain_Stem|CSF|vessel|choroid_plexus|WM_hypointensities|Optic_Chiasm|CC|unknown|corpuscallosum"), !str_detect(colnames(gfa_connmatrix), "White_Matter|Vent|Cerebellum|Brain_Stem|CSF|vessel|choroid_plexus|WM_hypointensities|Optic_Chiasm|CC|unknown|corpuscallosum")] 
  
  #add to list
  parcellation = "myaparc.36"
  gfa_pt_connmatrices[[parcellation]][[participant_id]] = list(gfa_connectivity = gfa_connmatrix)
  
  #if count = x stop
  if(count==62){
    print(count)
    print("end of batch")
    break}
  #increase count
  count = count + 1
  
}



#### Patient.GFA.myaparc60  ####
library(R.matlab)
library(tidyverse)
setwd("~/DSI_DTI_FA_ConnMatrix")
dsiStudio = "/Applications/dsi_studio.app/Contents/MacOS/dsi_studio"
loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/"
gfa_folder = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/P"
#DSI Parameters
connType = "pass"
parcScheme = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/Parcellations/myaparc_60_masked-in-rawavg.nii.gz"

#Save names of all files in directory 'loc'
list_of_files = list.files(path = loc)
#start count = 1 
count = 1 

for(i in list_of_files){
  
  #set wd back to ~/DSI_DTI_FA_ConnMatrix
  setwd("~/DSI_DTI_FA_ConnMatrix")
  #input file set according to count
  input_file = list.files(loc)[count]
  
  #start of generating connectivity matrices
  print("gfa connectivity matrices")
  #check which file being used
  print(paste0("calculating gfa connectivity matrix for ", input_file))
  
  ## generate connectivity matrix  
  genConn = paste0("--action=trk --source=/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/", input_file, " --connectivity=", parcScheme, " --connectivity_value=gfa --connectivity_type=", connType, " --connectivity_threshold=0 --thread_count=1 --seed_count=50000 --fa_threshold=0.1 --output=", gfa_folder) 
  system(paste(dsiStudio, genConn))
  
  #change wd so outputs stored in right place
  setwd("~/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output")
  
  # rename files for right participant 
  participant_id = sub("\\..*", "", i)
  new_file_name = paste0(participant_id, ".gfa.myaparc.60.masked.inrawavg.mat")
  file.rename("P.myaparc_60_masked-in-rawavg.gfa.pass.connectivity.mat", new_file_name) 
  
  #remove text files from output folder
  file.remove(file.path("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/", list.files("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/", pattern = "\\.txt$")))
  
  #Load matrix
  gfa_connmatrix = readMat(new_file_name)
  gfa_connmatrix = gfa_connmatrix$connectivity
  
  #rename rows and columns 
  region_names60 = read.delim("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/Parcellations/myaparc_60_masked-in-rawavg.txt", header=FALSE)
  region_names60$V1 = gsub('^[[:digit:]]+', '', region_names60$V1)
  region_names60$V1 = gsub(" ", "", region_names60$V1, fixed = TRUE)
  region_names60$V1 = gsub("-", "_", region_names60$V1, fixed = TRUE)
  rownames(gfa_connmatrix) = region_names60$V1
  colnames(gfa_connmatrix) = region_names60$V1
  
  #remove unwanted regions 
  gfa_connmatrix = gfa_connmatrix[!str_detect(colnames(gfa_connmatrix), "White_Matter|Vent|Cerebellum|Brain_Stem|CSF|vessel|choroid_plexus|WM_hypointensities|Optic_Chiasm|CC|unknown|corpuscallosum"), !str_detect(colnames(gfa_connmatrix), "White_Matter|Vent|Cerebellum|Brain_Stem|CSF|vessel|choroid_plexus|WM_hypointensities|Optic_Chiasm|CC|unknown|corpuscallosum")] 
  
  #add to list
  parcellation = "myaparc.60"
  gfa_pt_connmatrices[[parcellation]][[participant_id]] = list(gfa_connectivity = gfa_connmatrix)
  
  #if count = x stop
  if(count==62){
    print(count)
    print("end of batch")
    break}
  #increase count
  count = count + 1
  
}


#### Patient.GFA.myaparc125  ####
setwd("~/DSI_DTI_FA_ConnMatrix")
dsiStudio = "/Applications/dsi_studio.app/Contents/MacOS/dsi_studio"
loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/"
gfa_folder = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/P"
#DSI Parameters
connType = "pass"
parcScheme = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/Parcellations/myaparc_125_masked-in-rawavg.nii.gz"

#Save names of all files in directory 'loc'
list_of_files = list.files(path = loc)
#start count = 1 
count = 1 

for(i in list_of_files){
  
  #set wd back to ~/DSI_DTI_FA_ConnMatrix
  setwd("~/DSI_DTI_FA_ConnMatrix")
  #input file set according to count
  input_file = list.files(loc)[count]
  
  #start of generating connectivity matrices
  print("gfa connectivity matrices")
  #check which file being used
  print(paste0("calculating gfa connectivity matrix for ", input_file))
  
  ## generate connectivity matrix  
  genConn = paste0("--action=trk --source=/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/", input_file, " --connectivity=", parcScheme, " --connectivity_value=gfa --connectivity_type=", connType, " --connectivity_threshold=0 --thread_count=1 --seed_count=50000 --fa_threshold=0.1 --output=", gfa_folder) 
  system(paste(dsiStudio, genConn))
  
  #change wd so outputs stored in right place
  setwd("~/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output")
  
  # rename files for right participant 
  participant_id = sub("\\..*", "", i)
  new_file_name = paste0(participant_id, ".gfa.myaparc.125.masked.inrawavg.mat")
  file.rename("P.myaparc_125_masked-in-rawavg.gfa.pass.connectivity.mat", new_file_name) 
  
  #remove text files from output folder
  file.remove(file.path("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/", list.files("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/", pattern = "\\.txt$")))
  
  #Load matrix
  gfa_connmatrix = readMat(new_file_name)
  gfa_connmatrix = gfa_connmatrix$connectivity
  
  #rename rows and columns 
  region_names125 = read.delim("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/Parcellations/myaparc_125_masked-in-rawavg.txt", header=FALSE)
  region_names125$V1 = gsub('^[[:digit:]]+', '', region_names125$V1)
  region_names125$V1 = gsub(" ", "", region_names125$V1, fixed = TRUE)
  region_names125$V1 = gsub("-", "_", region_names125$V1, fixed = TRUE)
  rownames(gfa_connmatrix) = region_names125$V1
  colnames(gfa_connmatrix) = region_names125$V1
  
  #remove unwanted regions 
  gfa_connmatrix = gfa_connmatrix[!str_detect(colnames(gfa_connmatrix), "White_Matter|Vent|Cerebellum|Brain_Stem|CSF|vessel|choroid_plexus|WM_hypointensities|Optic_Chiasm|CC|unknown|corpuscallosum"), !str_detect(colnames(gfa_connmatrix), "White_Matter|Vent|Cerebellum|Brain_Stem|CSF|vessel|choroid_plexus|WM_hypointensities|Optic_Chiasm|CC|unknown|corpuscallosum")] 
  
  #add to list
  parcellation = "myaparc.125"
  gfa_pt_connmatrices[[parcellation]][[participant_id]] = list(gfa_connectivity = gfa_connmatrix)
  
  #if count = x stop
  if(count==62){
    print(count)
    print("end of batch")
    break}
  #increase count
  count = count + 1
  
}


#### Patient.GFA.myaparc250 ####
setwd("~/DSI_DTI_FA_ConnMatrix")
dsiStudio = "/Applications/dsi_studio.app/Contents/MacOS/dsi_studio"
loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/"
gfa_folder = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/P"
#DSI Parameters
connType = "pass"
parcScheme = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/Parcellations/myaparc_250_masked-in-rawavg.nii.gz"

#Save names of all files in directory 'loc'
list_of_files = list.files(path = loc)
#start count = 1 
count = 1 

for(i in list_of_files){
  
  #set wd back to ~/DSI_DTI_FA_ConnMatrix
  setwd("~/DSI_DTI_FA_ConnMatrix")
  #input file set according to count
  input_file = list.files(loc)[count]
  
  #start of generating connectivity matrices
  print("gfa connectivity matrices")
  #check which file being used
  print(paste0("calculating gfa connectivity matrix for ", input_file))
  
  ## generate connectivity matrix  
  genConn = paste0("--action=trk --source=/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/", input_file, " --connectivity=", parcScheme, " --connectivity_value=gfa --connectivity_type=", connType, " --connectivity_threshold=0 --thread_count=1 --seed_count=50000 --fa_threshold=0.1 --output=", gfa_folder) 
  system(paste(dsiStudio, genConn))
  
  #change wd so outputs stored in right place
  setwd("~/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output")
  
  # rename files for right participant 
  participant_id = sub("\\..*", "", i)
  new_file_name = paste0(participant_id, ".gfa.myaparc.250.masked.inrawavg.mat")
  file.rename("P.myaparc_250_masked-in-rawavg.gfa.pass.connectivity.mat", new_file_name) 
  
  #remove text files from output folder
  file.remove(file.path("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/", list.files("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/gfa_pt_Output/", pattern = "\\.txt$")))
  
  #Load matrix
  gfa_connmatrix = readMat(new_file_name)
  gfa_connmatrix = gfa_connmatrix$connectivity
  
  #rename rows and columns 
  region_names250 = read.delim("/Users/meg/DSI_DTI_FA_ConnMatrix/Data/Parcellations/myaparc_250_masked-in-rawavg.txt", header=FALSE)
  region_names250$V1 = gsub('^[[:digit:]]+', '', region_names250$V1)
  region_names250$V1 = gsub(" ", "", region_names250$V1, fixed = TRUE)
  region_names250$V1 = gsub("-", "_", region_names250$V1, fixed = TRUE)
  rownames(gfa_connmatrix) = region_names250$V1
  colnames(gfa_connmatrix) = region_names250$V1
  
  #remove unwanted regions 
  gfa_connmatrix = gfa_connmatrix[!str_detect(colnames(gfa_connmatrix), "White_Matter|Vent|Cerebellum|Brain_Stem|CSF|vessel|choroid_plexus|WM_hypointensities|Optic_Chiasm|CC|unknown|corpuscallosum"), !str_detect(colnames(gfa_connmatrix), "White_Matter|Vent|Cerebellum|Brain_Stem|CSF|vessel|choroid_plexus|WM_hypointensities|Optic_Chiasm|CC|unknown|corpuscallosum")] 
  
  #add to list
  parcellation = "myaparc.250"
  gfa_pt_connmatrices[[parcellation]][[participant_id]] = list(gfa_connectivity = gfa_connmatrix)
  
  #if count = x stop
  if(count==62){
    print(count)
    print("end of batch")
    break}
  #increase count
  count = count + 1
  
}


print("end of connectivity matrices for gfa for patients using all 4 myaparc parcellations")