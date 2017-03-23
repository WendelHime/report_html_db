/**
 * This clients will make requests locally
 * @author Wendel Hime Lino Castro
 */

/**
 * Method used to get content from file HTML
 * 
 * @param filepath:
 *            directory + fileto be read
 * @returns XMLHttpRequest
 */
function getHTMLContent(filepath) {
    return $.ajax({
        type : "GET",
        dataType : "json",
        url : "/GetHTMLContent?filepath=" + filepath,
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
        url : "/Components",
        async : false,
        cache : false
    });
}

/**
 * Method used to search by contig
 * 
 * @param serializedForm:
 *            serialized form
 * @returns XmlHttpRequest
 */
function searchContig(serializedForm) {
    return $.ajax({
        type : "GET",
        dataType : "json",
        url : "/Contig?" + serializedForm,
        async : false,
        cache : false
    });
}