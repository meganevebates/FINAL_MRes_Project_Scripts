#set wd
setwd("~/DSI_DTI_FA_ConnMatrix")
#load data and remove variables we dont need
load("~/DSI_DTI_FA_ConnMatrix/countzeros_allparc_environment.RData")
rm(countzeros_myaparc36, countzeros_myaparc60, countzeros_myaparc125, countzeros_myaparc250, myaparc_36_connections_atlas, myaparc_60_connections_atlas, myaparc_125_connections_atlas, myaparc_250_connections_atlas, control_gfa_allparc, control_gfa_allparc_multiplied, gfa_connmatrix, gfa_pt_connmatrices, input, participant, patient_gfa_allparc, patient_gfa_allparc_multiplied, specific_conn, c, count, parcellation, r, row, col, value)
#leaves the two lists we want, the binary atlas data for all 4 parcellations, and the count of zeros from the controls for all parcellations
#the combined atlas variable will be the new matrix using the original binarised atlas combined with the information from the controls 
#so it runs for each parcellation need it to run 4 times
parcellations = 1:4
#populate the combined atlas variable w the connections from atlas original binary data
combined_atlas = connections_from_atlas
#set count
count = 1
for(p in parcellations){
  #countzerosdata = the data of how many participants have a zero value for [r,c] for that parcellation
  countzerosdata = countzeros_allparc[[count]][1]
  #set now so it changes for each parcellation as each parcellation has matrices of different sizes
  col = 1:NCOL(countzeros_allparc[[count]][1]$countzeros)
  row = 1:NROW(countzeros_allparc[[count]][1]$countzeros)
  for(c in col){
    for(r in row){
      #if the [r,c] in the count zeros data represents 52 or more participants (75% of controls) having a 0 value for that
      #connection, change that value on the combined atlas (which contains the original atlas data) to 0 also
      if(countzerosdata$countzeros[r,c] >= 52){
      combined_atlas[[count]][r,c] = 0
      }
    }
  }
  if(count == 4){
    break
  }
  count = count + 1
}


