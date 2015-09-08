# CITATION

GTASSIST: Objective evaluation measures of genetic marker selection in large-scale SNP genotyping
Kaminuma E, Masuya H, Miura I, Motegi H, Takahasi KR, Nakazawa M, Matsui M, Gondo Y, Noda T, Shiroishi T, Wakana S, Toyoda T.
J Bioinform Comput Biol. 2008 6:905-17.  
http://www.ncbi.nlm.nih.gov/pubmed/18942158

# LICENSE

RIKEN : All Rights Reserved.

# CONTACT INFORMATION

Please ask to [Eli Kaminuma](http://www.nig.ac.jp/nig/research/organization-top/organization/nakamura)(National Institute of Genetics) and [Hiroshi Masuya](http://ja.brc.riken.jp/lab/bpmp/unit/unit_member.html)(RIKEN BRC) if you have 
any problems in GTASSIST software.

----
# GTASSIST Instruction

<< Introduction of GTAssist  >>

GTAssist is a tool that assists in marker selection and allele discrimination during SNP genotyping. This program supports two useful evaluation measures for two-dimensional fluorescent scatter plots of TaqMan assays[1], which are a popular technology in SNP genotyping. The two proposed measures can be used in succeeding genotyping processes. The first proposed measure is the Marker Ranking Measure (MRM) to choose SNP markers with good distributions without relying on clustering results. The second proposed measure is the Individual Genotype Membership Measure (IGMM) which utilizes the membership probability of each genotype to provide beneficial information for gene mapping.

<< Main features of  GTAssist >>

Assists with allele discrimination of hard fluorescent scatter data for SNP genotyping
MRM measures the SNPs in order to select appropriate genetic markers
IGMM quantifies the membership probability of an individual within the SNP marker data.
<< Introduction of GTAssist >>

1. Marker Ranking Measure (program mrm)

The first measure, MRM, quantifies the distance to an ideal distribution as SNP markers. Nonlinear probabilistic distribution of the scatter data is estimated by a Kernel method[2]. Then, the ideal probabilistic distribution for the SNP marker is set. The difference between the ideal distribution and the estimated distribution of the scatter plot calculated by the multimodal overlap measure[3] is defined as the MRM. 

2. Individual Genotype Membership Measure (program igmm)

The second measure, IGMM, is defined as the membership probabilities of genotype classes. Currently, indistinct individuals remaining after allele discrimination are labelled 'unknown' by expert operators. The 'unknown' individuals may indicate intermediate fluorescent values of two genotypes or weak fluorescent values.The Mahalanobis distances[3] for individuals based on genotype classes are first obtained. The IGMM is then calculated as the membership probability based on the distribution of squared Mahalanobis distances, which approximately follows the c2 distribution.

<< PROGRAM CONTENTS : (2015/9/8 modified)>>

The GTAssist software can be freely downloaded and used by academic users based on the license agreement. The downloaded files consist of executable programs for MS Windows OS, and original MATLAB source code. Compilation of the original MATLAB source code requires Matlab 7.1 (R14) (Mathworks, Inc., Natick, MA), as well as the Statistic Toolbox 5.1 for Matlab or more recent versions. Matlab is a commercial technical computing application, which is widely used by engineers.

GTAssist archives

The following main files are suitably included.

WIN/MRM_WIN/mrm_win.exe (mrm executable file for MS Windows)
WIN/IGMM_WIN/igmm_win.exe (igmm executable file for MS Windows)
MCRInstaller.exe (installer)
SRC/*.m (source codes)
SNPDATA/*.txt (example files)
<< Installation of executable programs for Windows OS >>

1. Extract the zipped file into your preferred directory.

2. To use the standalone executable file, run MCRInstaller.exe. During the installation process, you will be prompted for a directory in which to install the 'MATLAB Component Runtime', for example, c:\MCR.

3. Add the following directory to your system path: <mcr_root>\<ver>\runtime\win32 
    NOTE: On Windows XP, this directory is automatically added to your path.

<< How to use >>

Here we introduce how to use the GTAssist software with the above-mentioned standalone executable programs under MS Windows.

1. Preparing SNP data

Prepare a tab-delimited text file for each SNPs data. The rows indicate respective individuals. The columns are explained in Table 1. The index of genotype classes in the 4th column are assigned as Table 2. The 'NTC' code means the negative control corresponding to water. The 'homo1' and 'homo2' codes denote homozygosity 1 and 2 respectively. The 'hetero' code represents heterozygosity. IGMM uses all genotype class codes but MRM checks only the code 0(NTC) to set the origin during preprocessing. In the IGMM program, unsupported codes are interpreted as unknown classes.

You can try SNPs files in the directory 'SNPDATA' for example.

SNPDATA/SNP-A.txt .... SNP-F.txt

SNPDATA/idealSNP.txt

SNPDATA/igmm_sample.txt

The filenames without extensions are assigned as SNP names in this software.

Table 1
 	1st column	2nd column	3rd column	4th column
contents
unique individual names	fluorescent data with the 1st dye	fluorescent data with the 2nd dye	Assigned class of the individual
format
string	double	double	integer(*)
(*) This is for convenience. On processing, MATLAB always uses double format.

Table 2
assigned genotype class
unknown	NTC	homo1	homo2	hetero
genotype class index
-1	0	1	2	3
 

2. Using MRM

(2-1). Run the program 'mrm_win.exe' in the 'MRM_WIN' directory by mouse double-click.

Note that the running program requires 'mrm_win.ctf', which needs to exist in the same directory as the standard executable program.
(2-2). Select the "Load Ideal Data" button, and load the file 'idealSNP.txt' in the 'SNPDATA' directory.

(2-3). Select the "Load Test Data" button, and load 6 SNP files of 'SNP-A.txt' , 'SNP-F.txt' in the 'SNPDATA' directory. You can check data distribution of each SNP by selecting a SNP name in the right listbox.


(2-4). You can check respective scatter plots of all test SNPs by directly double-clicking an item in the right listbox.

Note that the plot data was automatically normalized by the maximum value of two fluorescent values and shifted to the origin onto the mean of data assigned as the NTC class. If your data includes outliers possible to confuse succeeding marker selection analysis, you can remove the outliers manually and save updated data by the IGMM program. See (3-3).
 

(2-5). Select "Calc. Ideal PDF " and "Calc. Test PDFs" buttons to obtain the probability distributions. 

 

(2-6). Select the "Calculate Order" button to calculate the Marker Ranking Measure. The ranking, SNP names, and values of MRM are displayed in the listbox.



(2-7). Select the "Save Order" button to save the ranking results into a tab-delimited text file. The 1st. to 4th. columns of the file indicate the ranking index, ranked SNP names, file names with full paths, and values of MRM respectively.


(2-8). The program will close when the "Exit" button is pressed.

2. Using IGMM

(3-1).Run the program 'igmm_win.exe' in the 'IGMM_WIN' directory by mouse double-click.

Note that the running program requires 'igmm_win.ctf', which needs to exist in the same directory as the standard executable program.
(3-2). Select "1. Load" button, and load the file 'igmm_sample.txt' in the 'SNPDATA' directory. 
The scatter plot appears in the main figure. Above the figure, the numbers of each classes are displayed. 
The color of each class is automatically assigned under default colormap. The individuals of 'unknown' class are black-colored.



(3-3). Re-normalize data if necessary. The plot data was automatically normalized by the maximum value of two fluorescent values and shifted to the origin onto the mean of data assigned as the NTC class. If your data includes outliers possible to confuse succeeding analysis, you can remove the outliers with manual works as follows.

Click "2.Select One" button, and select an individual corresponding to the outlier on the main figure. Then select "Remove One" in the Edit menu. Next, select "Normalize Data" in Tool menu. You can save the renormalized data by using "4. Save" button.

Note that the genotype class index of the removed individual is assigned to NaN. Thus NaN should be shown in the 4th column of the individual row in the saved file. When loading data, the GTAssist software ignores NaN assigned individuals.
(3-4). Click "2. Select One" button, and click on an 'unknown' individual in the main figure to see IGMM membership probabilities of an individual. The IGMM membership probabilities are shown in the right figure. The information of the selected individual also appears in the panel of 'Individual information'.



 

(3-5). Select "3. Update One" button if you want to change the class of the selected individual based on the maximum of the IGMM membership probabilities. The class in the panel and the color of the individual in the figure are updated. 
The 'undo' of this operation is provided as an item in the Edit menu.



Note that you can change the class in the panel by direct keyboard input. Input the name of assigned genotype class 'homo2' or the corresponding genotype class index '2'.



 

(3-6). You can choose "2'. Select All" and "3'. Update All" buttons if you update the classes of all 'unknown' individuals by using the IGMM membership probabilities.



(3-7). The updated classes can be save in a text file by using "4. Save" button. The 3rd. column indicates updated classes. And the 4th. column indicates original classes.

(3-8). The program will close when the "5. Exit" button is pressed.

<<< Error Messages >>>

Title	Error Message	MRM	IGMM	Explanation
Warning	 ? individuals
 [?]->[unknown]	 	u	Individuals of unsupported codes are automatically assigned to the ‘unknown’ code.
ANALYSIS ERROR	Please categorize the data.	 	u	The number of individuals in several classes is zero. You need to label individuals assigned to those classes.
ANALYSIS ERROR	XXX requires more individuals.	 	u	XXX corresponds to a class. The analysis of IGMM requires that the number of individuals in each class is more than 4.
 

<<< References >>>

[1] Livak, K.J. (1999), Allelic discrimination using fluorogenic probes and the 5' nuclease assay, Genet. Anal., 14, 143-149.

[2] Hastie T., Tibshirani R., Friedman J.H. (2001), The Elements of Statistical Learning, Springer.

[3] Kil, D.H. and Shin, F.B. (1996), Pattern Recognition and Prediction with Applications to Signal Characterization,  AIP Press.

[4] http://www.mathworks.com/




