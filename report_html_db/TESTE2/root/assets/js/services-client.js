/**
 * This is the library dedicated to the clients
 * Here we have the layer of communication between application and services
 * @author Wendel Hime Lino Castro
 */

/**
 * Method used to search by features
 * 
 * @param geneId:
 *            ID of gene
 * @param geneDescription:
 *            Description of gene
 * @param noDescription:
 *            Content to not be found
 * @param featureId:
 *            Can be a list of feature IDs or just one
 * @returns XMLHttpRequest
 */
function searchGene(geneId, geneDescription, noDescription, individually,
        featureId) {
    return $.ajax({
        type : "GET",
        dataType : "json",
        url : "/SearchDatabase/Gene/" + geneId + "/" + geneDescription + "/"
                + noDescription + "/" + individually + "/" + featureId,
        async : false,
        cache : false
    });
}

/**
 * Method used to return basic data of genes from database: the beginning
 * position from sequence, final position from the sequence, type, name
 * 
 * @param id:
 *            Id of gene
 * @returns XMLHttpRequest
 */
function getGeneBasics(id) {
    return $.ajax({
        type : "GET",
        dataType : "json",
        url : "/SearchDatabase/GetGeneBasics/" + id,
        async : false,
        cache : false
    });
}

/**
 * Method used to get properties of internal evidences
 * 
 * @param id:
 *            Gene ID
 * @param component:
 *            Component name
 * @returns XMLHttpRequest
 */
function getIntervalEvidenceProperties(id, component) {
    return $.ajax({
        type : "GET",
        dataType : "json",
        url : "/SearchDatabase/getIntervalEvidenceProperties/" + id + "/"
                + component,
        async : false,
        cache : false
    });
}

/**
 * Method used to return properties of evidence typed like similarity
 * 
 * @param id:
 *            Id of gene
 * @param component:
 *            Component name
 * @returns XMLHttpRequest
 */
function getSimilarityEvidenceProperties(id, component) {
    return $.ajax({
        type : "GET",
        dataType : "json",
        url : "/SearchDatabase/getSimilarityEvidenceProperties/" + id + "/"
                + component,
        async : false,
        cache : false
    });
}

/**
 * Method used to get subsequence
 * 
 * @param type:
 *            Type of sequence
 * @param contig:
 *            Contig to extract data
 * @param sequenceName:
 *            Sequence name
 * @param start:
 *            Start of the sequence
 * @param end:
 *            End of the sequence
 * @returns XMLHttpRequest
 */
function getSubsequence(type, contig, sequenceName, start, end) {
    return $.ajax({
        type : "GET",
        dataType : "json",
        url : "/SearchDatabase/GetSubsequence/" + type + "/" + contig + "/"
                + sequenceName + "/" + start + "/" + end,
        async : false,
        cache : false
    });
}

/**
 * Method used to get components
 * 
 * @returns XMLHttpRequest
 */
function getComponents() {
    return $.ajax({
        type : "GET",
        dataType : "json",
        url : "/SearchDatabase/getComponents",
        async : false,
        cache : false
    });
}

/**
 * Method used to get subevidences
 * 
 * @param featureId:
 *            Feature ID
 * @returns XMLHttpRequest
 */
function getSubEvidences(featureId) {
    return $.ajax({
        type : "GET",
        dataType : "json",
        url : "/SearchDatabase/subEvidences/" + featureId,
        async : false,
        cache : false
    });
}