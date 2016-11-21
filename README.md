# Sourmash

Compute MinHash signatures for DNA sequences.

### Quick Start

To execute the pipeline on your computer, first pull the docker image

    docker pull hadrieng/sourmash

Then execute the workflow

    nextflow run sourmash.nf --reads data/\*.fastq

It will produce a directory containing a clustering & dendrogram of all the fastq files present in your data directory, as well as a similarity matrix and heatmap.

### Pipeline parameters

#### --reads

* This parameter is required.
* Specifies the location of the reads fastq file

#### --adapt

* Optional.
* Specifies the location of the adapters file for adapter trimming
* It must end in .fasta
* By default it is set to data/adapters.fasta

### Profiles

*The SGBC cluster uses a module system. Pulling the docker image is not required!*

By default, the pipeline runs locally using docker. If you run the nonpareil pipeline on the SGBC cluster, please pass the option **-profile planet**

Example:

    nextflow run sourmash.nf -profile planet --reads /proj/my_proj/data/\*.fastq --adapt custom_adapters.fasta

### Citations

> * Buffalo Vince (2011), Scythe: A Bayesian adapter trimmer [Software]. Available at https://github.com/vsbuffalo/scythe
> * Joshi NA, Fass JN. (2011). Sickle: A sliding-window, adaptive, quality-based trimming tool for FastQ files
[Software].Available at https://github.com/najoshi/sickle.
> * C. Titus Brown (2016). sourmash: a library for MinHash sketching of DNA. JOSS. doi: 10.21105/joss.00027
