[![Cite with Zenodo](http://img.shields.io/badge/DOI-10.5281/zenodo.XXXXXXX-1073c8?labelColor=000000)](https://doi.org/10.5281/zenodo.XXXXXXX)

[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A523.04.0-23aa62.svg)](https://www.nextflow.io/)
[![run with conda](http://img.shields.io/badge/run%20with-conda-3EB049?labelColor=000000&logo=anaconda)](https://docs.conda.io/en/latest/)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/)
[![Launch on Nextflow Tower](https://img.shields.io/badge/Launch%20%F0%9F%9A%80-Nextflow%20Tower-%234256e7)](https://tower.nf/launch?pipeline=https://github.com/genexpr/clinical_exercise)

## Introduction

**genexpr/clinical_exercise** is a bioinformatics pipeline that identify biomarkers of interest associated to the effect of the drug

!!! add flowchart here

1. Data management 
2. Biomarker expression analysis 

## Usage

> [!NOTE]
> If you are new to Nextflow and nf-core, please refer to [this page](https://nf-co.re/docs/usage/installation) on how to set-up Nextflow. Make sure to [test your setup](https://nf-co.re/docs/usage/introduction#how-to-run-a-pipeline) with `-profile test` before running the workflow on actual data.

1. Clone this git repo 
```bash
git clone https://github.com/jdchambrier/genexpr-clinical_exercise.git
```

2. Set up a conda env to be able to run nextflow (if applicable). 
```bash
cd genexpr-clinical_exercise
conda env create -f environment.yml
conda activate nextflow-env 
```

3. Prepare a your input data that looks as follows:

`test_data.csv`:

```csv
USUBJID,TREATMENT,VISIT,GENDER,MARKER_TP53,MARKER_BRCA1,MARKER_EGFR
1,DRUG,D0,MALE,2.5,5.2,3.8
1,DRUG,D1,MALE,3.1,5.5,4
1,DRUG,D2,MALE,NA,5.3,4.1
2,PLACEBO,D0,FEMALE,1.8,4.9,3.5
2,PLACEBO,D1,FEMALE,2,5,3.6
2,PLACEBO,D2,FEMALE,2.1,5.2,3.7
```   

create a folder like test_data and store [test_data.csv](https://github.com/user-attachments/files/21452788/test_data.csv) in test_data foler   
```bash
mkdir test_data
```


4. Build R docker that will be used within nextflow pipeline

```bash
cd docker # make sure you are in genexpr-clinical_exercise/docker
docker build -t rpreprocess:0.1 -f Dockerfile ./
```

Now, you can run the pipeline using:      

-- test pipeline using a prepared test data to try the pipeline       

```bash
cd ../ 
nextflow run main.nf \
   -profile docker \
   -c conf/test.config \
   --outdir output
```      
        
-- run pipeline with user defined input data     
```bash
cd ../   # make sure you are in genexpr-clinical_exercise when finish this command
nextflow run main.nf \
   -profile docker \
   --input <input full path> \   # e.g test_data/test_data.csv
   --outdir <OUTDIR>  # e.g output
```

5. Find outputs in ```--outdir``` indicated folder     
-- ```data_management``` subfolder for clean data after removing biomarkers containing missing values and a html report with descriptive statistics for TREATMENT, GENDER and MARKER_TP53



## For developers     

To make sure individual process and pipeline is working as expected:    
#### -- run data_management process unit test
```bash
nf-test test tests/modules/local/data_management.nf.test   --profile docker
```

#### -- run workflow integration test
```bash
nf-test test tests/workflows/clinical_exercise.nf.test   --profile docker
```

#### -- run pipeline integration test
```bash
nf-test test tests/main.nf.test   --profile docker
```     

You should expected the outcomes from unit test and integration tests:
```bash
 Test [xxxx] 'Should run without failures' PASSED
SUCCESS: Executed 1 tests in xxxxs
```



> [!WARNING]
> Please provide pipeline parameters via the CLI or Nextflow `-params-file` option. Custom config files including those provided by the `-c` Nextflow option can be used to provide any configuration _**except for parameters**_;
> see [docs](https://nf-co.re/usage/configuration#custom-configuration-files).

## Credits

genexpr/clinical_exercise was originally written by Jing.

We thank the following people for their extensive assistance in the development of this pipeline:



## Contributions and Support

If you would like to contribute to this pipeline, please see the [contributing guidelines](.github/CONTRIBUTING.md).

## Citations


An extensive list of references for the tools used by the pipeline can be found in the [`CITATIONS.md`](CITATIONS.md) file.

This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) community, reused here under the [MIT license](https://github.com/nf-core/tools/blob/master/LICENSE).

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).
