# swan-src
[SWAN Model Source Code](http://swanmodel.sourceforge.net/)

## Modifications
List of [additions](#add), [changes](#cha), [compatibility](#com), [implementation issues](#imp) and [bug fixes](#bug) since version 41.01

### <a name="add"></a>Additions

#### Version 41.10:
- Spectral partitioning is included as an option. Partition of wave spectra is based on the watershed algorithm of Hanson and Phillips (2001). First partition is due to wind sea and the remaining partitions are the swell, from highest to lowest significant wave height. On request, a raw spectral partition file can be generated meant for wave system tracking post-processing. Details on the file format and meaning of different parameters may be found in [WW3 wavetracking](http://polar.ncep.noaa.gov/waves/workshop/pdfs/WW3-workshop-exercises-day4-wavetracking.pdf).
- An option is included which enables the user to specify frequency- and direction-dependent transmission coefficients to be applied to an obstacle. This is mainly useful for wave energy converters (WECs) which can only transmit wave energy from a specific range of frequencies for each directional segment, whereas left unaffected in some other frequencies. 

#### Version 41.01:
- The so-called β-kd model for surf breaking based on the work of [Salmon and Holthuijsen (2011)](http://www.waveworkshop.org/12thWaves/Papers/manhawaii%202a%20_1_.pdf) is included as an option. This model determines the breaker index γ based on the bottom slope β and the dimensionless depth kd. See also the poster [SWAN and its recent developments](http://www.oceanweather.org/13thWaves/Presentations/wh2013_zijlema_etal.pdf).
- An alternative for triad wave-wave interactions is added. This alternative is the Stochastic Parametric model based on the Boussinesq-type wave equations (SPB) of [Becq-Girard et al. (1999)](http://dx.doi.org/10.1016/S0378-3839(99)00043-5).
- Interaction of waves with fluid mud is included as an option. Fluid mud affects waves through viscous damping and alters the dispersion relation and thereby the change in wave number and group velocity. These are obtained from the model of [Ng (2000)](http://dx.doi.org/10.1016/S0378-3839(00)00012-0). Details on the implementation and application of fluid mud-induced wave dissipation can be found in [Rogers and Holland (2009)](http://dx.doi.org/10.1016/j.csr.2008.09.013).
- A movable bed roughness model through ripple formation is included as an alternative. This model is implemented in SWAN as described in [Smith et al. (2011)](http://dx.doi.org/10.1016/j.coastaleng.2010.11.006), in which bottom friction depends on the formation process of bottom ripples and on the grain size of the sediment. 

### <a name="cha"></a>Changes

#### Version 41.10:
- Implementation of triads has been improved:
  - coefficient [trfac] is set to 0.8 in case of LTA and 0.9 in case of SPB
  - implementation SPB more structured and documented 
- Efficiency of UnSWAN algorithm has been further improved by taking 1 sweep per iteration. 

#### Version 41.01:
- For computing wind drag the second order polynomial fit as described in this [article](http://dx.doi.org/10.1016/j.coastaleng.2012.03.002) is the default instead of the well-known Wu (1982) parameterization. At the same time the value of the Jonswap bottom friction is set to 0.038 m²/s³. This is default irrespective of swell and wind-sea conditions.
- The stopping criterion of [Zijlema and Van der Westhuysen (2005)](http://dx.doi.org/10.1016/j.coastaleng.2004.12.006) is the default. This criterion is based on the curvature of the iteration curve of the significant wave height. The former stopping criterion (activated though NUM ACCUR) will become obsolete.
- The LTA formulation for triad-wave interactions is made consistent with the uni-directional approximation in the limit of directional spreading to zero. This is particularly meant for e.g. swell or in (nearly) 1D conditions.

### <a name="com"></a>Compatibility

#### Version 41.10:
SWAN 41.10 is fully compatible with version 41.01AB.

#### Version 41.01:
SWAN 41.01 is fully compatible with version 40.91ABC.

### <a name="imp"></a>Implementation

#### Version 41.10:
An option at compile level is available to switch from the wavefront to the block Jacobi approach for parallel MPI runs. The latter is very efficient for nonstationary computations. See [Implementation Manual](http://swanmodel.sourceforge.net/online_doc/swanimp/node7.html) for more details.

#### Version 41.01:
This version supports netCDF output (both integrated parameters and spectra). 

### <a name="bug"></a>Bug fixes

#### Solved in version 41.10:
- small bug outputting in case of obstacles in parallel unstructured mesh
- in case exception value is zero, not write to Matlab as NaN 

#### Solved in version 41.01:
- many bug fixes in netCDF implementation
- correction Gregorian date of December 31 for years 1599, 1999, 2399, etc.
- some bug fixes in outputting (e.g. spectra and date) for parallel unstructured mesh 
##### The following fixes and (small) extensions were introduced with patch A.
- an option is available to include turbulence viscosity
- when coupled with ADCIRC, the default is to use ADCIRC drag formulation
- change default value of [trfac] for triads
- changes with respect to netCDF:
  - lower memory usage
  - table output in netCDF format
  - warning non-supported output quantities to prevent crash when outputting 
- variable declaration improved
- correction computation of output quantity TRANSP
- small bug fix with vegetation
- small bug fix with reading input field
- small bug fix with outputting spectra in case of Doppler shift
##### The following fixes and (small) extensions were introduced with patch B.
- calculation of turning rate improved
  - based on derivatives of phase velocity instead of depth
  - central differences instead of upwind for computing derivatives (structured)
  - Green-Gauss formula instead of upwind for computing derivatives (unstructured)
  - inclusion neighboring sweeps removed 
- cdlim removed
- in case of ambient current set IQUAD to 3 by default
- two small bug fixes with netCDF
