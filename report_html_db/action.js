/**
 * File with actions of the website
 */

/**
 * Hide button back
 */
$("#back").toggle();

/**
 * Button back on click
 */
$("#back").click(function() {
	$("#searchPanel").show();
	$("#back").hide();
	$("#result").remove();
});

/**
 * Method used to define, any form when submit, will do the same thing hide
 * searchPanel, add button to return, and add panel to results that's wrong,
 * correct make a submit function to all forms
 */
$(function() {
	$("#formSearchContig")
			.submit(
					function() {
						$
								.getJSON($(this).attr('action'),
										$(this).serialize())
								.done(
										function(data) {
											var htmlContent = data.html;
											htmlContent = htmlContent
													.replace(
															/(\[\% sequence.id \%\])+/gim,
															data.geneID);
											htmlContent = htmlContent
													.replace(
															/(\[\% start \%\])+/gim,
															$(
																	"input[name=contigStart]")
																	.val())
											htmlContent = htmlContent.replace(
													/(\[\% end \%\])/gim,
													$("input[name=contigEnd]")
															.val())
											htmlContent = htmlContent
													.replace(
															/(\[\% sequence.name \%\])+/gim,
															data.gene);
											htmlContent = htmlContent.replace(
													/(\[\% contig \%\])+/gim,
													data.contig);
											$("#searchPanel").hide();
											$("#back").show();
											$("#searchPanel").parent().append(
													htmlContent);
											var titlePanel = "Contig search results - Retrieved sequence(";
											if ($("input[name=contigStart]")
													.val() != ""
													&& $(
															"input[name=contigEnd]")
															.val() != "") {
												titlePanel += "from "
														+ $(
																"input[name=contigStart]")
																.val()
														+ " to "
														+ $(
																"input[name=contigEnd]")
																.val() + " of ";
											}
											titlePanel += data.gene;
											if ($("input[name=revCompContig]")
													.is(":checked")) {
												titlePanel += ", reverse complemented";
											}
											titlePanel += ")";
											$("#title-panel").text(titlePanel);
										})
								.fail(function(jqxhr, textStatus, error) {
									var err = textStatus + ", " + error;
									$("#formSearchContig").append("<div class='alert alert-danger'>"+err+"</div>");
								});
						return false;
					});
});
