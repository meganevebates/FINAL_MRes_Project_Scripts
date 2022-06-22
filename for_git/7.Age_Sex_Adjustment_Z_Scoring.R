setwd("~/DSI_DTI_FA_ConnMatrix")
library(readxl)
library(tibble)
library(dplyr)
library(tidyverse)
library(readr)
library(olsrr)
library(MASS)
#### ADDING EMPTY COLUMNS TO METADATA AND LABELLING W MATRIX NAMES ####
#empty list to store allparcellations metadata
meta.data_allparcellations = list()
metadata <- read_excel("3.Age&Sex corrections/metadata_forcorrections.xlsx")
metadata$IDP = gsub("'", "", metadata$IDP, fixed = TRUE)
#read in connectivity matrices 
load("~/DSI_DTI_FA_ConnMatrix/2.Matrix multiplication 1&2/final_multiplied_matrices_allparticipants.RData")
rm(control_gfa_allparc, combined_atlas, gfa_pt_connmatrices, myaparc_125_updated_atlas, myaparc_250_updated_atlas, myaparc_36_updated_atlas, myaparc_60_updated_atlas, patient_gfa_allparc)

#combine all gfa connectivity data into one list of all participants separated into parcellation scheme levels 
#create empty list to store
allparticipants.allparc_gfa = list()
#set so it runs through 4 times for each parcellation
parcellation_number = 1:4
#labels for each parcellation in a list
parcellation_name = c("myaparc.36", "myaparc.60", "myaparc.125", "myaparc.250")
for(myaparc in parcellation_number){
  parcellation_label = parcellation_name[myaparc]
  allparticipants.allparc_gfa[[parcellation_label]] = c(patient_gfa_allparc_multiplied_updated[[myaparc]], control_gfa_allparc_multiplied_updated[[myaparc]])
}

#### PASTING THE GFA CONNECTIVITY DATA IN FOR ALLPARCELLATIONS ####
parcellation_label = parcellation_name[1]
participants = 1:130
parcellation_number = 1:4
ID_list = as.list(metadata$IDP)

# Creating df containing IDs in first row, and correct number of empty columns for each parcellation 
list_subject_connections = list()
for(myaparc in parcellation_number){
  region_labels = colnames(control_gfa_allparc_multiplied_updated[[myaparc]]$C001$gfa_connectivity) #change for each parcellation
  subject_connections = data.frame((matrix(ncol=(length(region_labels)^2) + 1, nrow = length(ID_list))))
  region_labels_copy = region_labels

  #Compute combinations of region labels
  combinations = expand.grid(region_labels_copy, region_labels)
  combinations[,3] = paste0(combinations[,2], "_to_", combinations[,1])
  colnames(subject_connections) = c("ID", combinations[,3])

  subject_index = 1
  #Loop over all patients/controls
  parcellation_label = parcellation_name[myaparc]
  for (subject_index in c(1:length(ID_list))){
  
    #Print progress message
    print(paste0("Pulling matrix for subject ", parcellation_label, "for", subject_index))
  
    #Save connectivity matrix as variable 'subject_connectivity_matrix'
    subject_connectivity_matrix = matrix(allparticipants.allparc_gfa[[myaparc]][[subject_index]][[1]], nrow = length(region_labels), ncol = length(region_labels), byrow=TRUE) 
  
    #Copy patient/control ID
    subject_connections[subject_index,1] = names(allparticipants.allparc_gfa[[myaparc]])[subject_index] 
  
    #Copy connectivity between regions
    subject_connections[subject_index, c(2:ncol(subject_connections))] = as.vector(t(subject_connectivity_matrix))

  }
  #save as a list of df containing ID and GFA connectivity
  parcellation_label = parcellation_name[myaparc]
  list_subject_connections[[parcellation_label]] = list(ID_gfa_connectivity = subject_connections)
  #join together metadata and GFA connectivity
  colnames(metadata)[1] = "ID"
  metadata_gfa = right_join(metadata, subject_connections, by="ID")
  parcellation_label = parcellation_name[myaparc]
  meta.data_allparcellations[[parcellation_label]] = list(metadata_gfa_conn = metadata_gfa)
}

save.image("~/DSI_DTI_FA_ConnMatrix/metadata_gfa_allparc.RData")

#reload for calculating residuals
load("~/DSI_DTI_FA_ConnMatrix/metadata_gfa_allparc.RData")

#remove old variables
rm(combinations, control_gfa_allparc_multiplied_updated, ID_list, metadata, metadata_gfa, patient_gfa_allparc_multiplied_updated, subject_connections, subject_connectivity_matrix, test, participants)

parcellation_number = 1:4

#### convert all 0 values to NA (as no connectivity detected) #### 
new_metadata_allparcellations = list()
for(myaparc in parcellation_number){
  #pull data for that parcellation
  data = meta.data_allparcellations[[myaparc]]$metadata_gfa_conn
  
  #separate out metadata
  metadata = data[,1:53]
  
  #sc data
  sc_data = data[,54:ncol(data)]
  
  #remove the 0's and replace with NA
  sc_data[sc_data == 0] <- NA
  
  #recombine
  new_data = cbind(metadata, sc_data)
  
  #add to list
  parcellation_label = parcellation_name[myaparc]
  new_metadata_allparcellations[[parcellation_label]] = list(gfa_conns_na = new_data)
}

#### remove columns where ALL of the values for that connection are NA (as determined from combined binary atlas) ####

parcellation_number = 1:4
final_gfa_allparc = list()

for(myaparc in parcellation_number){
  data = new_metadata_allparcellations[[myaparc]]$gfa_conns_na
  
  #remove columns where all rows contain NA 
  not_all_na <- function(x) any(!is.na(x))
  remaining_conn = data[,54:ncol(data)] %>% select(where(not_all_na))
  
  gfa_conn = cbind(data[,1:53], remaining_conn)
  
  #add to list the df containing metadata and removed columns 
  parcellation_label = parcellation_name[myaparc]
  final_gfa_allparc[[parcellation_label]] = list(na_removed_gfas = gfa_conn)
}

#### calculating age and sex adjusted residuals ####
library(MASS)
#empty list for storing all df of residuals
gfa_residuals_all = list()
#parcellation name and labels 
parcellation_name = c("myaparc.36", "myaparc.60", "myaparc.125", "myaparc.250")
#set up parcellation loop
parcellation_number = 1:4
#loop through for each parcellation
for(myaparc in parcellation_number){
  parcellation_label = parcellation_name[myaparc]
  #all data for that parcellation
  metadata_gfa = final_gfa_allparc[[myaparc]]$na_removed_gfas
  
  #control data for that parcellation
  metadata_gfa_controls = metadata_gfa %>% filter(SubjectType == "Control")
  
  #empty data frame for residuals
  gfa_residuals = metadata_gfa
  #0 the values of gfa
  gfa_residuals[,54:ncol(gfa_residuals)] = NA
  #create the region loop for going through each connection
  regions = names(gfa_residuals)[54:ncol(gfa_residuals)]
  #reset count for each loop
  count = 0
  tryCatch({ 
    for(region in regions){
      
      #add to count
      count = count + 1
      
      print(paste0("Calculating residuals for ", region, "in parcellation ", parcellation_label , ". Region number ", count, "/", length(names(metadata_gfa_controls)[54:ncol(metadata_gfa_controls)])))
    
      #fit linear model to control data only for Age (AgeDMRI) & sex (isFemale) and interactions. Also do square of AgeDMRI incase relationship not linear
        model_age_age2_sex = lm(as.formula(paste0(region, " ~ AgeDMRI*(AgeDMRI^2)*isFemale")), data = metadata_gfa_controls)
        #best subsets selection to determine best model for that connection 
        model_selection = ols_step_forward_aic(model_age_age2_sex)
        #which model best predicts?
        model_predictors = paste(model_selection$predictors, collapse = " + ")
        #use this to perform the final model
        model_best_final = rlm(as.formula(paste0(region, " ~ " , model_predictors)), data = metadata_gfa_controls, maxit = 50)
      
        #make prediction for all participants
        expected_gfa = predict(model_best_final, newdata = metadata_gfa)
      
        #retrieve actual values for all participants
        actual_gfa = metadata_gfa %>% dplyr::select(all_of(region)) %>% pull()
      
        #residuals
        residuals = actual_gfa - expected_gfa
        #brings it up as named number - convert to numeric to add to gfa_residuals df 
        residuals = as.numeric(residuals)
        #add to the empty residuals data frame
        gfa_residuals[, region] = residuals
      }
    }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  
  #add df containing all gfa residuals for that parcellation to a list
  gfa_residuals_all[[parcellation_label]] = list(residuals = gfa_residuals)
}

#save environment
save.image("~/DSI_DTI_FA_ConnMatrix/residuals_allparc.RData")

#tidy up environment
rm(allparticipants.allparc_gfa, gfa_residuals, metadata_gfa, metadata_gfa_myaparc36, metadata_gfa_myaparc60, metadata_gfa_myaparc125, metadata_gfa_myaparc250, model_age_age2_sex, model_best_final, model_selection, actual_gfa, check_if_zero, count, expected_gfa, model_predictors)

#### calculating z scores ####
library(matrixStats)
detach("package:MASS", unload = TRUE)
###loop for each parcellation here
myaparc = 1:4
#create empty list
scaled_gfa_allparc = list()
for(myaparc in parcellation_number){
  parcellation_label = parcellation_name[myaparc]
  #create empty data frame
  scaled_connectivity = gfa_residuals_all[[myaparc]]$residuals
  scaled_connectivity[,54:ncol(scaled_connectivity)] = NA

  #set up count
  count=1

  tryCatch({
    #Determine whether subject is patient or control and calculate residuals
    for(subject_index in 1:nrow(scaled_connectivity)){
      print(paste0("Scaling residuals for Subject ", scaled_connectivity[[subject_index, "ID"]], " in ", parcellation_label, ". Subject ", count, " of ", nrow(scaled_connectivity), "."))
      #for patient
      if(scaled_connectivity[[subject_index, "SubjectType"]] == "Patient"){
      
        #Extract control residuals
        control_residuals = gfa_residuals_all[[myaparc]]$residuals %>% filter(SubjectType == "Control") %>% dplyr::select(54:ncol(gfa_residuals_all[[myaparc]]$residuals))
      
        #Calculate z-score
        control_residuals_mean = colMeans(control_residuals, na.rm = TRUE)
        control_residuals_sd = colSds(as.matrix(control_residuals), na.rm = TRUE)
        current_participant_residuals = gfa_residuals_all[[myaparc]]$residuals[subject_index, 54:ncol(gfa_residuals_all[[myaparc]]$residuals)]
      
        #Add z-score to dataframe
        scaled_connectivity[subject_index,54:ncol(scaled_connectivity)] = (current_participant_residuals - control_residuals_mean) / control_residuals_sd
      
      
      } else if(scaled_connectivity[[subject_index, "SubjectType"]] == "Control"){
      
        #Extract control residuals
       control_residuals = gfa_residuals_all[[myaparc]]$residuals %>% filter(SubjectType == "Control", ID != gfa_residuals_all[[myaparc]]$residuals[[subject_index, "ID"]]) %>% dplyr::select(54:ncol(scaled_connectivity))
      
       #Extract control residuals
        control_residuals = gfa_residuals_all[[myaparc]]$residuals %>% filter(SubjectType == "Control") %>% dplyr::select(54:ncol(gfa_residuals_all[[myaparc]]$residuals))
      
       #Calculate z-score
        control_residuals_mean = colMeans(control_residuals, na.rm = TRUE)
        control_residuals_sd = colSds(as.matrix(control_residuals), na.rm = TRUE)
        current_participant_residuals = gfa_residuals_all[[myaparc]]$residuals[subject_index, 54:ncol(gfa_residuals_all[[myaparc]]$residuals)]
      
        #Add z-score to dataframe
        scaled_connectivity[subject_index,54:ncol(scaled_connectivity)] = (current_participant_residuals - control_residuals_mean) / control_residuals_sd
      
    }
    
      #Increment count
      count = count + 1
    }
  
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  #add to list
  scaled_gfa_allparc[[parcellation_label]] = list(Z_scored_gfa = scaled_connectivity)
}

save.image("~/DSI_DTI_FA_ConnMatrix/scaled_residuals_allparcellations")

