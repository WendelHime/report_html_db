/**
 * File with actions of the website
 */

/**
 * Hide button back
 */
$("#back").toggle();
$("#test").hide();
$(".result").remove();

/**
 * Button back on click
 */
$("#back").click(function() {
	$("#searchPanel").show();
	$("#back").hide();
	$(".result").remove();
});

$(function() {
	$("#formGeneIdentifier").submit(
		function() {
			$(".errors").remove();
			$.getJSON($(this).attr('action'), $(this).serialize())
				.done(
					function(data) {
						contentGeneData("#formGeneIdentifier", data);
					}
				)
				.fail(
					function(jqxhr, textStatus, error) {
						var err = textStatus + ", " + error;
						$("#formGeneIdentifier").append("<div class='alert alert-danger errors'>Oops, there is a error on the research: "+ err + "</div>");
					}
				);
			return false;
		}
	);
});

$(function() {
	$("#formGeneDescription").submit(
		function() {
			$(".errors").remove();
			$.getJSON($(this).attr('action'), $(this).serialize())
				.done(
					function(data) {
						contentGeneData("#formGeneDescription", data);
					}
				)
				.fail(
					function(jqxhr, textStatus, error) {
						var err = textStatus + ", " + error;
						$("#formGeneDescription").append("<div class='alert alert-danger errors'>Oops, there is a error on the research: "+ err + "</div>");
					}
				);
			return false;
		}
	);
});

function contentGeneData(id, data) {
	if(data.length > 0) {
		for(var i = 0; i < data.length; i++) {
			var feature = data[i];
			var htmlContent = feature.html;
			htmlContent = htmlContent.replace(/(\[\% result.feature_id \%\])+/gim, feature.feature_id);
			htmlContent = htmlContent.replace(/(\[\% result.name \%\])/gim, feature.name);
			htmlContent = htmlContent.replace(/(\[\% result.uniquename \%\])/gim, feature.uniquename);
			$("#searchPanel").hide();
			$("#back").show();
			$("#searchPanel").parent().append(htmlContent);
			
			$("a[class=result-panel-title]").on("click", function() {
				var href = $(this).attr('href');
				var featureID = href.replace("#", "");
				$.getJSON("http://127.0.0.1:3000/SearchDatabase/GetGeneBasics/"+featureID, "")
					.done(
						function(data) {
							console.log(data);
						}
					);
				return false;
			});
		}
	}
	else {
		$(id).append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
	}
}

/**
 * Method used to change view and show data from the contig search
 */
$(function() {
	$("#formSearchContig").submit(
		function() {
			$(".errors").remove();
			$.getJSON($(this).attr('action'), $(this).serialize())
				.done(
					function(data) {
						var htmlContent = data.html;
						htmlContent = htmlContent.replace(/(\[\% sequence.id \%\])+/gim, data.geneID);
						htmlContent = htmlContent.replace(/(\[\% start \%\])+/gim, $("input[name=contigStart]").val())
						htmlContent = htmlContent.replace(/(\[\% end \%\])/gim, $("input[name=contigEnd]").val())
						htmlContent = htmlContent.replace(/(\[\% sequence.name \%\])+/gim, data.gene);
						htmlContent = htmlContent.replace(/(\[\% contig \%\])+/gim, data.contig);
						$("#searchPanel").hide();
						$("#back").show();
						$("#searchPanel").parent().append(htmlContent);
						var titlePanel = "Contig search results - Retrieved sequence(";
						if ($("input[name=contigStart]").val() != "" && 
							$("input[name=contigEnd]").val() != "") {
							titlePanel += "from "
									+ $("input[name=contigStart]").val()
									+ " to "
									+ $("input[name=contigEnd]").val() + " of ";
						}
						titlePanel += data.gene;
						if ($("input[name=revCompContig]").is(":checked")) {
							titlePanel += ", reverse complemented";
						}
						titlePanel += ")";
						$("#title-panel").text(titlePanel);
					}
				)
				.fail(
					function(jqxhr, textStatus, error) {
						var err = textStatus + ", " + error;
						$("#formSearchContig").append("<div class='alert alert-danger errors'>Oops, there is a error on the research: "+ err + "</div>");
					}
				);
			return false;
		}
	);
});
