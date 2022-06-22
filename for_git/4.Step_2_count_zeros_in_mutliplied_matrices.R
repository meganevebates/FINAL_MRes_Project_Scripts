#### setting up wd and librarys ####
setwd("~/DSI_DTI_FA_ConnMatrix")
load("~/DSI_DTI_FA_ConnMatrix/multiplied_matrices_allparticipants.RData")
#View(control_gfa_allparc_multiplied)
#### for myaparc 36 ####
#create an empty matrix to store the value of how many times that x,r is == 0 
countzeros_myaparc36 = matrix(data=NA, nrow=82, ncol=82)
colnames(countzeros_myaparc36) = colnames(myaparc_36_connections_atlas)
rownames(countzeros_myaparc36) = rownames(myaparc_36_connections_atlas)
#create empty list to store the countzeros_"" matrices in
countzeros_allparc = list()
#so have a blank matrix to populate now need the values to populate it
#retrieve just the myaparc36 data
input = control_gfa_allparc_multiplied$myaparc.36
#create a variable called value which will be the count of how many times that [r,c] is 0 in the control matrices 
#set at 0 as default 
value=0
#so row number and column number variables as vector so it runs through each 1 to 82 (for myaparc36 the matrices are 82:82 - change for each parcellation)
col = 1:82
row = 1:82
for(c in col){
  #set count to navigate through list of participants
  count = 1
  #reset value to default 
  value = 0
  for(r in row){
    #set count to navigate through list of participants
    count = 1
    #reset value to default 
    value = 0
    for(participant in input){
      #locate the participants connectivity matrix on the list
      specific_conn = input[[count]][1]$gfa_connectivity
      #if for position r,c the value is 0, add to the value, so that the countzeros_myaparc36 matrix will hold the number of times that element was zero
      if(specific_conn[r,c] == 0){
        value = value + 1
      }
      #add to count to move to next participant
      count = count + 1
      #once done all participants - enter the value (how many times [r,c]=0 into the countzeros_myaparc36 matrix)
      if(count == 70){
        countzeros_myaparc36[r,c] = value
        #reset value to 0 for next r,c in matrices
        value = 0
        break
      }
    }
  }
}
#add to list
parcellation = "myaparc.36"
countzeros_allparc[[parcellation]] = list(countzeros = countzeros_myaparc36)
#### for myaparc 60 ####
#create an empty matrix to store the value of how many times that x,r is == 0 
countzeros_myaparc60 = matrix(data=NA, nrow=128, ncol=128)
colnames(countzeros_myaparc60) = colnames(myaparc_60_connections_atlas)
rownames(countzeros_myaparc60) = rownames(myaparc_60_connections_atlas)
#so have a blank matrix to populate now need the values to populate it
#retrieve just the myaparc60 data
input = control_gfa_allparc_multiplied$myaparc.60
#create a variable called value which will be the count of how many times that [r,c] is 0 in the control matrices 
#set at 0 as default 
value=0
#so row number and column number variables as vector so it runs through each 1 to 128 (for myaparc60 the matrices are 128:128)
col = 1:128
row = 1:128
for(c in col){
  #set count to navigate through list of participants
  count = 1
  #reset value to default 
  value = 0
  for(r in row){
    #set count to navigate through list of participants
    count = 1
    #reset value to default 
    value = 0
    for(participant in input){
      #locate the participants connectivity matrix on the list
      specific_conn = input[[count]][1]$gfa_connectivity
      #if for position r,c the value is 0, add to the value, so that the countzeros_myaparc60 matrix will hold the number of times that element was zero
      if(specific_conn[r,c] == 0){
        value = value + 1
      }
      #add to count to move to next participant
      count = count + 1
      #once done all participants - enter the value (how many times [r,c]=0 into the countzeros_myaparc60 matrix)
      if(count == 70){
        countzeros_myaparc60[r,c] = value
        #reset value to 0 for next r,c in matrices
        value = 0
        break
      }
    }
  }
}
#add to list
parcellation = "myaparc.60"
countzeros_allparc[[parcellation]] = list(countzeros = countzeros_myaparc60)
#### for myaparc125 ####
#create an empty matrix to store the value of how many times that x,r is == 0 
countzeros_myaparc125 = matrix(data=NA, nrow=233, ncol=233)
colnames(countzeros_myaparc125) = colnames(myaparc_125_connections_atlas)
rownames(countzeros_myaparc125) = rownames(myaparc_125_connections_atlas)
#so have a blank matrix to populate now need the values to populate it
#retrieve just the myaparc125 data
input = control_gfa_allparc_multiplied$myaparc.125
#create a variable called value which will be the count of how many times that [r,c] is 0 in the control matrices 
#set at 0 as default 
value=0
#so row number and column number variables as vector so it runs through each 1 to 233 (for myaparc125 the matrices are 233:233)
col = 1:233
row = 1:233
for(c in col){
  #set count to navigate through list of participants
  count = 1
  #reset value to default 
  value = 0
  for(r in row){
    #set count to navigate through list of participants
    count = 1
    #reset value to default 
    value = 0
    for(participant in input){
      #locate the participants connectivity matrix on the list
      specific_conn = input[[count]][1]$gfa_connectivity
      #if for position r,c the value is 0, add to the value, so that the countzeros_myaparc125 matrix will hold the number of times that element was zero
      if(specific_conn[r,c] == 0){
        value = value + 1
      }
      #add to count to move to next participant
      count = count + 1
      #once done all participants - enter the value (how many times [r,c]=0 into the countzeros_myaparc125 matrix)
      if(count == 70){
        countzeros_myaparc125[r,c] = value
        #reset value to 0 for next r,c in matrices
        value = 0
        break
      }
    }
  }
}
#add to list
parcellation = "myaparc.125"
countzeros_allparc[[parcellation]] = list(countzeros = countzeros_myaparc125)
#### for myaparc250 ####

#create an empty matrix to store the value of how many times that x,r is == 0 
countzeros_myaparc250 = matrix(data=NA, nrow=462, ncol=462)
colnames(countzeros_myaparc250) = colnames(myaparc_250_connections_atlas)
rownames(countzeros_myaparc250) = rownames(myaparc_250_connections_atlas)
#so have a blank matrix to populate now need the values to populate it
#retrieve just the myaparc250 data
input = control_gfa_allparc_multiplied$myaparc.250
#create a variable called value which will be the count of how many times that [r,c] is 0 in the control matrices 
#set at 0 as default 
value=0
#so row number and column number variables as vector so it runs through each 1 to 462 (for myaparc250 the matrices are 462:462)
col = 1:462
row = 1:462
for(c in col){
  #set count to navigate through list of participants
  count = 1
  #reset value to default 
  value = 0
  for(r in row){
    #set count to navigate through list of participants
    count = 1
    #reset value to default 
    value = 0
    for(participant in input){
      #locate the participants connectivity matrix on the list
      specific_conn = input[[count]][1]$gfa_connectivity
      #if for position r,c the value is 0, add to the value, so that the countzeros_myaparc250 matrix will hold the number of times that element was zero
      if(specific_conn[r,c] == 0){
        value = value + 1
      }
      #add to count to move to next participant
      count = count + 1
      #once done all participants - enter the value (how many times [r,c]=0 into the countzeros_myaparc250 matrix)
      if(count == 70){
        countzeros_myaparc250[r,c] = value
        #reset value to 0 for next r,c in matrices
        value = 0
        break
      }
    }
  }
}
#add to list
parcellation = "myaparc.250"
countzeros_allparc[[parcellation]] = list(countzeros = countzeros_myaparc250)