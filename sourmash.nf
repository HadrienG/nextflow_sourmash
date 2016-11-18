#!/usr/bin/env nextflow

params.reads = 'data/*.fq'
params.adapt = 'data/adapters.fasta'

files = Channel.fromPath(params.reads)
adapters = file(params.adapt)

process adapter_trimming {
    input:
        val file from files
        file 'adapters.fasta' from adapters

    output:
        file "*.fastq" into adapt_trimmed

    script:
		"""
		scythe -q sanger -a adapters.fasta -o "${file.baseName}.fastq" $file
		"""

}

process quality_trimming {
    input:
        file fastq from adapt_trimmed

    output:
        file "*.trimmed" into trimmed

    script:
        """
        sickle se -f $fastq -t sanger -o "${fastq.baseName}.trimmed" -q 20
        """
}

process sourmash_compute {
    input:
        file trimmed

    output:
        file "*.sig" into sourmash_compute

    script:
        """
        sourmash compute -f $trimmed
        """
}

process sourmash_compare {
    input:
        file '*.sig' from sourmash_compute.toList()

    output:
        file "cmp" into sourmash_compare
        file "cmp.labels.txt" into labels

    script:
        """
        sourmash compare *.sig -o cmp
        """
}

process sourmash_plot {
    publishDir 'results'

    input:
        file "cmp" from sourmash_compare
        file "cmp.labels.txt" from labels

    output:
        file "*.png" into plots

    script:
        """
        sourmash plot cmp --pdf
        """
}
