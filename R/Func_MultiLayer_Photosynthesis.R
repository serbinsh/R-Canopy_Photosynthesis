#--------------------------------------------------------------------------------------------------#
##' 
##' Canopy multi-layer photosynthesis model
##' 
##' @title Func_Multi_Layer_Photosynthesis_Model
##' 
##' @param FLAG Model version controller;  0--Lloyd et al. 2010 Model for Vcmax-LAI relationship; 
##' 1--Mercado et al. 2006 Model for Vcmax-LAI relationship in the tropics
##' @param SZA solar zenith angle, in degrees
##' @param Press Atmospheric pressure in Pa
##' @param PAR0 measured  top canop irradiance, in umol/m2/s
##' @param LAI total canopy LAI
##' @param Tleaf Leaf temperature in degrees C
##' @param Tleaf_diff Difference in leaf temperature between sunlit and shaded leaf fractions 
##' in degrees C
##' @param ambCO2 ambient CO2 concentration, in ppm
##' @param Vcmax0_25 Vcmax at reference 25 degrees C for top-of-canopy leaves
##' @param CI Clumping inedx; 0.63 for tropical evergreen forests (Chen et al, 2005)
##' @param Topt optimal leaf temperature for tropical evergreen forests, from Lloyd and Farquhar, 2008
##' @param Nlayers number of layers for Multi-Layer Photosynthesis Modeling
##' @param Phi_sun the curvature factor for light response curves for sunlit leaves 
##' @param PSII_sun maximum quantum yield for sunlit leaves
##' @param Phi_shade the curvature factor for light response curves for sunlit leaves 
##' @param PSII_shade maximum quantum yield for shade leaves
##' @param sf_sun scaling factor for sunlit leaves, due to leaf age effect
##' @param sf_shade scaling factor for shade leaves, due to leaf age effect
##' @param sf scaling factor due to leaf age effect, assuming no phenological partitioning across vertical canopy profile
##' 
##' 
##' 
##' @export
##' @author Jin Wu
##' @author Shawn Serbin
##' 

## FOR DEBUGGING
FLAG <- 1
SZA <- 30
Press <- 10^5
LAI <- 6
PAR0 <- 1320
Vcmax0_25 <- 40
Nlayers <- 20
CI <- 0.63

Func_Multi_Layer_Photosynthesis_Model <- function(FLAG, SZA, Press, PAR0, LAI, Tleaf, 
  Tleaf_diff, ambCO2, Vcmax0_25, CI, Topt, Nlayers, Phi_sun, PSII_sun, Phi_shade, 
  PSII_shade, sf_sun, sf_shade, sf) {
  print("under development")
  
  num.args <- nargs()
  # if (num.args<9) stop(paste0('Missing function arguments.  Number of arguments
  # ', print(num.args),' less than the total required 9'))
  
  LQ <- Func_Light_Partitioning(SZA, Press, PAR0)
  
  ## Step 1--Calculate vertical distribution of LAI_sun/shade, PAR_sun/shade,
  ## Vcmax_sun/shade
  
  # Calc LAI by layer
  LAIi <- 1:Nlayers/Nlayers * LAI
  
  # Calculate canopy fractions
  canopy_frac <- Func_Canopy_Radiation_Transfer(FLAG, SZA, LAIi, LQ$Model_DV, 
                                                   LQ$Model_dV, Vcmax0_25, CI)
  
  # Calculate the average Vcmax within each layer of the canopy !! TRYING TO ELIMINATE LOOP
  #for (i in 1:Nlayers) {
   # canopy_rt <- Func_Canopy_Radiation_Transfer(FLAG, SZA, LAIi[i], LQ$Model_DV, 
  #    LQ$Model_dV, Vcmax0_25, CI)
  #} # End of vert dist loop
  
  Vc <- (Vcmax0_25*exp(-kn*LAIi)+Vcmax0_25*exp(-kn*((i-1)/Nlayers*LAI)))/2
  
  if (FLAG == 0) {
    
    ## STILL TRYING TO UNDERSTAND WHY THESE ARE DIFFERENT?
  } else {
    kn <- 0.1823
    L <- LAIi[i]
    Vc <- (Vcmax0_25*exp(-kn*L)+Vcmax0_25*exp(-kn*((i-1)/Nlayers*LAI)) )/2
    Vc
    
    G <- 0.5  # the parameter used in Depury and Farquhar's model
    kb <- G/cos(SZA/180 * pi)  # extinction coefficient; G refers to G function, could be 0.5 to simplify it
    Vcsun <- CI * Vcmax0_25/(kn + kb * CI) * (1 - exp(-(kb * CI + kn) * L ))  # sunlit leaves Vcmax
    Vc <- Vcmax0_25/kn * (1 - exp(-kn * L))  # canopy scale vcmax
  }
  
  # return(LQ)
}
#--------------------------------------------------------------------------------------------------#
### EOF
