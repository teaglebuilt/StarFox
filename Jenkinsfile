try {
    sh 'make test grid-up'

    try {
        sh 'make test PYTESTOPTS=""'
    } finally {
        archiveArtifacts '*.png, *.xml, *.log'
        junit '*.xml'
    } finally {
        sh 'make network down'
    }
}