% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Func_Canopy_Radiation_Transfer.R
\name{Func_Canopy_Radiation_Transfer}
\alias{Func_Canopy_Radiation_Transfer}
\title{Func_Canopy_Radiation_Transfer}
\usage{
Func_Canopy_Radiation_Transfer(FLAG, SZA, LAI, Ib0, Id0, Vcmax0_25, CI)
}
\arguments{
\item{FLAG}{Model version controller;  0--Lloyd et al. 2010 Model for Vcmax-LAI relationship; 
1--Mercado et al. 2006 Model for Vcmax-LAI relationship in the tropics}

\item{SZA}{solar zenith angle, in degrees}

\item{LAI}{Canopy leaf area index}

\item{Ib0}{direct beam at canopy top}

\item{Id0}{diffuse irradiance at canopy top}

\item{Vcmax0_25}{Vcmax at reference 25 degrees C for top-of-canopy leaves}

\item{CI}{Clumping inedx; 0.63 for tropical evergreen forests (Chen et al, 2005)}
}
\value{
List containing: PAR0 - ; Ib0 - ; Id0 - ; Lsun - Sunlit LAI; Lshade - Shade LAI; Ic - Canopy total absorbed irradiance;
Isun - Sunlit leaf absorbed irradiance; Ishade - Shade leaf absorbed irradiance; Vc - Canopy total Vcmax;
Vcsun - Sunlit leaf Vcmax; Vcshade - Shade leaf Vcmax
}
\description{
Function for revised DF1997 model to partition canopy LAI into sunlit/shade leaves LAI and
partition canopy Vcmax into sunlit/shade leaves Vcmax clumping index was added to original
DF1997 model, following the reference from Ryu et al. 2011
}
\details{
Goal: Use revised DF1997 model to partition canopy LAI into sunlit/shade leaves LAI and 
partition canopy Vcmax into sunlit/shade leaves Vcmax clumping index was added to original 
DF1997 model, following the reference from Ryu et al. 2011
}
\examples{
FLAG <- 1
SZA <- 30
LAI <- 6
Press <- 10^5
PAR0 <- 1320 # top canop irradiance, in umol/m2/s
Vcmax0_25 <- 40 # Bonan et al., 2012 for the tropcis
Clumping <- 0.63 # Clumping index, from Chen etal., 2005 for tropical evergreen forests

LQ <- Func_Light_Partitioning(SZA=SZA,P=Press,PAR=PAR0)
Ib0 <- LQ$Model_DV
Id0 <- LQ$Model_dV

output <- Func_Canopy_Radiation_Transfer(FLAG=FLAG, SZA=SZA, LAI=LAI, Ib0=Ib0, Id0=Id0, Vcmax0_25=Vcmax0_25, CI=Clumping)

}
\author{
Jin Wu

Shawn Serbin
}
\references{
dePury and Farquhar, 1997; Ryu et al., 2011
}

