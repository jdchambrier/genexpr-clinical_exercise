process DE_ANALYSIS {
    tag "${params.input}"
    label 'process_single'

    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'rpreprocess:0.1' :
        'rpreprocess:0.1' }"

    input:
    path clean_data
    val gender
    path 'de_analysis.Rmd'

    output:
    path '*.html'       , emit: d2_report
    path '*.csv'        , emit: significance_results
    path "versions.yml" , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script: // This script is bundled with the pipeline, in genexpr/clinical_exercise/bin/
    def input_file = file(params.input)         
    def filename = input_file.baseName          

    """
    Rscript -e '
        rmarkdown::render("de_analysis.Rmd",
        params = list(input = "${clean_data}",
                      gender = "${gender}"),
        output_file = "${filename}_dif_exp_d2_${gender}_report.html")
    '

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        R: \$(R --version | sed '1!d; s/.*version //; s/ .*//')
    END_VERSIONS
    """
}
