
AL_data_24 <- readRDS("AL_data_24.obj")
PN_List <- readRDS("PN_List.obj")
MBON_list_all <- readRDS("MBON_list_all.obj")
DAN_name <- readRDS("DAN_name.obj")

AllMat <- readRDS("AllMat.obj")
PL3PN37 <- readRDS("PL3PN37.obj")
PL2PN37 <- readRDS("PL2PN37.obj")

createEmptyDf = function( nrow, ncol, colnames = c() ){
  if( missing( ncol ) && length( colnames ) > 0 ){
    ncol = length( colnames )
  }
  data.frame( matrix( vector(), nrow, ncol, dimnames = list( c(), colnames ) ) )
}

NeuronG1 <- intersect(AllMat$h1.bodyId,AllMat$h2.bodyId)
NeuronG2 <- setdiff(AllMat$h1.bodyId,AllMat$h2.bodyId)
NeuronG3 <- setdiff(AllMat$h2.bodyId,AllMat$h1.bodyId)
## omit NA in bodyID
NeuronG3=NeuronG3[2:969]


x=1:37
y=1:25

RandAall=matrix(0, nrow = 100, ncol = 37)
RandBall=matrix(0, nrow = 100, ncol = 25)

for (i in 1:100) {
  RandAall[i,]=order(sample(x,37,replace=FALSE));
  RandBall[i,]=order(sample(y,25,replace=FALSE));
}

ALDANMatrix3dDbyPN10 <- array(0, dim = c(15, 100, 10))

for (r in 1:10) {
  RandA=RandAall[r,]
  RandBpre=cbind(RandBall[r,],RandBall[r,]+25,RandBall[r,]+50,RandBall[r,]+75)
  RandB=matrix(RandBpre, nrow=100, ncol=1)   

##-----path1 --------------------------------------------------------------------------------

df_NeuronG1 = createEmptyDf( length(NeuronG1), colnames = t(PN4trial[,1])) 
cell_type= createEmptyDf( length(NeuronG1), colnames = 'h1_type')

for (i in 1:length(NeuronG1)) {
  one_h1=AllMat[AllMat$h1.bodyId==NeuronG1[i],]
  cell_type[i,]=unique(one_h1$h1.type)
  
  df_i = createEmptyDf( 37, colnames = t(PN4trial[,1]) )


for (j in 1:37){
  one_PNtoh1=one_h1[grep(as.character(PN_List[j,1]),one_h1$i.type),]
  PNtoh1=one_PNtoh1[!duplicated(subset(one_PNtoh1,select=c("i.bodyId"))),]
  PNrand=PN4trial[,2:38][,RandA][j]
  h1response=sum(PNtoh1$w1.weight/PNtoh1$h1total)*PNrand
  df_i[j,]=t(h1response)
}
df_NeuronG1[i,]=colSums(df_i)
}

df_NeuronG1_ID=cbind(h1ID=NeuronG1,cell_type=cell_type,df_NeuronG1)

##-----path2 --------------------------------------------------------------------------------

df_NeuronG2 = createEmptyDf( length(NeuronG2), colnames = t(PN4trial[,1])) 
cell_type= createEmptyDf( length(NeuronG2), colnames = 'h1_type')

for (i in 1:length(NeuronG2)) {
  one_h1=AllMat[AllMat$h1.bodyId==NeuronG2[i],]
  cell_type[i,]=unique(one_h1$h1.type)
  
  df_i = createEmptyDf( 37, colnames = t(PN4trial[,1]) )
  
  for (j in 1:37){
    one_PNtoh1=one_h1[grep(as.character(PN_List[j,1]),one_h1$i.type),]
    PNtoh1=one_PNtoh1[!duplicated(subset(one_PNtoh1,select=c("i.bodyId"))),]
    PNrand=PN4trial[,2:38][,RandA][j]
    h1response=sum(PNtoh1$w1.weight/PNtoh1$h1total)*PNrand
    df_i[j,]=t(h1response)
  }
  df_NeuronG2[i,]=colSums(df_i)
}

df_NeuronG2_ID=cbind(h1ID=NeuronG2,cell_type=cell_type,df_NeuronG2)

##----- path 3 G2 to G1 --------------------------------------------------------------------------------

NeuronG2_h1Firing=df_NeuronG2_ID

## whether fire or not
NeuronG2_h1Firing[,3:102][df_NeuronG2_ID[,3:102]<0]=0
NeuronG2_h1Firing[,3:102][df_NeuronG2_ID[,3:102]>100]=100

NeuronG2_Res_ID_Release=NeuronG2_h1Firing

## assign +-
NeuronG2_Res_ID_Release[3:102]=EI_G2*NeuronG2_h1Firing[3:102]

# integrate path3 to G1 neurons

NeuronG1_Res_path3= createEmptyDf( length(NeuronG1), colnames = t(PN4trial[,1])  ) 
cell_type= createEmptyDf( length(NeuronG1), colnames = 'G1N_type')

for (i in 1:length(NeuronG1)) {
  
  PreNeurons=PL3PN37[PL3PN37$h2.bodyId==NeuronG1[i],]
  G1N_type=unique(PreNeurons$h2.type)
  cell_type[i,]=G1N_type
  Uni_h1=unique(PreNeurons$h1.bodyId)
  Pre_path3=intersect(Uni_h1,NeuronG2)
  
  if (length(Pre_path3) == 0) {
    Path3= createEmptyDf( 1, colnames = t(PN4trial[,1])  ) 
    Path3[is.na(Path3)] <- 0
  }
  else {
    
    Path3= createEmptyDf( length(Pre_path3), colnames = t(PN4trial[,1])  ) 
  
  for (j in 1:length(Pre_path3)){
    
    SinglePre=PreNeurons[PreNeurons$h1.bodyId==Pre_path3[j],]
    
    h2response=NeuronG2_Res_ID_Release[,3:102][NeuronG2_Res_ID_Release$h1ID==Pre_path3[j],]*(SinglePre[1,]$w2.weight/SinglePre[1,]$h2total)
    Path3[j,]=h2response
  }
  }
  
  NeuronG1_Res_path3[i,]=colSums(Path3, na.rm = TRUE) + df_NeuronG1_ID[3:102][df_NeuronG1_ID$h1ID==NeuronG1[i],]
  }

NeuronG1_Res_path3_ID=cbind(NG1ID=NeuronG1,NG1_type=cell_type,NeuronG1_Res_path3)

##----- path 4 G1 to G1 --------------------------------------------------------------------------------

NeuronG1_h1Firing=NeuronG1_Res_path3_ID

## whether fire or not
NeuronG1_h1Firing[,3:102][NeuronG1_Res_path3_ID[,3:102]<0]=0
NeuronG1_h1Firing[,3:102][NeuronG1_Res_path3_ID[,3:102]>100]=100

NeuronG1_path3_Release=NeuronG1_h1Firing

## assign +-
NeuronG1_path3_Release[3:102]=EI_G1*NeuronG1_h1Firing[3:102]

# integrate path3 to G1 neurons

NeuronG1_Res_path4= createEmptyDf( length(NeuronG1), colnames = t(PN4trial[,1])  ) 
cell_type= createEmptyDf( length(NeuronG1), colnames = 'G1N_type')

for (i in 1:length(NeuronG1)) {
  
  PreNeurons=PL3PN37[PL3PN37$h2.bodyId==NeuronG1[i],]
  G1N_type=unique(PreNeurons$h2.type)
  cell_type[i,]=G1N_type
  Uni_h1=unique(PreNeurons$h1.bodyId)
  Pre_path4=intersect(Uni_h1,NeuronG1)
  
  if (length(Pre_path4) == 0) {
    Path4= createEmptyDf( 1, colnames = t(PN4trial[,1])  ) 
    Path4[is.na(Path4)] <- 0
  }
  else {
    
    Path4= createEmptyDf( length(Pre_path4), colnames = t(PN4trial[,1])  ) 
    
    for (j in 1:length(Pre_path4)){
      
      SinglePre=PreNeurons[PreNeurons$h1.bodyId==Pre_path4[j],]
      
      h2response=NeuronG1_path3_Release[,3:102][NeuronG1_path3_Release$NG1ID==Pre_path4[j],]*(SinglePre[1,]$w2.weight/SinglePre[1,]$h2total)
      Path4[j,]=h2response
    }
  }
  
  NeuronG1_Res_path4[i,]=colSums(Path4, na.rm = TRUE) + NeuronG1_Res_path3_ID[3:102][NeuronG1_Res_path3_ID$NG1ID==NeuronG1[i],]
}

NeuronG1_Res_path4_ID=cbind(NG1ID=NeuronG1,NG1_type=cell_type,NeuronG1_Res_path4)

##----- path 5 G2 to G3 --------------------------------------------------------------------------------

NeuronG2_h1Firing=df_NeuronG2_ID

## whether fire or not
NeuronG2_h1Firing[,3:102][df_NeuronG2_ID[,3:102]<0]=0
NeuronG2_h1Firing[,3:102][df_NeuronG2_ID[,3:102]>100]=100

NeuronG2_Res_ID_Release=NeuronG2_h1Firing

## assign +-
NeuronG2_Res_ID_Release[3:102]=EI_G2*NeuronG2_h1Firing[3:102]

# integrate path5 to G3 neurons

NeuronG3_Res_path5= createEmptyDf( length(NeuronG3), colnames = t(PN4trial[,1])  ) 
cell_type= createEmptyDf( length(NeuronG3), colnames = 'G3N_type')

for (i in 1:length(NeuronG3)) {
  
  PreNeurons=PL3PN37[PL3PN37$h2.bodyId==NeuronG3[i],]
  G3N_type=unique(PreNeurons$h2.type)
  cell_type[i,]=G3N_type
  Uni_h1=unique(PreNeurons$h1.bodyId)
  Pre_path5=intersect(Uni_h1,NeuronG2)
  
  if (length(Pre_path5) == 0) {
    Path5= createEmptyDf( 1, colnames = t(PN4trial[,1])  ) 
    Path5[is.na(Path5)] <- 0
  }
  else {
    
    Path5= createEmptyDf( length(Pre_path5), colnames = t(PN4trial[,1])  ) 
    
    for (j in 1:length(Pre_path5)){
      
      SinglePre=PreNeurons[PreNeurons$h1.bodyId==Pre_path5[j],]
      
      h2response=NeuronG2_Res_ID_Release[,3:102][NeuronG2_Res_ID_Release$h1ID==Pre_path5[j],]*(SinglePre[1,]$w2.weight/SinglePre[1,]$h2total)
      Path5[j,]=h2response
    }
  }
  
  NeuronG3_Res_path5[i,]=colSums(Path5, na.rm = TRUE) 
}

NeuronG3_Res_path5_ID=cbind(NG3ID=NeuronG3,NG3_type=cell_type,NeuronG3_Res_path5)

##----- path 6 G1 to G3 --------------------------------------------------------------------------------

NeuronG1_h1Firing=NeuronG1_Res_path4_ID

## whether fire or not
NeuronG1_h1Firing[,3:102][NeuronG1_Res_path4_ID[,3:102]<0]=0
NeuronG1_h1Firing[,3:102][NeuronG1_Res_path4_ID[,3:102]>100]=100

NeuronG1_path4_Release=NeuronG1_h1Firing

## assign +-
NeuronG1_path4_Release[3:102]=EI_G1*NeuronG1_h1Firing[3:102]

# integrate path6 to G3 neurons

NeuronG3_Res_path6= createEmptyDf( length(NeuronG3), colnames = t(PN4trial[,1])  ) 
cell_type= createEmptyDf( length(NeuronG3), colnames = 'G1N_type')

for (i in 1:length(NeuronG3)) {
  
  PreNeurons=PL3PN37[PL3PN37$h2.bodyId==NeuronG3[i],]
  G3N_type=unique(PreNeurons$h2.type)
  cell_type[i,]=G3N_type
  Uni_h1=unique(PreNeurons$h1.bodyId)
  Pre_path6=intersect(Uni_h1,NeuronG1)
  
  if (length(Pre_path6) == 0) {
    Path6= createEmptyDf( 1, colnames = t(PN4trial[,1])  ) 
    Path6[is.na(Path6)] <- 0
  }
  else {
    
    Path6= createEmptyDf( length(Pre_path6), colnames = t(PN4trial[,1])  ) 
    
    for (j in 1:length(Pre_path6)){
      
      SinglePre=PreNeurons[PreNeurons$h1.bodyId==Pre_path6[j],]
      
      h2response=NeuronG1_path4_Release[,3:102][NeuronG1_path4_Release$NG1ID==Pre_path6[j],]*(SinglePre[1,]$w2.weight/SinglePre[1,]$h2total)
      Path6[j,]=h2response
    }
  }
  
  NeuronG3_Res_path6[i,]=colSums(Path6, na.rm = TRUE) + NeuronG3_Res_path5_ID[3:102][NeuronG3_Res_path5_ID$NG3ID==NeuronG3[i],]
}

NeuronG3_Res_path6_ID=cbind(NG3ID=NeuronG3,NG3_type=cell_type,NeuronG3_Res_path6)


##----- path 7 G1 to DAN --------------------------------------------------------------------------------

NeuronG1_h1Firing=NeuronG1_Res_path4_ID

## whether fire or not
NeuronG1_h1Firing[,3:102][NeuronG1_Res_path4_ID[,3:102]<0]=0
NeuronG1_h1Firing[,3:102][NeuronG1_Res_path4_ID[,3:102]>100]=100

NeuronG1_path4_Release=NeuronG1_h1Firing

## assign +-
NeuronG1_path4_Release[3:102]=EI_G1*NeuronG1_h1Firing[3:102]

# integrate path7 to DAN

DAN_ID=unique(PL2PN37$o.bodyId)

DAN_Res_path7= createEmptyDf( length(DAN_ID), colnames = t(PN4trial[,1])  ) 
cell_type= createEmptyDf( length(DAN_ID), colnames = 'DAN_type')

for (i in 1:length(DAN_ID)) {
  
  PreNeurons=PL2PN37[PL2PN37$o.bodyId==DAN_ID[i],]
  o_type=unique(PreNeurons$o.type)
  cell_type[i,]=o_type
  Uni_h1=unique(PreNeurons$h1.bodyId)
  Pre_path7=intersect(Uni_h1,NeuronG1)
  
  if (length(Pre_path7) == 0) {
    Path7= createEmptyDf( 1, colnames = t(PN4trial[,1])  ) 
    Path7[is.na(Path7)] <- 0
  }
  else {
    
    Path7= createEmptyDf( length(Pre_path7), colnames = t(PN4trial[,1])  ) 
    
    for (j in 1:length(Pre_path7)){
      
      SinglePre=PreNeurons[PreNeurons$h1.bodyId==Pre_path7[j],]
      
      h2response=NeuronG1_path4_Release[,3:102][NeuronG1_path4_Release$NG1ID==Pre_path7[j],]*(SinglePre[1,]$w2.weight/SinglePre[1,]$h2total)
      Path7[j,]=h2response
    }
  }
  
  DAN_Res_path7[i,]=colSums(Path7, na.rm = TRUE) 
}

DAN_Res_path7_ID=cbind(DANID=DAN_ID,o_type=cell_type, DAN_Res_path7)

##----- path 8 G3 to DAN --------------------------------------------------------------------------------

##assign sign
NeuronG3_h1Firing=NeuronG3_Res_path6_ID

## whether fire or not
NeuronG3_h1Firing[,3:102][NeuronG3_Res_path6_ID[,3:102]<0]=0
NeuronG3_h1Firing[,3:102][NeuronG3_Res_path6_ID[,3:102]>100]=100

NeuronG3_path6_Release=NeuronG3_h1Firing

## assign +-
NeuronG3_path6_Release[3:102]=EI_G3*NeuronG3_h1Firing[3:102]

# integrate path6 to G3 neurons

DAN_ID=unique(PL3PN37$o.bodyId)

DAN_Res_path8= createEmptyDf( length(DAN_ID), colnames = t(PN4trial[,1])  ) 
cell_type= createEmptyDf( length(DAN_ID), colnames = 'DAN_type')

for (i in 1:length(DAN_ID)) {
  
  PreNeurons=PL3PN37[PL3PN37$o.bodyId==DAN_ID[i],]
  o_type=unique(PreNeurons$o.type)
  cell_type[i,]=o_type[1]
  Uni_h2=unique(PreNeurons$h2.bodyId)
  Pre_path8=intersect(Uni_h2,NeuronG3)
  
  if (length(Pre_path8) == 0) {
    Path8= createEmptyDf( 1, colnames = t(PN4trial[,1])  ) 
    Path8[is.na(Path8)] <- 0
  }
  else {
    
    Path8= createEmptyDf( length(Pre_path8), colnames = t(PN4trial[,1])  ) 
    
    for (j in 1:length(Pre_path8)){
      
      SinglePre=PreNeurons[PreNeurons$h2.bodyId==Pre_path8[j],]
      
      h2response=NeuronG3_path6_Release[,3:102][NeuronG3_path6_Release$NG3ID==Pre_path8[j],]*(SinglePre[1,]$w3.weight/SinglePre[1,]$Ototal)
      Path8[j,]=h2response
    }
  }
  
  DAN_Res_path8[i,]=colSums(Path8, na.rm = TRUE) 
}

DAN_Res_path8_ID=cbind(DANID=DAN_ID,o_type=cell_type, DAN_Res_path8)

##----- marge path7 and 8 --------------------------------------------------------------------------------

DAN_All=DAN_Res_path8_ID$DANID

DAN_Res_total= createEmptyDf( length(DAN_All), colnames = t(PN4trial[,1])  ) 

for (i in 1:length(DAN_All)) {
  
  Path7Res=DAN_Res_path7_ID[3:102][DAN_Res_path7_ID$DANID==DAN_All[i],]
  
  if (length(Path7Res$X2.pentanone) == 0) {
    Path7Res= createEmptyDf( 1, colnames = t(PN4trial[,1])  ) 
    Path7Res[is.na(Path7Res)] <- 0
  }
  else {
  
  Path7Res=DAN_Res_path7_ID[3:102][DAN_Res_path7_ID$DANID==DAN_All[i],]
  }
  DAN_Res_total[i,]=DAN_Res_path8_ID[3:102][DAN_Res_path8_ID$DANID==DAN_All[i],]+Path7Res
}

DAN_Res_total_ID=cbind(ID=DAN_Res_path8_ID$DANID,type=DAN_Res_path8_ID$DAN_type,DAN_Res_total)


##-----neuron to compartment --------------------------------------------------------------------------------

DAN_Firing=DAN_Res_total_ID

## whether fire or not
DAN_Firing[,3:102][DAN_Res_total_ID[,3:102]<0]=0
DAN_Firing[,3:102][DAN_Res_total_ID[,3:102]>100]=100

DAN_Firing_ID=cbind(ID=DAN_Res_path8_ID$DANID,type=DAN_Res_path8_ID$DAN_type,DAN_Firing[,3:102])

df_DAN = createEmptyDf( length(t(DAN_name)), colnames = t(PN4trial[,1])) 

for (i in 1:length(t(DAN_name))){

one_compartment=DAN_Firing_ID[,3:102][grep(as.character(DAN_name[i,1]),DAN_Firing_ID$type),]

df_DAN[i,]=colSums(one_compartment, na.rm = TRUE) 

}


DANtotal=data.matrix(df_DAN)

ALDANMatrix=matrix(0, nrow=15, ncol=100)

#alpha
ALDANMatrix[1,]=DANtotal[21,]
ALDANMatrix[2,]=DANtotal[19,]
ALDANMatrix[3,]=DANtotal[20,]
ALDANMatrix[4,]=DANtotal[20,]
ALDANMatrix[5,]=DANtotal[11,]
ALDANMatrix[6,]=DANtotal[18,]
#gamma
ALDANMatrix[7,]=DANtotal[16,]+DANtotal[17,]
ALDANMatrix[8,]=DANtotal[18,]
ALDANMatrix[9,]=DANtotal[12,]
ALDANMatrix[10,]=DANtotal[8,]
ALDANMatrix[11,]=DANtotal[1,]+DANtotal[15,]
#beta
ALDANMatrix[12,]=DANtotal[9,]+DANtotal[10,]
ALDANMatrix[13,]=DANtotal[13,]+DANtotal[14,]
ALDANMatrix[14,]=DANtotal[3,]+DANtotal[4,]
ALDANMatrix[15,]=DANtotal[2,]+DANtotal[3,]+DANtotal[4,]+DANtotal[5,]+DANtotal[6,]+DANtotal[15,]
ALDANMatrix3dDbyPN10[,,r]=ALDANMatrix

}

write.csv(ALDANMatrix3dDbyPN10, "NN_NT_4trials_RandA.csv")

NN_NT_4trials_RandA=ALDANMatrix3dDbyPN10

