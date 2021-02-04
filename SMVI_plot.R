### ### ### ### ### ### ### ### ### 
#######FLASH DROUGHTS##############
### ### ### ### ### ### ### ### ### 
#LAST UPDATED 02/04/2020#

#For more information about the SMVI definition and citation:
#https://doi.org/10.5194/hess-2020-385

library(ncdf4)
library(latticeExtra)
library(maps)

NLDAS_grid<- nc_open('SMVI/NLDAS_masks-veg-soil2.nc')
lon <- ncvar_get(NLDAS_grid,var="lon")
lon[lon > 180] <- lon[lon > 180] - 360
lat <- ncvar_get(NLDAS_grid,var="lat")  
nc_close(NLDAS_grid)

YYYY=2017 #select year
nlon=length(lon)
nlat=length(lat)
dm.df<- read.csv(file = paste('SMVI/SMVI_',YYYY,'_Osman.csv',sep=''),colClasses = c("NULL",rep("Date",2),rep("numeric",2)),na.strings = "NA")SMVI <- array(dm.df$FD_Max, dim = c(nlon, nlat))

#Plotting FD
USMAP <- maps::map('state',plot=F)
USMAP <- data.frame(lon=USMAP$x, lat=USMAP$y)

tmat <- array(dm.df$FD_Max, dim = c(nlon, nlat))
levelplot(tmat,row.values = lon,column.values = rev(lat),col.regions = rev(heat.colors(20)),main=paste(YYYY," MAR-NOV - FD Length"),xlab='Longitude',ylab='Latitude',ylim=c(25,50),xlim=c(-125,-66))+xyplot(lat ~ lon, USMAP, type='l', lty=1, lwd=1, col='black')

doy <- strftime(dm.df$fstdate1, format = "%j")
tmat2 <- array(doy, dim = c(nlon, nlat))
levelplot(tmat2,row.values = lon,column.values = rev(lat),col.regions = rev(heat.colors(20)),main=paste(YYYY," MAR-NOV - FD Onset DOY"),xlab='Longitude',ylab='Latitude',ylim=c(25,50),xlim=c(-125,-66))+xyplot(lat ~ lon, USMAP, type='l', lty=1, lwd=1, col='black')
