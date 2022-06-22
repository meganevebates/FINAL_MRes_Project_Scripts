#### load atlas binarized #### and load librarys
library(stringr)
setwd("~/DSI_DTI_FA_ConnMatrix")
load("~/DSI_DTI_FA_ConnMatrix/connections_from_atlas.RData")
#load myaparc36 binarised atlas
myaparc_36_connections_atlas = connections_from_atlas$myaparc_36_connections_from_atlas
#### load control gfa connmatrices for all parcellations from previous environment ####
load("~/DSI_DTI_FA_ConnMatrix/gfa_allparcellations_environment.RData")
control_gfa_allparc = gfa_connmatrices
#### matrix multiplication for myaparc36 gfa control matrices ####
input = control_gfa_allparc$myaparc.36
#empty list to store the multiplied matrices
control_gfa_allparc_multiplied = list()
#start count
count = 1 
#start for loop 
for(i in input){
  
  #set participant ID from files original files (all in order)
  loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/ControlData/"
  list_of_files = list.files(path = loc)
  participant_id = sub("\\..*", "", list_of_files[count])
  print(participant_id)
  #load up the gfa matrix for that participant (the way the list is formatted means you need the extra [1]) 
  input_data = input[[count]][1]$gfa_connectivity
  
  
  #check columns and rows match - the identical function returns a "TRUE" or "FALSE" 
  headers_check = identical(dimnames(input_data), dimnames(myaparc_36_connections_atlas)) 
  if(headers_check == "TRUE"){
    print("column do match")
    } else{
      print("column names do not match")
      break
    }
    #multiply matrices
    multiplied_matrix = input_data*myaparc_36_connections_atlas
    #parcellation for adding to list
    parcellation = "myaparc.36"
    #add to list w participant ID
    control_gfa_allparc_multiplied[[parcellation]][[participant_id]] = list(gfa_connectivity = multiplied_matrix)
    
  #if count = x stop
  if(count==69){
    print("count is at:")
    print(count)
    print("end of multiplying matrices for myaparc36 controls")
    break
      }
      count=count+1
}

#### matrix multiplication for myaparc60 gfa control matrices ####
#load atlas for myaparc60
myaparc_60_connections_atlas = connections_from_atlas$myaparc_60_connections_from_atlas
#change input list
input = control_gfa_allparc$myaparc.60
#start count
count = 1 
#start for loop 
for(i in input){
  
  #set participant ID from files original files (all in order)
  loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/ControlData/"
  list_of_files = list.files(path = loc)
  participant_id = sub("\\..*", "", list_of_files[count])
  print(participant_id)
  #load up the gfa matrix for that participant 
  input_data = input[[count]][1]$gfa_connectivity
  
  #check columns and rows match 
  headers_check = identical(dimnames(input_data), dimnames(myaparc_60_connections_atlas)) 
  if(headers_check == "TRUE"){
    print("column do match")
  } else{
    print("column names do not match")
    break
  }
  #multiply matrices
  multiplied_matrix = input_data*myaparc_60_connections_atlas
  #parcellation for adding to list
  parcellation = "myaparc.60"
  #add to list w participant ID
  control_gfa_allparc_multiplied[[parcellation]][[participant_id]] = list(gfa_connectivity = multiplied_matrix)
  
  #if count = x stop
  if(count==69){
    print("count is at:")
    print(count)
    print("end of multiplying matrices for myaparc60 controls")
    break
  }
  count=count+1
}


#### matrix multiplication for myaparc125 gfa control matrices ####
#load atlas for myaparc125
myaparc_125_connections_atlas = connections_from_atlas$myaparc_125_connections_from_atlas
#change input list
input = control_gfa_allparc$myaparc.125
#start count
count = 1 
#start for loop 
for(i in input){
  
  #set participant ID from files original files (all in order)
  loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/ControlData/"
  list_of_files = list.files(path = loc)
  participant_id = sub("\\..*", "", list_of_files[count])
  print(participant_id)
  #load up the gfa matrix for that participant 
  input_data = input[[count]][1]$gfa_connectivity
  
  #check columns and rows match 
  headers_check = identical(dimnames(input_data), dimnames(myaparc_125_connections_atlas)) 
  if(headers_check == "TRUE"){
    print("column do match")
  } else{
    print("column names do not match")
    break
  }
  #multiply matrices
  multiplied_matrix = input_data*myaparc_125_connections_atlas
  #parcellation for adding to list
  parcellation = "myaparc.125"
  #add to list w participant ID
  control_gfa_allparc_multiplied[[parcellation]][[participant_id]] = list(gfa_connectivity = multiplied_matrix)
  
  #if count = x stop
  if(count==69){
    print("count is at:")
    print(count)
    print("end of multiplying matrices for myaparc125 controls")
    break
  }
  count=count+1
}


#### matrix multiplication for myaparc250 gfa control matrices ####
#load atlas for myaparc250
myaparc_250_connections_atlas = connections_from_atlas$myaparc_250_connections_from_atlas
#change input list
input = control_gfa_allparc$myaparc.250
#start count
count = 1 
#start for loop 
for(i in input){
  
  #set participant ID from files original files (all in order)
  loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/ControlData/"
  list_of_files = list.files(path = loc)
  participant_id = sub("\\..*", "", list_of_files[count])
  print(participant_id)
  #load up the gfa matrix for that participant 
  input_data = input[[count]][1]$gfa_connectivity
  #check that its bringing up the corresponding pt input for the ID its generating from previous files (comment when checked a few)
  #head.matrix(input)
  
  #check columns and rows match 
  headers_check = identical(dimnames(input_data), dimnames(myaparc_250_connections_atlas)) 
  if(headers_check == "TRUE"){
    print("column do match")
  } else{
    print("column names do not match")
    break
  }
  #multiply matrices
  multiplied_matrix = input_data*myaparc_250_connections_atlas
  #parcellation for adding to list
  parcellation = "myaparc.250"
  #add to list w participant ID
  control_gfa_allparc_multiplied[[parcellation]][[participant_id]] = list(gfa_connectivity = multiplied_matrix)
  
  #if count = x stop
  if(count==69){
    print("count is at:")
    print(count)
    print("end of multiplying matrices for myaparc250 controls")
    break
  }
  count=count+1
}

#### tidy up environment ####
rm(gfa_connmatrices,gfa_connmatrix, i, input, input_data, multiplied_matrix, region_names36, region_names60, region_names125, region_names250, connType, count, dsiStudio, genConn, gfa_folder, headers_check, input_file, list_of_files, loc, new_file_name, parcellation, parcScheme, participant_id)

#### PATIENT MULTIPLICATION OF MATRICES ####
load("~/DSI_DTI_FA_ConnMatrix/pt_gfa_allparcellations_environment.RData")
patient_gfa_allparc = gfa_pt_connmatrices

#### matrix multiplication for myaparc36 gfa patient matrices ####
input = patient_gfa_allparc$myaparc.36
#empty list to store the multiplied matrices
patient_gfa_allparc_multiplied = list()
#start count
count = 1 
#start for loop 
for(i in input){
  
  #set participant ID from files original files (all in order)
  loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/"
  list_of_files = list.files(path = loc)
  participant_id = sub("\\..*", "", list_of_files[count])
  print(participant_id)
  #load up the gfa matrix for that participant (the way the list is formatted means you need the extra [1]) 
  input_data = input[[count]][1]$gfa_connectivity
  
  #check columns and rows match - the identical function returns a "TRUE" or "FALSE" 
  headers_check = identical(dimnames(input_data), dimnames(myaparc_36_connections_atlas)) 
  if(headers_check == "TRUE"){
    print("column do match")
  } else{
    print("column names do not match")
    break
  }
  #multiply matrices
  multiplied_matrix = input_data*myaparc_36_connections_atlas
  #parcellation for adding to list
  parcellation = "myaparc.36"
  #add to list w participant ID
  patient_gfa_allparc_multiplied[[parcellation]][[participant_id]] = list(gfa_connectivity = multiplied_matrix)
  
  #if count = x stop
  if(count==61){
    print("count is at:")
    print(count)
    print("end of multiplying matrices for myaparc36 patients")
    break
  }
  count=count+1
}

#### matrix multiplication for myaparc60 gfa patient matrices ####
#load atlas for myaparc60
myaparc_60_connections_atlas = connections_from_atlas$myaparc_60_connections_from_atlas
#change input list
input = patient_gfa_allparc$myaparc.60
#start count
count = 1 
#start for loop 
for(i in input){
  
  #set participant ID from files original files (all in order)
  loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/"
  list_of_files = list.files(path = loc)
  participant_id = sub("\\..*", "", list_of_files[count])
  print(participant_id)
  #load up the gfa matrix for that participant (the way the list is formatted means you need the extra [1]) 
  input_data = input[[count]][1]$gfa_connectivity
  
  
  #check columns and rows match - the identical function returns a "TRUE" or "FALSE" 
  headers_check = identical(dimnames(input_data), dimnames(myaparc_60_connections_atlas)) 
  if(headers_check == "TRUE"){
    print("column do match")
  } else{
    print("column names do not match")
    break
  }
  #multiply matrices
  multiplied_matrix = input_data*myaparc_60_connections_atlas
  #parcellation for adding to list
  parcellation = "myaparc.60"
  #add to list w participant ID
  patient_gfa_allparc_multiplied[[parcellation]][[participant_id]] = list(gfa_connectivity = multiplied_matrix)
  
  #if count = x stop
  if(count==61){
    print("count is at:")
    print(count)
    print("end of multiplying matrices for myaparc60 patients")
    break
  }
  count=count+1
}


#### matrix multiplication for myaparc125 gfa patient matrices ####
#load atlas for myaparc125
myaparc_125_connections_atlas = connections_from_atlas$myaparc_125_connections_from_atlas
#change input list
input = patient_gfa_allparc$myaparc.125
#start count
count = 1 
#start for loop 
for(i in input){
  
  #set participant ID from files original files (all in order)
  loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/"
  list_of_files = list.files(path = loc)
  participant_id = sub("\\..*", "", list_of_files[count])
  print(participant_id)
  #load up the gfa matrix for that participant (the way the list is formatted means you need the extra [1]) 
  input_data = input[[count]][1]$gfa_connectivity
  
  
  #check columns and rows match - the identical function returns a "TRUE" or "FALSE" 
  headers_check = identical(dimnames(input_data), dimnames(myaparc_125_connections_atlas)) 
  if(headers_check == "TRUE"){
    print("column do match")
  } else{
    print("column names do not match")
    break
  }
  #multiply matrices
  multiplied_matrix = input_data*myaparc_125_connections_atlas
  #parcellation for adding to list
  parcellation = "myaparc.125"
  #add to list w participant ID
  patient_gfa_allparc_multiplied[[parcellation]][[participant_id]] = list(gfa_connectivity = multiplied_matrix)
  
  #if count = x stop
  if(count==61){
    print("count is at:")
    print(count)
    print("end of multiplying matrices for myaparc125 patients")
    break
  }
  count=count+1
}


#### matrix multiplication for myaparc250 gfa patient matrices ####
#load atlas for myaparc250
myaparc_250_connections_atlas = connections_from_atlas$myaparc_250_connections_from_atlas
#change input list
input = patient_gfa_allparc$myaparc.250
#start count
count = 1 
#start for loop 
for(i in input){
  
  #set participant ID from files original files (all in order)
  loc = "/Users/meg/DSI_DTI_FA_ConnMatrix/Data/PatientData/"
  list_of_files = list.files(path = loc)
  participant_id = sub("\\..*", "", list_of_files[count])
  print(participant_id)
  #load up the gfa matrix for that participant (the way the list is formatted means you need the extra [1]) 
  input_data = input[[count]][1]$gfa_connectivity
  
  #check columns and rows match - the identical function returns a "TRUE" or "FALSE" 
  headers_check = identical(dimnames(input_data), dimnames(myaparc_250_connections_atlas)) 
  if(headers_check == "TRUE"){
    print("column do match")
  } else{
    print("column names do not match")
    break
  }
  #multiply matrices
  multiplied_matrix = input_data*myaparc_250_connections_atlas
  #parcellation for adding to list
  parcellation = "myaparc.250"
  #add to list w participant ID
  patient_gfa_allparc_multiplied[[parcellation]][[participant_id]] = list(gfa_connectivity = multiplied_matrix)
  
  #if count = x stop
  if(count==61){
    print("count is at:")
    print(count)
    print("end of multiplying matrices for myaparc250 patients")
    break
  }
  count=count+1
}
print("end of multiplying matrices for patients and controls for all parcellation")

#### tidy up environment ####
rm(gfa_conmatrix, i, input, input_data, multiplied_matrix, region_names125, region_names250, region_names36, region_names60, connType, count, dsiStudio, genConn, gfa_folder, headers_check, input_file, list_of_files, loc, new_file_name, parcellation, parcScheme, participant_id)
