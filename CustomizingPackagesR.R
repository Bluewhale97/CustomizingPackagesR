#developer's bible for creating packages is Writing R Extensions by the R Core Team(http://cran.r-project.org/doc/manuals/R-exts.pdf)
#Friedrich Leishch also produced a nice tutorial on creating packages(http"//mng.bz/Ks84)

#step1: install the necessary tools
install.packages("roxygen2", depend=T)
#and download Rtool.exe (http://cran.r-project.org/bin/windows/Rtools) for windows

#step2: set up the directories. 
#in our home directory(the current working directory when we start R), create a subdiretcory named npar
#in this directory, create two subdirectories named R and data.
#get four functions from www.stamethods.net/RiA/nparFiles.zip(oneway.R and so on)
#Place the description file in the npar directory and the source files(oneway.R, print.R , summary.R, plot.R, life.R, and npar.R) in the R subdirectory
#place the life.rda file in the data subdirectory

#step3: generate the documentation

#load the roxygen2 package and use the roxygenize() function to process the documentation headers in each code file
library(roxygen2)
roxygenize("npar")

#roxygenize() function creates a new subdirectory, called man, that contains the .Rd documentation file for each function
#the markup from the comments at the top of each code file is used to build these documentation files
#roxygenize() also adds information to the DESCRIPTION file and creates a NAMESPACE file that is created for npar is as follows

#NAMESPACE file controls the visibility of our functions(are all functions available to th package user directly, or are some used internally by other functions?)
#in the current case, all functions are available to the user
#to learn more about namespaces, see http://adv-r.had.co.nz/Namespaces.html

#step 4: build the package
system("R CMD build npar")
#this ctreates the file npar_1.0.tar.gz in the current working directory
#the version number in the name is taken ffrom the DESCRIPTION file. the package is now in a format that can be distributed to others

system("Rcmd INSTALL --build npar")
#this creates the file npar_1.0.tar.zip in the current wc
#note that we can only create  a Windows binary file this way if we are working on a Windows platform
#if wanting to build a binary file for Windows but we dont have access to a Windows machine running R, we can use the online service provided at http://win-builder.r-project.org/

#step5:check the package(optional)
#to run extensive consistency checks on the package
system("R CMD check npar")

#this creates a folder call npar.Rcheck in the current working directory
#the folder contains the file 00.check.log, which describes the results of the checks 
#the directory also contains a file called npar-EX.R containing the code from any examples listed in the documentation
#the text output produced by executing the example code is contained in the file npar-EX.out
#if the examples created graphs(true in this case), they are placed in npar-Ex.pdf

#step6: create a PDF manual(optional)
system("R CMD Rd2pdf npar")
#generates a PDF reference manual like those we see on CRAN

#step7: install the package locally(optional)
system("R CMD INSTALL npar")
#installs the package on our machine and makes it available for use
#another way to install the package locally is to use
install.packages(paste(getwd(),"/npar_1.0.tar.gz",sep=""),
                 repos=NULL,type="source")
#we can see that the package has been installed by typing library(). After we type library(npar), the package will be available for use

#during the development cycle, we may want to delete a package from our local machine so that we can install a new version. In this case, use
detach(package:npar, unload=T)
remove.packages("npar")#to get a fresh start

#step8:
upload the package to CRAN(optional)
#if you would like to share your package with others by adding it to the CRAN repository, follow these three steps:
#read the CRAM repository policy(http://cran.r-project.org/web/packages/policies.htm)
#make sure the packages passes all checks in step 5 without erros or warnings. Otherwise the package will be rejected
#submit the package.
#to do so via web form, use the submission form at http://cran.r-project.org/submit,html
#we will be sent an automated confirmation emial that needs to be accepted

#to do so via FTP, upload the packageName_version.tar.gz file via anonymous FTP to ftp://cran.r-Project.org/incoming
#then send a plain-text emial to CRAN@R-project.org from the maintainer email address listed in the package
#use the subject line"CRAN submission PACKAGE version" without quates, where PACKAGE and VERSION are the package name and the version
#for new submissions, confirm in the body of the emial that we have read and agree to CRAN's policies

#12. going further

#adding externa compiled code to an R package, see The Writing R Extensions manual (http://cran.r-project.org/doc/manuals/R-exts.html)
#Stack Overflow(http://stackoverflow.com) ask questions if we get stuck

