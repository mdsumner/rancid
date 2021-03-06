## example from http://wiki.scinethpc.ca/wiki/images/3/3c/NetCDF.pdf

## note that this is a weird data.frame beast, with list elements
## ultimately the compound.insert.nc should really take a list

Data <- data.frame ( name =I( list ()) , ADCcount =I( list ()) , grid_i =I( list ()) , grid_j =I( list ()) , pressure =I ( list ())
                       , energy =I( list ()) , idnumber = I( list ()) , pressure2 =I( list ()) )
n <- 10

for (i in 1:n ){
  Data [[i , 'name']]= paste (" Particle : " , (i -1) , sep = "")
  Data [[i , 'ADCcount']]= i *256
  Data [[i ,'grid_i']]= i +0
  Data [[i ,'grid_j']]=10 - i
  Data [[i ,'pressure']]= i*i *1.
  Data [[i ,'energy']]=( i *i )^4
  Data [[i ,'idnumber']]= i *(2)^34
  Data [[i ,'pressure2']]= c (0.5+ i ,1.5+ i ,2.5+ i ,i -1.5 , i -2.5 , i -3.5)
}





# # this is the more R-ish way to generate the source data, this really matches what is read from the created file
# n <- 10
# 
# sn <- seq(n)
# Data <- lapply(list(name = paste0("Particle", sn - 1), 
#                    ADCcount = sn * 256, 
#                    grid_i = sn, 
#                    grid_j = 10 - sn, 
#                    pressure = sn * sn, 
#                    energey = (sn * sn)^4, 
#                    idnumber = sn * 2^34, 
#                    pressure2 = c (0.5 + sn, 1.5 + sn, 2.5 + sn, sn - 1.5, sn - 2.5, sn -3.5)), as.list)

                  ## stringsAsFactors = FALSE)

print(ls())

nc <- create.nc ("particles.nc", "NC_NETCDF4")
mycompound <- compound.def.nc (nc, 70, "Particle")
compound.inq.nc (nc, mycompound)
mycompound <- compound.insert.nc(nc, mycompound, "name", "NC_CHAR", 16)
mycompound <- compound.insert.nc(nc, mycompound, "ADCcount", "NC_USHORT")
mycompound <- compound.insert.nc(nc, mycompound, "grid_i", "NC_INT")
mycompound <- compound.insert.nc(nc, mycompound, "grid_j", "NC_INT")
mycompound <- compound.insert.nc(nc, mycompound, "pressure", "NC_FLOAT")
mycompound <- compound.insert.nc(nc, mycompound, "energy", "NC_DOUBLE")
mycompound <- compound.insert.nc(nc, mycompound, "idnumber", "NC_INT64")
mycompound <- compound.insert.nc(nc, mycompound, "pressure2", "NC_FLOAT", 2, 3)
dim.def.nc(nc, "NRecords", 10)
myvar <- var.def.nc(nc, mycompound, "Data", 1)
compound.fill.nc(nc, mycompound, myvar, Data)
close.nc(nc)

print(ls())

## notice that Data is a data.frame composed of lists, but this is a normal 
## data.frame
df <- get.compound.nc ("particles.nc" ,"NRecords" ,"Data")
## Weirdly, "Data" gets deleted?? 
print(ls())




Data <- data.frame ( name =I( list ()) , ADCcount =I( list ()) , grid_i =I( list ()) , grid_j =I( list ()) , pressure =I ( list ())
                       , energy =I( list ()) , idnumber = I( list ()) , pressure2 =I( list ()) )
n <- 10

for (i in 1:n ){
  Data [[i , 'name']]= paste (" Particle : " , (i -1) , sep = "")
  Data [[i , 'ADCcount']]= i *256
  Data [[i ,'grid_i']]= i +0
  Data [[i ,'grid_j']]=10 - i
  Data [[i ,'pressure']]= i*i *1.
  Data [[i ,'energy']]=( i *i )^4
  Data [[i ,'idnumber']]= i *(2)^34
  Data [[i ,'pressure2']]= c (0.5+ i ,1.5+ i ,2.5+ i ,i -1.5 , i -2.5 , i -3.5)
}





# 
# n <- 10
# 
# sn <- seq(n)
# Data <- lapply(list(name = paste0("Particle", sn - 1), 
#                    ADCcount = sn * 256, 
#                    grid_i = sn, 
#                    grid_j = 10 - sn, 
#                    pressure = sn * sn, 
#                    energey = (sn * sn)^4, 
#                    idnumber = sn * 2^34, 
#                    pressure2 = c (0.5 + sn, 1.5 + sn, 2.5 + sn, sn - 1.5, sn - 2.5, sn -3.5)), as.list)

                  ## stringsAsFactors = FALSE)



nc <- create.nc ("particles.nc", "NC_NETCDF4")
mycompound <- compound.def.nc (nc, 70, "Particle")
compound.inq.nc (nc, mycompound)
mycompound <- compound.insert.nc(nc, mycompound, "name", "NC_CHAR", 16)
mycompound <- compound.insert.nc(nc, mycompound, "ADCcount", "NC_USHORT")
mycompound <- compound.insert.nc(nc, mycompound, "grid_i", "NC_INT")
mycompound <- compound.insert.nc(nc, mycompound, "grid_j", "NC_INT")
mycompound <- compound.insert.nc(nc, mycompound, "pressure", "NC_FLOAT")
mycompound <- compound.insert.nc(nc, mycompound, "energy", "NC_DOUBLE")
mycompound <- compound.insert.nc(nc, mycompound, "idnumber", "NC_INT64")
mycompound <- compound.insert.nc(nc, mycompound, "pressure2", "NC_FLOAT", 2, 3)
dim.def.nc(nc, "NRecords", 10)
myvar <- var.def.nc(nc, mycompound, "Data", 1)
compound.fill.nc(nc, mycompound, myvar, Data)
close.nc(nc)

## notice that Data is a data.frame composed of lists, but this is a normal 
## data.frame
df <- get.compound.nc ("particles.nc" ,"NRecords" ,"Data")


sf <- "http://oceandata.sci.gsfc.nasa.gov/cgi/getfile/O1997001.L3b_DAY_CHL.nc"
download.file(sf, basename(sf), mode = "wb")
f <- basename(sf)



> system("ncdump -h ../inst/examples/particles.nc")
netcdf particles {
  types:
    compound Particle {
      char name(16) ;
      ushort ADCcount ;
      int grid_i ;
      int grid_j ;
      float pressure ;
      double energy ;
      int64 idnumber ;
      float pressure2(2, 3) ;
    }; // Particle
  dimensions:
    NRecords = 10 ;
  variables:
    Particle Data(NRecords) ;
}
system("ncdump -h O1997001.L3b_DAY_CHL.nc")
...
  group: level-3_binned_data {
    types:
      compound binListType {
        uint bin_num ;
        short nobs ;
        short nscenes ;
        float weights ;
        float time_rec ;
      }; // binListType
    compound binDataType {
      float sum ;
      float sum_squared ;
    }; // binDataType
    compound binIndexType {
      uint start_num ;
      uint begin ;
      uint extent ;
      uint max ;
    }; // binIndexType
    dimensions:
      binListDim = UNLIMITED ; // (241431 currently)
    binDataDim = UNLIMITED ; // (241431 currently)
    binIndexDim = UNLIMITED ; // (2160 currently)
    variables:
    binListType BinList(binListDim) ;
    binDataType chlor_a(binDataDim) ;
    binDataType chl_ocx(binDataDim) ;
    binIndexType BinIndex(binIndexDim) ;
  } // group level-3_binned_data
  
...


library(RNetCDF, lib.loc = "lib")

f <- "S20030602003090.L3b_MO_ST92_CHL.nc"

d <- get.compound.nc(f, "binListDim", "BinList")


