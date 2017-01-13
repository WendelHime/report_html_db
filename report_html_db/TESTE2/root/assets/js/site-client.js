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