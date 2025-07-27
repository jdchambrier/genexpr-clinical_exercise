process DATA_MANAGEMENT {
    tag "${params.input}"
    label 'process_single'

    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'rpreprocess:0.1' :
        'rpreprocess:0.1' }"

    input:
    path input
    path 'management.Rmd'

    output:
    path '*.csv'       , emit: clean_data
    path '*.html'      , emit: data_management_report
    path "versions.yml", emit: versions

    when:
    task.ext.when == null || task.ext.when

    script: // This script is bundled with the pipeline, in genexpr/clinical_exercise/bin/
    def input_file = file(params.input)         
    def filename = input_file.baseName
    """
    pwd
    Rscript -e '
        rmarkdown::render("management.Rmd",
        params = list(input = "${input}"),
        output_file = "${filename}_data_management_report.html")
    '

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        R: \$(R --version | sed '1!d; s/.*version //; s/ .*//')
    END_VERSIONS
    """
}
