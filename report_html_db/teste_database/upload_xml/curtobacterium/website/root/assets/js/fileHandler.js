/**
 * this script is used to deal with blast file
 */

var fileContent = "";

function startRead(id) {
	// obtain input element through DOM

	var file = document.getElementById(id).files[0];
	if (file) {
		getAsText(file);
	}
}

function getAsText(readFile) {

	var reader = new FileReader();

	// Read file into memory as UTF-8
	reader.readAsText(readFile, "UTF-8");

	// Handle progress, success, and errors
	reader.onload = loaded;
	reader.onerror = errorHandler;
}

function loaded(evt) {
	// Obtain the read file data
	fileContent = evt.target.result;
	//	var fileString = evt.target.result;
}

function errorHandler(evt) {
	if (evt.target.error.name == "NotReadableError") {
		// The file could not be read
	}
}