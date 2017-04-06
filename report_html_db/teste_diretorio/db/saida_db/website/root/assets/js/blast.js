/**
 * File with actions of the blast page
 * 
 * @author Wendel Hime Lino Castro
 */

$("#back").hide();

$("#SEQFILE").on("change", function() {
	startRead("SEQFILE");
});

/**
 * Button back on click
 */
$("#back").click(function() {
	$("#formBlast").show();
	$("#back").hide();
	$(".response").remove();
});

/**
 * Add function to submit form
 */
$(function() {
	$("#formBlast").submit(function() {
		if ($("#SEQUENCE").val() == "") {
			$("#SEQUENCE").val(fileContent);
			$("#FILESEQ").val("");
		}
		if ($("#SEQUENCE").val() != "") {
			// var sourceObject = JSON.parse(JSON.stringify($("#formBlast")
			// .serializeArray().reduce(function(a, x) {
			// a[x.name] = x.value;
			// return a;
			// }, {})));
			var form = document.getElementById("formBlast");
			var formData = new FormData(form);
			var baseResponse = postBlast(formData).done(function(baseResponse) {
				baseResponse = JSON.parse(baseResponse);
				var response = baseResponse.response;
//				var w = window.open();
//				w.document.open();
//				w.document.write(response);
//				w.close();
				 $("#back").show();
				 $("#formBlast").hide();
				 var html = "<div class='row response'><div class='col-md-12'>" + response + "</div></div>";
				 $("#containerBlast").append(html);
			});
		}
		return false;
	});
});
