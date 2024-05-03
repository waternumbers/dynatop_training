# dynatop_training

This repository contains training material relating to the
[dynatop](https://waternumbers.github.io/dynatop/) and
[dynatopGIS](https://waternumbers.github.io/dynatopGIS/) packages.
The current training materials relate to versions 0.3 of both packages which
are available on [r-universe](https://waternumbers.r-universe.dev/builds). 
Older training material relating relating to versions v0.2 can be found in v02
branch of this repository

The training materials is split into tow parts and covers:

- Documentation of what trainees should have/bring
- Part 1

	- Some Dynamic TOPMODEL theory
		- This is enough to have appropriate terminology and an understanding of the solution scheme
	- Overview of stages in model creation/execution
		- This includes the role of different packages in acheiving this
	- GIS processing and model creation
		- Including teh choice of appropriate resolution of DEM and channel network
	- Processing and setting up inputs
   - Simulation of the model, changing parameters, efficient Monte-Carlo runs
   - Cover use of HPC/HEC with parrallel runs (but this is not system specific at the call level)
   - Extracting and visualising states, channel inflow and flow series at gauges

- Part 2

	- Altering code and rebuilding the R package
	- Crash course in R package structure, self documenting etc
	- Simple example (new tranmissivity profile?)
		- develop, document, test
	- git and submission of alterations to main repository

## TO DO

- 03_dynamic_topmodel
  - Classification needs to represent channel handling changes
  - HRU description to reflect single HRU type with multiple options
- 05_eden
  - links to papers
- 10_initial_gis
  - switch to correct working directory
  - don't need to install packages just load terra
  - change references from raster to terra
  -
