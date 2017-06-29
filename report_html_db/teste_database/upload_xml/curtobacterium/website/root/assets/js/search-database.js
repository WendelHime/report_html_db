
/**
 * File with actions of the website
 * 
 * @author Wendel Hime Lino Castro
 */

var idForm = "";
var pageSize = 10;
var offset = 1;
var totalValues = 10;

/**
 * method used to verify paged responses
 * @param acientID ancient id
 * @param actualID id of actual form
 * @returns status
 */
function verifyPagedResponse(acientID, actualID, values) {
	var status = false;
	var numberOfPages = 0;
	$("#totalResults").show();
	$("#totalResults").text("Found " + totalValues + " results");
	if (totalValues <= 10) {
		numberOfPages = 1;
	} else {
		var number = (values / pageSize);
		if (Math.round(number) - number > 0) {
			numberOfPages = Math.round(number);
		} else {
			numberOfPages = Math.round(number + 1);
		}
	//    	var number = (values  + pageSize - 1) / pageSize;
	//    	if(Math.round(number) - number > 0) {
	//    		numberOfPages = Math.round(number);
	//    	} else {
	//    		numberOfPages = Math.trunc(number);
	//    	}
	}
	$("#numberPage").attr("max", numberOfPages);
	$("#totalNumberPages").text(numberOfPages);
	if (parseInt($("#numberPage").val()) > parseInt($("#totalNumberPages").text())) {
		$("#numberPage").val(1);
	}
	if (acientID == actualID) {
		if ((totalValues - offset) <= pageSize && ($("#numberPage").val() == $("#totalNumberPages").text())) {
			$("#more").attr("disabled", "disabled");
			$("#last").attr("disabled", "disabled");

		} else {
			$("#more").removeAttr("disabled");
			$("#last").removeAttr("disabled");
		}
		if (offset <= 1) {
			offset = 1;
			$("#less").attr("disabled", "disabled");
			$("#begin").attr("disabled", "disabled");
		} else {
			$("#less").removeAttr("disabled");
			$("#begin").removeAttr("disabled");
		}
		if (offset < 10 && $("#numberPage").val() > $("#totalNumberPages").text()) {
			$("#numberPage").val(1);
			$("#more").attr("disabled", "disabled");
			$("#last").attr("disabled", "disabled");
		}
		status = true;
	} else {
		offset = 1;
		if ((totalValues - offset) <= pageSize && ($("#numberPage").val() == $("#totalNumberPages").text())) {
			$("#more").attr("disabled", "disabled");
			$("#last").attr("disabled", "disabled");
		} else {
			$("#more").removeAttr("disabled");
			$("#last").removeAttr("disabled");
		}
		$("#less").attr("disabled", "disabled");
		$("#begin").attr("disabled", "disabled");
		$("#numberPage").val(1);
	}
	return status;
}

/**
 * Hide button back
 */
$("#back").toggle();
$("#totalResults").toggle();
$("#more").attr("disabled", "disabled");
$("#last").attr("disabled", "disabled");
$("#less").attr("disabled", "disabled");
$("#begin").attr("disabled", "disabled");
$(".pagination-section").toggle();
$("#test").hide();
$(".result").remove();

/**
 * Button back on click
 */
$("#back").click(function() {
	pageSize = 10;
	offset = 1;
	totalValues = 10;
	$("#searchPanel").show();
	$("#back").hide();
	$("#totalResults").hide();
	$(".pagination-section").hide();
	$(".result").remove();
});

$("#begin").click(function() {
	offset = 1;
	$("#numberPage").val("1");
	$(".result").remove();
	$(idForm).submit();
});

$("#more").click(function() {
	if (offset == 1) {
		offset = 10;
	} else {
		offset += 10;
	}
	$("#numberPage").val(parseInt($("#numberPage").val()) + 1);
	$(".result").remove();
	$(idForm).submit();
});

$("#less").click(function() {
	offset -= 10;
	if (offset < 1) {
		offset = 1
	}

	$("#numberPage").val(parseInt($("#numberPage").val()) - 1);
	$(".result").remove();
	$(idForm).submit();
});

$("#last").click(function() {
	offset = (totalValues - 10);
	$("#numberPage").val($("#totalNumberPages").text());
	$(".result").remove();
	$(idForm).submit();
});

$(function() {
	$("#skipPagination").submit(
		function() {
			var numberPage = $("#numberPage").val();
			if (numberPage <= 1)
				offset = 1;
			else
				offset = parseInt("" + (numberPage - 1) * 10);
			$(".result").remove();
			$(idForm).submit();
			return false;
		}
	);
});

/**
 * Add function to submit form
 */
$(function() {
	$("#formGeneIdentifier").submit(
		function() {
			$(".errors").remove();
			var pagedResponse = searchGene($(this).serialize(), pageSize, offset).responseJSON;
			totalValues = pagedResponse.total;
			if (!verifyPagedResponse(idForm, "#formGeneIdentifier", totalValues))
				idForm = "#formGeneIdentifier";
			var gene = pagedResponse.response;
			if (gene.length > 0) {
				contentGeneData(gene);
			} else {
				$("#formGeneIdentifier").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
			}
			return false;
		}
	);
});

/**
 * Add function to submit form
 */
$(function() {
	$("#formGeneDescription").submit(
		function() {
			$(".errors").remove();
			var pagedResponse = searchGene($(this).serialize(), pageSize, offset).responseJSON;
			totalValues = pagedResponse.total;
			if (!verifyPagedResponse(idForm, "#formGeneDescription", totalValues))
				idForm = "#formGeneDescription";
			var gene = pagedResponse.response;
			if (gene.length > 0) {
				contentGeneData(gene);
			} else {
				$("#formGeneDescription").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
			}
			return false;
		}
	);
});

/**
 * Add function to submit form
 */
$(function() {
	$("#formAnalysesProteinCodingGenes").submit(
		function() {
			$(".errors").remove();
			var pagedResponse = analysesCDS($(this).serialize(), pageSize, offset).responseJSON;
			var ids = pagedResponse.response;
			totalValues = pagedResponse.total;
			if (!verifyPagedResponse(idForm, "#formAnalysesProteinCodingGenes", totalValues))
				idForm = "#formAnalysesProteinCodingGenes";
			if (ids.length > 0) {
				var featuresIDs = ids.join(" ");
				var data = searchGeneByID(featuresIDs).responseJSON.response;
				if (data.length > 0) {
					contentGeneData(data);
				} else {
					$("#formAnalysesProteinCodingGenes").append("<div class='alert alert-danger errors'>Oops, not found any gene</div>");
				}
			}
			return false;
		}
	);
});

/**
 * Add function to submit form
 */
$(function() {
	$("#trna-form").submit(
		function() {
			$(".errors").remove();
			var pagedResponse = trnaSearch($(this).serialize(), pageSize, offset).responseJSON;
			var tRNAList = pagedResponse.response;
			totalValues = pagedResponse.total;
			if (tRNAList.length > 0) {
				if (!verifyPagedResponse(idForm, "#trna-form", totalValues))
					idForm = "#trna-form";
				var featuresIDs = "";
				for (i = 0; i < tRNAList.length; i++) {
					featuresIDs += tRNAList[i].id + " ";
				}
				var data = searchGeneByID(featuresIDs).responseJSON.response;

				if (data.length > 0) {
					contentGeneData(data);
				} else {
					$("#trna-form").append("<div class='alert alert-danger errors'>Oops, not found any gene</div>");
				}
			} else {
				$("#trna-form").append("<div class='alert alert-danger errors'>Oops, not found any gene</div>");
			}
			return false;
		}
	);
});

$(function() {
	$("#rRNA-form").submit(function() {
		$(".errors").remove();
		var pagedResponse = searchrRNA($(this).serialize(), pageSize, offset).responseJSON;
		var rRNAList = pagedResponse.response;
		totalValues = pagedResponse.total;
		if(rRNAList.length > 0) {
			if (!verifyPagedResponse(idForm, "#rRNA-form", totalValues))
				idForm = "#rRNA-form";
			var featuresIDs = "";
			for (i = 0; i < rRNAList.length; i++) {
				featuresIDs += rRNAList[i] + " ";
			}
			var data = searchGeneByID(featuresIDs).responseJSON.response;
			if (data.length > 0) {
				contentGeneData(data);
			} else {
				$("#rRNA-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
			}
		} else {
			$("#rRNA-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
		}
		
		return false;
	});
});

/**
 * Add function to submit form
 */
$(function() {
	$("#tandemRepeats-form").submit(
		function() {
			$(".errors").remove();
			var pagedResponse = tandemRepeatsSearch($(this).serialize(), pageSize, offset).responseJSON;
			var tandemRepeatsList = pagedResponse.response;
			totalValues = pagedResponse.total;
			if (!verifyPagedResponse(idForm, "#tandemRepeats-form", totalValues))
				idForm = "#tandemRepeats-form";
			if (tandemRepeatsList.length > 0) {
				$("#searchPanel").hide();
				$("#back").show();
				var html = "<table class='table table-striped table-bordered table-hover result'>" +
					"	<thead>" +
					"		<tr>" +
					"			<th>Contig</th>" +
					"			<th>Start coordinate</th>" +
					"			<th>End coordinate</th>" +
					"			<th>Repeat length</th>" +
					"			<th>Copy number</th>" +
					"			<th>Repeat sequence</th>" +
					"		</tr>" +
					"	</thead>" +
					"	<tbody>";
				for (i = 0; i < tandemRepeatsList.length; i++) {
					html += "		<tr>" +
						"			<td><a href='/DownloadFileByContigAndType?contig=" + tandemRepeatsList[i].contig + "&type=trf'>" + tandemRepeatsList[i].contig + "</a></td>" +
						"			<td>" + tandemRepeatsList[i].start + "</td>" +
						"			<td>" + tandemRepeatsList[i].end + "</td>" +
						"			<td>" + tandemRepeatsList[i].length + "</td>" +
						"			<td>" + tandemRepeatsList[i].copy_number + "</td>" +
						"			<td>" + tandemRepeatsList[i].sequence + "</td>" +
						"		</tr>";
				}
				html += "	</tbody>" +
					"</table>";
				$("#searchPanel").parent().append(html);
				$(".pagination-section").show();
			} else {
				$("#tandemRepeats-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
			}
			return false;
		}
	);
});

/**
 * Add function to submit form
 */
$(function() {
	$("#otherNonCodingRNAs-form").submit(
		function() {
			$(".errors").remove();
			var pagedResponse = ncRNASearch($(this).serialize(), pageSize, offset).responseJSON;
			var nonCodingRNAList = pagedResponse.response;
			totalValues = pagedResponse.total;
			if (!verifyPagedResponse(idForm, "#otherNonCodingRNAs-form", totalValues))
				idForm = "#otherNonCodingRNAs-form";
			if (nonCodingRNAList.length > 0) {
				var featuresIDs = "";
				for (i = 0; i < nonCodingRNAList.length; i++) {
					featuresIDs += nonCodingRNAList[i].id + " ";
				}
				var data = searchGeneByID(featuresIDs).responseJSON.response;
				if (data.length > 0) {
					contentGeneData(data);
				} else {
					$("#otherNonCodingRNAs-form").append("<div class='alert alert-danger errors'>Oops, not found any gene</div>");
				}
			} else {
				$("#otherNonCodingRNAs-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
			}
			;
			return false;
		}
	);
});

/**
 * Add function to submit form
 */
$(function() {
	$("#transcriptionalTerminators-form").submit(
		function() {
			$(".errors").remove();
			var pagedResponse = transcriptionalTerminatorSearch($(this).serialize(), pageSize, offset).responseJSON;
			var transcriptionalTerminatorList = pagedResponse.response;
			totalValues = pagedResponse.total;
			if (!verifyPagedResponse(idForm, "#transcriptionalTerminators-form", totalValues))
				idForm = "#transcriptionalTerminators-form";
			if (transcriptionalTerminatorList.length > 0) {
				$("#searchPanel").hide();
				$("#back").show();
				var html = "<table class='table table-striped table-bordered table-hover result'>" +
					"	<thead>" +
					"		<tr>" +
					"			<th>Contig</th>" +
					"			<th>Start coordinate</th>" +
					"			<th>End coordinate</th>" +
					"			<th>Confidence</th>" +
					"			<th>Hairpin score</th>" +
					"			<th>Tail score</th>" +
					"		</tr>" +
					"	</thead>" +
					"	<tbody>";
				for (i = 0; i < transcriptionalTerminatorList.length; i++) {
					html += "		<tr>" +
						"			<td><a href='/DownloadFileByContigAndType?contig=" + transcriptionalTerminatorList[i].contig + "&type=transterm'>" + transcriptionalTerminatorList[i].contig + "</a></td>" +
						"			<td>" + transcriptionalTerminatorList[i].start + "</td>" +
						"			<td>" + transcriptionalTerminatorList[i].end + "</td>" +
						"			<td>" + transcriptionalTerminatorList[i].confidence + "</td>" +
						"			<td>" + transcriptionalTerminatorList[i].hairpin_score + "</td>" +
						"			<td>" + transcriptionalTerminatorList[i].tail_score + "</td>" +
						"		</tr>";
				}
				html += "	</tbody>" +
					"</table>";
				$("#searchPanel").parent().append(html);
				$(".pagination-section").show();
			} else {
				$("#transcriptionalTerminators-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
			}
			return false;
		}
	);
});

/**
 * Add function to submit form
 */
$(function() {
	$("#ribosomalBindingSites-form").submit(
		function() {
			$(".errors").remove();
			var pagedResponse = rbsSearch($(this).serialize(), pageSize, offset).responseJSON;
			var rbsList = pagedResponse.response;
			totalValues = pagedResponse.total;
			if (!verifyPagedResponse(idForm, "#ribosomalBindingSites-form", totalValues))
				idForm = "#ribosomalBindingSites-form";
			if (rbsList.length > 0) {
				$("#searchPanel").hide();
				$("#back").show();
				var html = "<table class='table table-striped table-bordered table-hover result'>" +
					"	<thead>" +
					"		<tr>" +
					"			<th>Contig</th>" +
					"			<th>Start coordinate</th>" +
					"			<th>End coordinate</th>" +
					"			<th>Position shift</th>" +
					"			<th>Site pattern</th>" +
					"			<th>Old start</th>" +
					"			<th>New start</th>" +
					"		</tr>" +
					"	</thead>" +
					"	<tbody>";
				for (i = 0; i < rbsList.length; i++) {
					html += "		<tr>" +
						"			<td><a href='/DownloadFileByContigAndType?contig=" + rbsList[i].contig + "&type=rbsfinder'>" + rbsList[i].contig + "</a></td>" +
						"			<td>" + rbsList[i].start + "</td>" +
						"			<td>" + rbsList[i].end + "</td>" +
						"			<td>" + rbsList[i].position_shift + "</td>" +
						"			<td>" + rbsList[i].site_pattern + "</td>" +
						"			<td>" + rbsList[i].old_start + "</td>" +
						"			<td>" + rbsList[i].new_start + "</td>" +
						"		</tr>";
				}
				html += "	</tbody>" +
					"</table>";
				$("#searchPanel").parent().append(html);
				$(".pagination-section").show();
			} else {
				$("#ribosomalBindingSites-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
			}
			return false;
		}
	);
});

/**
 * Add function to submit form
 */
$(function() {
	$("#horizontalGeneTransfers-form").submit(
		function() {
			$(".errors").remove();
			var pagedResponse = alienhunterSearch($(this).serialize(), pageSize, offset).responseJSON;
			var alienhunterList = pagedResponse.response;
			totalValues = pagedResponse.total;
			if (!verifyPagedResponse(idForm, "#horizontalGeneTransfers-form", totalValues))
				idForm = "#horizontalGeneTransfers-form";
			if (alienhunterList.length > 0) {
				$("#searchPanel").hide();
				$("#back").show();
				var html = "<table class='table table-striped table-bordered table-hover result'>" +
					"	<thead>" +
					"		<tr>" +
					"			<th>ID</th>" +
					"			<th>Contig</th>" +
					"			<th>Start coordinate</th>" +
					"			<th>End coordinate</th>" +
					"			<th>Score</th>" +
					"			<th>Length</th>" +
					"			<th>Threshold</th>" +
					"		</tr>" +
					"	</thead>" +
					"	<tbody>";
				for (var i = 0; i < alienhunterList.length; i++) {
					html += "		<tr>" +
						"			<td><a id='horizontal-transference-" + alienhunterList[i].id + "' href='#'>" + alienhunterList[i].id + "</a></td>" +
						"			<td><a href='/DownloadFileByContigAndType?contig=" + alienhunterList[i].contig + "&type=alienhunter'>" + alienhunterList[i].contig + "</a></td>" +
						"			<td>" + alienhunterList[i].start + "</td>" +
						"			<td>" + alienhunterList[i].end + "</td>" +
						"			<td>" + alienhunterList[i].score + "</td>" +
						"			<td>" + alienhunterList[i].length + "</td>" +
						"			<td>" + alienhunterList[i].threshold + "</td>" +
						"		</tr>";
				}
				html += "	</tbody>" +
					"</table>";
				$("#searchPanel").parent().append(html);
				$(".pagination-section").show();
				for (var i = 0; i < alienhunterList.length; i++) {
					var result = alienhunterList[i];
					$("#horizontal-transference-" + result.id).click(function() {
						$(".result").remove();
						$(".errors").remove();
						var pagedResponse = getGeneByPosition(result.start, result.end, 10, 1).responseJSON;
						var alienhunterList = pagedResponse.response;
						totalValues = pagedResponse.total;
						if(alienhunterList.length > 0) {
							if (!verifyPagedResponse(idForm, "#horizontal", totalValues))
								idForm = "#horizontal";
							contentGeneData(alienhunterList);
						} else {
							$("#horizontalGeneTransfers-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
						}
					});
				}
			} else {
				$("#horizontalGeneTransfers-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
			}

			return false;
		}
	);
});

/**
 * Method used to deal with content of gene
 * 
 * @param data
 * @returns
 */
function contentGeneData(data) {
	for (var i = 0; i < data.length; i++) {
		var feature = data[i];
		var htmlContent = getHTMLContent("website/search-database/gene.tt").responseJSON.response;
		htmlContent = htmlContent.replace(/(\[\% result.feature_id \%\])+/gim, feature.feature_id);
		htmlContent = htmlContent.replace(/(\[\% result.name \%\])/gim, feature.name);
		htmlContent = htmlContent.replace(/(\[\% result.uniquename \%\])/gim, feature.uniquename);
		$("#searchPanel").hide();
		$("#back").show();
		$(".pagination-section").show();
		$("#searchPanel").parent().append(htmlContent);

		$("#result-panel-title-" + feature.feature_id).on("click", function() {
			var href = $(this).attr('href');
			var name = $(this).text().substring(0, $(this).text().indexOf("-") - 1);
			var product = $(this).text().substring($(this).text().indexOf("-") + 1, $(this).text().length);
			var data = getGeneBasics(href.replace("#", "")).responseJSON.response;

			dealDataResults(href, name, data, product);

			return false;
		});
	}
}

/**
 * Method used to deal with data results and standard visualization, need to
 * modularize
 * 
 * @param href
 *            panel of results
 * @param featureName
 * @param data
 * @returns
 */
function dealDataResults(href, featureName, data, product) {
	if ($(href).is(":hidden")) {
		data = data[0];
		var htmlContent = getHTMLContent("website/search-database/geneBasics.tt").responseJSON.response;
		htmlContent = htmlContent.replace("[% result.type %]", data.type);
		if (data.type != "CDS") {
			htmlContent = htmlContent.replace("[% result.uniquename %]", "<a href='/DownloadFileByContigAndType?contig=" + data.uniquename + "&type=" + data.type.replace("_scan", "").toLowerCase() + "'>" + data.uniquename + "</a>");
		} else {
			htmlContent = htmlContent.replace("[% result.uniquename %]", data.uniquename);
		}
		htmlContent = htmlContent.replace("[% result.fstart %]", data.fstart);
		htmlContent = htmlContent.replace("[% result.fend %]", data.fend);
		htmlContent = htmlContent.replace("[% result.length %]", (data.fend - data.fstart + 1));
		var type = data.type;
		var name = data.uniquename;
		var subsequence = getSubsequence(type, featureName, name, data.fstart, data.fend).responseJSON.response;
		var htmlSequence = getHTMLContent("website/search-database/sequence.tt").responseJSON.response;
		htmlSequence = htmlSequence.replace("[% result.feature_id %]", href.replace("#", ""));
		htmlSequence = htmlSequence.replace("[% result.feature_id %]", href.replace("#", ""));
		htmlSequence = htmlSequence.replace("[% result.sequence %]", subsequence.sequence);
		if (type == "CDS") {
			htmlContent += htmlSequence;
			var subevidences = getSubEvidences(href.replace("#", "")).responseJSON.response;

			var components = new Object();
			var componentsEvidences = new Array();
			var counterComponentsEvidences = 0;
			for (i = 0; i < subevidences.length; i++) {
				var componentName = subevidences[i].program.replace(".pl", "");

				if ($.inArray(componentName, componentsEvidences) == -1) {
					var htmlEvidence = getHTMLContent("website/search-database/evidences.tt").responseJSON.response;
					htmlEvidence = htmlEvidence.replace("[% result.componentName %]", componentName);
					htmlEvidence = htmlEvidence.replace("[% result.id %]", href.replace("#", ""));
					if (subevidences[i].type == 'intervals') {
						htmlEvidence = htmlEvidence.replace("[% result.descriptionComponent %]", "<div class='row'><div class='col-md-11'><a style='color: inherit;' id='anchor-evidence-" + componentName + "-" + href.replace("#", "") + "' data-toggle='collapse' data-parent='#accordion' href='#evidence-" + componentName + "-" + href.replace("#", "") + "'>" + subevidences[i].program_description + "</a></div><div class='col-md-1'><a href='/ViewResultByComponentID?id=" + subevidences[i].id + "'>View</a></div></div>");
					} else {
						htmlEvidence = htmlEvidence.replace("[% result.descriptionComponent %]", "<a id='anchor-evidence-" + componentName + "-" + href.replace("#", "") + "' data-toggle='collapse' data-parent='#accordion' href='#evidence-" + componentName + "-" + href.replace("#", "") + "'>" + subevidences[i].program_description + "</a>");
					}
					htmlContent += htmlEvidence;
					componentsEvidences[counterComponentsEvidences] = componentName;
					counterComponentsEvidences++;
				}

				if (typeof components[componentName] == 'undefined') {
					components[componentName] = new Array();
				}
				var arrayEvidences = components[componentName];
				arrayEvidences[components[componentName].length] = {
					"id" : subevidences[i].id,
					"type" : subevidences[i].type
				};
				components[componentName] = arrayEvidences;
			}

			addPanelResult(href, htmlContent);

			for (var component in components) {
				console.log(component);
				$("#anchor-evidence-" + component + "-" + href.replace("#", "")).click(function clickEvidences() {
					var componentTemp = this.id.replace("anchor-evidence-", "");
					componentTemp = componentTemp.replace("-" + href.replace("#", ""), "");
					console.log(componentTemp);
					if ($("#evidence-" + componentTemp + "-" + href.replace("#", "")).is(":hidden")) {
						$("#evidence-" + componentTemp + "-" + href.replace("#", "")).empty();
						for (i = 0; i < components[componentTemp].length; i++) {
							var response = undefined;
							if (componentTemp != "annotation_phobius" && componentTemp != "annotation_tmhmm" && componentTemp != 'annotation_orthology' && componentTemp != 'annotation_pathways'
								&& componentTemp != 'annotation_interpro' && componentTemp != 'annotation_predgpi' && componentTemp != 'annotation_dgpi' && componentTemp != "annotation_tcdb" && componentTemp != "annotation_signalP") {
								response = getSimilarityEvidenceProperties(components[componentTemp][i].id, componentTemp).responseJSON.response;
								var htmlSubevidence = getHTMLContent("website/search-database/subEvidences.tt").responseJSON.response;
								htmlSubevidence = htmlSubevidence.replace("[% result.feature_id %]", components[componentTemp][i].id);
								htmlSubevidence = htmlSubevidence.replace("[% result.feature_id %]", "<div class='row'><div class='col-md-11'>" + response.identifier + " - " + response.description + "</div><div class='col-md-1'><a href='/ViewResultByComponentID?id=" + components[componentTemp][i].id + "'>View</a></div></div>");

								htmlSubevidence = htmlSubevidence.replace("[% result.feature_id %]", components[componentTemp][i].id);
								addPanelResult("#evidence-" + componentTemp + "-" + href.replace("#", ""), htmlSubevidence);
							}
							if (components[componentTemp][i].type == "similarity") {
								var html = "";
								//								if(componentTemp == "annotation_blast" || componentTemp == "annotation_rpsblast") {
								html = getHTMLContent("website/search-database/similarityBasicResult.tt").responseJSON.response;
								if (componentTemp == "annotation_blast") {
									html = html.replace("[% result.identifier %]", "<a href='http://www.ncbi.nlm.nih.gov/protein/" + response.identifier + "' >" + response.identifier + "</a>");
								} else if (componentTemp == "annotation_rpsblast") {
									html = html.replace("[% result.identifier %]", "<a href='http://www.ncbi.nlm.nih.gov/Structure/cdd/cddsrv.cgi?uid=" + response.identifier + "' >" + response.identifier + "</a>");
								} else if (componentTemp == "annotation_hmmer") {
									html = html.replace("[% result.identifier %]", response.identifier);
								}
								html = html.replace("[% result.description %]", response.description);
								html = html.replace("[% result.evalue %]", response.evalue);
								html = html.replace("[% result.percent_id %]", response.percent_id);
								html = html.replace("[% result.similarity %]", response.similarity);
								html = html.replace("[% result.score %]", response.score);
								html = html.replace("[% result.block_size %]", response.block_size);
								//								} 
								addPanelResult("#subevidence-" + response.id, html);
								console.log(response);

							} else if (components[componentTemp][i].type == "intervals") {
								var responseIntervals = getIntervalEvidenceProperties(components[componentTemp][i].id, componentTemp).responseJSON.response;
								var listHTMLs = new Array();
								var counterHTMLs = 0;
								var idTable = "";
								var architecture = "";
								var counterTMHMM = 0;
								if ($("#counterTMHMM").val() >= components[componentTemp].length) {
									counterTMHMM = 0;
								} else if ($("#counterTMHMM").val() != undefined) {
									counterTMHMM = $("#counterTMHMM").val();
								}

								if ($("#architecture-tmhmm").text() == "" ||
									$("#architecture-tmhmm").text() == undefined ||
									$("#counterTMHMM").val() >= components[componentTemp].length) {
									architecture = "";
								} else {
									architecture = $("#architecture-tmhmm").text() + "-";
								}

								if (componentTemp == 'annotation_interpro') {
									for (var j = 0; j < responseIntervals.properties.length; j++) {
										$("#evidence-" + componentTemp + "-" + href.replace("#", "")).empty();
										html = getHTMLContent("website/search-database/interproBasicResult.tt").responseJSON.response;
										html = html.replace("[% result.componentName %]", componentTemp);
										html = html.replace("[% result.componentName %]", componentTemp);
										html = html.replace("[% result.feature_id %]", href.replace("#", ""));
										html = html.replace("[% result.feature_id %]", href.replace("#", ""));
										html = html.replace("[% result.counter %]", counterHTMLs);
										html = html.replace("[% result.counter %]", responseIntervals.properties[j].interpro_id + ' - ' + responseIntervals.properties[j].description_interpro);
										html = html.replace("[% result.counter %]", counterHTMLs);
										html = html.replace("[% result.interpro_id %]", responseIntervals.properties[j].interpro_id);
										html = html.replace("[% result.interpro_id %]", responseIntervals.properties[j].interpro_id);
										html = html.replace("[% result.interpro_id %]", responseIntervals.properties[j].interpro_id);
										html = html.replace("[% result.description_interpro %]", responseIntervals.properties[j].description_interpro);
										html = html.replace("[% result.description_interpro %]", responseIntervals.properties[j].description_interpro);
										html = html.replace("[% result.DB_id %]", responseIntervals.properties[j].DB_id);
										html = html.replace("[% result.DB_id %]", responseIntervals.properties[j].DB_id);
										html = html.replace("[% result.DB_name %]", responseIntervals.properties[j].DB_name);
										html = html.replace("[% result.description %]", responseIntervals.properties[j].description);
										html = html.replace("[% result.evidence_process %]", responseIntervals.properties[j].evidence_process);
										html = html.replace("[% result.evidence_function %]", responseIntervals.properties[j].evidence_function);
										html = html.replace("[% result.evidence_component %]", responseIntervals.properties[j].evidence_component);
										html = html.replace("[% result.score %]", responseIntervals.properties[j].score);
										listHTMLs[counterHTMLs] = html;
										counterHTMLs++;
									}
									idTable = "#evidence-" + componentTemp + "-" + href.replace("#", "");
								} else if (componentTemp == 'annotation_tmhmm') {
									idTable = "#evidence-" + componentTemp + "-" + href.replace("#", "");
									for (var j = 0; j < responseIntervals.properties.length; j++) {
										$("#evidence-" + componentTemp + "-" + href.replace("#", "")).empty();
										$(".architecture-tmhmm").remove();
										counterTMHMM++;
										if (responseIntervals.properties[j].direction == "inside") {
											architecture += "I";
										} else if (responseIntervals.properties[j].direction == "outside") {
											architecture += "O";
										} else if (responseIntervals.properties[j].direction == "TMhelix") {
											architecture += "T";
										}
										listHTMLs[counterHTMLs] = "<div class='row architecture-tmhmm'><div class='col-md-3'><p>Predicted TMHs</p></div><div class='col-md-9'>" + responseIntervals.properties[j].predicted_TMHs + "</div></div>";
										counterHTMLs++;
										listHTMLs[counterHTMLs] = "<div class='row architecture-tmhmm'><div class='col-md-3'><p>Architecture:</p></div><div class='col-md-9'><p id='architecture-tmhmm'>" + architecture + "</p></div></div>";
										counterHTMLs++;
										listHTMLs[counterHTMLs] = "<div class='row architecture-tmhmm'><div class='col-md-12'><div class='alert alert-info'><p>Architecture legend: O, outside the cytoplasm; T, transmembrane domain; I, inside the cytoplasm</p></div></div></div>";
										counterHTMLs++;
										listHTMLs[counterHTMLs] = "<input type='hidden' class='architecture-tmhmm' id='counterTMHMM' value='" + counterTMHMM + "' \>";
										counterHTMLs++;
									}
								} else if (componentTemp == 'annotation_tcdb') {
									for (var j = 0; j < responseIntervals.properties.length; j++) {
										$("#evidence-" + componentTemp + "-" + href.replace("#", "")).empty();
										html = getHTMLContent("website/search-database/tcdbBasicResult.tt").responseJSON.response;
										html = html.replace("[% result.componentName %]", componentTemp);
										html = html.replace("[% result.componentName %]", componentTemp);
										html = html.replace("[% result.feature_id %]", href.replace("#", ""));
										html = html.replace("[% result.feature_id %]", href.replace("#", ""));
										html = html.replace("[% result.counter %]", counterHTMLs);
										html = html.replace("[% result.counter %]", responseIntervals.properties[j].hit_description);
										html = html.replace("[% result.counter %]", counterHTMLs);
										html = html.replace("[% result.TCDB_ID %]", responseIntervals.properties[j].TCDB_ID);
										html = html.replace("[% result.TCDB_ID %]", responseIntervals.properties[j].TCDB_ID);
										html = html.replace("[% result.hit_description %]", responseIntervals.properties[j].hit_description);
										html = html.replace("[% result.TCDB_class %]", responseIntervals.properties[j].TCDB_class);
										html = html.replace("[% result.TCDB_subclass %]", responseIntervals.properties[j].TCDB_subclass);
										html = html.replace("[% result.TCDB_family %]", responseIntervals.properties[j].TCDB_family);
										html = html.replace("[% result.hit_name %]", responseIntervals.properties[j].hit_name);
										html = html.replace("[% result.hit_name %]", responseIntervals.properties[j].hit_name);
										html = html.replace("[% result.evalue %]", responseIntervals.properties[j].evalue);
										html = html.replace("[% result.percent_id %]", responseIntervals.properties[j].percent_id);
										html = html.replace("[% result.similarity %]", responseIntervals.properties[j].similarity);
										listHTMLs[counterHTMLs] = html;
										counterHTMLs++;
									}
									idTable = "#evidence-" + componentTemp + "-" + href.replace("#", "");
								} else if (componentTemp == 'annotation_pathways') {
									for (var j = 0; j < responseIntervals.properties.length; j++) {
										$("#evidence-" + componentTemp + "-" + href.replace("#", "")).empty();
										html = getHTMLContent("website/search-database/pathwaysBasicResult.tt").responseJSON.response;
										html = html.replace("[% result.orthologous_group_id %]", responseIntervals.properties[j].orthologous_group_id);
										html = html.replace("[% result.orthologous_group_id %]", responseIntervals.properties[j].orthologous_group_id);
										html = html.replace("[% result.orthologous_group_id %]", responseIntervals.properties[j].orthologous_group_id);
										html = html.replace("[% result.orthologous_group_description %]", responseIntervals.properties[j].orthologous_group_description);
										addPanelResult("#evidence-" + componentTemp + "-" + href.replace("#", ""), html);
										for (var pathway in responseIntervals.pathways) {
											var htmlPathway = getHTMLContent("website/search-database/pathways.tt").responseJSON.response;
											htmlPathway = htmlPathway.replace("[% result.metabolic_pathway_id %]", responseIntervals.pathways[pathway].id);
											htmlPathway = htmlPathway.replace("[% result.metabolic_pathway_id %]", responseIntervals.pathways[pathway].id);
											htmlPathway = htmlPathway.replace("[% result.metabolic_pathway_description %]", responseIntervals.pathways[pathway].description);
											listHTMLs[counterHTMLs] = htmlPathway;
											counterHTMLs++;
										}
										idTable = "#pathways-" + responseIntervals.properties[j].orthologous_group_id;
									}
								} else if (componentTemp == 'annotation_orthology') {
									for (var j = 0; j < responseIntervals.properties.length; j++) {
										$("#evidence-" + componentTemp + "-" + href.replace("#", "")).empty();
										html = getHTMLContent("website/search-database/orthologyBasicResult.tt").responseJSON.response;
										html = html.replace("[% result.orthologous_hit %]", responseIntervals.properties[j].orthologous_hit);
										html = html.replace("[% result.id %]", responseIntervals.id);
										addPanelResult("#evidence-" + componentTemp + "-" + href.replace("#", ""), html);
										for (var orthology in responseIntervals.orthologous_groups) {
											var htmlOrthology = getHTMLContent("website/search-database/orthologies.tt").responseJSON.response;
											htmlOrthology = htmlOrthology.replace("[% result.orthologous_group %]", responseIntervals.orthologous_groups[orthology].group);
											htmlOrthology = htmlOrthology.replace("[% result.orthologous_group %]", responseIntervals.orthologous_groups[orthology].group);
											htmlOrthology = htmlOrthology.replace("[% result.orthologous_group_description %]", responseIntervals.orthologous_groups[orthology].description);
											listHTMLs[counterHTMLs] = htmlOrthology;
											counterHTMLs++;
										}
										idTable = "#orthology-" + responseIntervals.id;
									}
								} else if (componentTemp == 'annotation_predgpi') {
									$("#evidence-" + componentTemp + "-" + href.replace("#", "")).empty();
									if (responseIntervals.properties.length > 1) {
										for (var j = 0; j < responseIntervals.properties.length; j++) {
											html = getHTMLContent("/website/search-database/predgpiBasicResult.tt").responseJSON.response;
											html = html.replace("[% result.componentName %]", componentTemp);
											html = html.replace("[% result.componentName %]", componentTemp);
											html = html.replace("[% result.feature_id %]", href.replace("#", ""));
											html = html.replace("[% result.feature_id %]", href.replace("#", ""));
											html = html.replace("[% result.counter %]", counterHTMLs);
											html = html.replace("[% result.counter %]", responseIntervals.properties[j].name);
											html = html.replace("[% result.counter %]", counterHTMLs);
											html = html.replace("[% result.name %]", responseIntervals.properties[j].name);
											html = html.replace("[% result.position %]", responseIntervals.properties[j].position);
											html = html.replace("[% result.specificity %]", responseIntervals.properties[j].specificity);
											html = html.replace("[% result.sequence %]", responseIntervals.properties[j].sequence);
											html = html.replace("[% result.start %]", responseIntervals.properties[j].start);
											html = html.replace("[% result.end %]", responseIntervals.properties[j].end);
											html = html.replace("[% result.strand %]", responseIntervals.properties[j].strand);
											listHTMLs[counterHTMLs] = html;
											counterHTMLs++;
										}
										idTable = "#evidence-" + componentTemp + "-" + href.replace("#", "");
									} else {
										html = getHTMLContent("/website/search-database/dgpiNoResult.tt").responseJSON.response;
										html = html.replace("[% result.result %]", responseIntervals.properties[0].result);
										addPanelResult("#evidence-" + componentTemp + "-" + href.replace("#", ""), html);
									}
								} else if (componentTemp == 'annotation_dgpi') {
									$("#evidence-" + componentTemp + "-" + href.replace("#", "")).empty();
									if (responseIntervals.properties.length > 0) {
										for (var j = 0; j < responseIntervals.properties.length; j++) {
											html = getHTMLContent("/website/search-database/dgpiBasicResult.tt").responseJSON.response;
											html = html.replace("[% result.componentName %]", componentTemp);
											html = html.replace("[% result.componentName %]", componentTemp);
											html = html.replace("[% result.feature_id %]", href.replace("#", ""));
											html = html.replace("[% result.feature_id %]", href.replace("#", ""));
											html = html.replace("[% result.counter %]", counterHTMLs);
											html = html.replace("[% result.counter %]", counterHTMLs);
											html = html.replace("[% result.counter %]", counterHTMLs);
											html = html.replace("[% result.cleavage_site %]", responseIntervals.properties[j].cleavage_site);
											html = html.replace("[% result.score %]", responseIntervals.properties[j].score);
											html = html.replace("[% result.start %]", responseIntervals.properties[j].start);
											html = html.replace("[% result.end %]", responseIntervals.properties[j].end);
											html = html.replace("[% result.strand %]", responseIntervals.properties[j].strand);
											listHTMLs[counterHTMLs] = html;
											counterHTMLs++;
										}
										idTable = "#evidence-" + componentTemp + "-" + href.replace("#", "");
									} else {
										html = getHTMLContent("/website/search-database/dgpiNoResult.tt").responseJSON.response;
										html = html.replace("[% result.result %]", responseIntervals.properties[0].result);
										addPanelResult("#evidence-" + componentTemp + "-" + href.replace("#", ""), html);
									}
								} else if (componentTemp == 'annotation_bigpi') {
									$("#evidence-" + componentTemp + "-" + href.replace("#", "")).empty();
									if (responseIntervals.properties.length > 0) {
										for (var j = 0; j < responseIntervals.properties.length; j++) {
											html = getHTMLContent("/website/search-database/bigpiBasicResult.tt").responseJSON.response;
											html = html.replace("[% result.componentName %]", componentTemp);
											html = html.replace("[% result.componentName %]", componentTemp);
											html = html.replace("[% result.feature_id %]", href.replace("#", ""));
											html = html.replace("[% result.feature_id %]", href.replace("#", ""));
											html = html.replace("[% result.counter %]", counterHTMLs);
											html = html.replace("[% result.counter %]", responseIntervals.properties[j].pvalue);
											html = html.replace("[% result.counter %]", counterHTMLs);
											html = html.replace("[% result.pvalue %]", responseIntervals.properties[j].pvalue);
											html = html.replace("[% result.position %]", responseIntervals.properties[j].position);
											html = html.replace("[% result.start %]", responseIntervals.properties[j].start);
											html = html.replace("[% result.end %]", responseIntervals.properties[j].end);
											html = html.replace("[% result.strand %]", responseIntervals.properties[j].strand);
											listHTMLs[counterHTMLs] = html;
											counterHTMLs++;
										}
										idTable = "#evidence-" + componentTemp + "-" + href.replace("#", "");
									} else {
										html = getHTMLContent("/website/search-database/dgpiNoResult.tt").responseJSON.response;
										html = html.replace("[% result.result %]", responseIntervals.properties[0].result);
										addPanelResult("#evidence-" + componentTemp + "-" + href.replace("#", ""), html);
									}
								} else if (componentTemp == 'annotation_signalP') {
									for (var j = 0; j < responseIntervals.properties.length; j++) {
										$("#evidence-" + componentTemp + "-" + href.replace("#", "")).empty();
										html = getHTMLContent("/website/search-database/signalPBasicResult.tt").responseJSON.response;
										html = html.replace("[% result.start_residue %]", responseIntervals.properties[j].start_residue);
										html = html.replace("[% result.end_residue %]", responseIntervals.properties[j].end_residue);
										html = html.replace("[% result.pep_sig %]", responseIntervals.properties[j].pep_sig);
										html = html.replace("[% result.cutoff %]", responseIntervals.properties[j].cutoff);
										html = html.replace("[% result.score %]", responseIntervals.properties[j].score);
										addPanelResult("#evidence-" + componentTemp + "-" + href.replace("#", ""), html);
									}
								} else if (componentTemp == 'annotation_phobius') {
									$("#evidence-" + componentTemp + "-" + href.replace("#", "")).empty();
									$(".architecture-phobius").remove();
									var signal = false;
									var cleavage = "";
									architecture = "";
									var TMs = 0;
									for (var j = 0; j < responseIntervals.properties.length; j++) {
										if (responseIntervals.properties[j].classification == 'SIGNAL') {
											signal = true;
										}
										if (responseIntervals.properties[j].hasOwnProperty("cleavage_position1")) {
											cleavage += responseIntervals.properties[j].cleavage_position1;
										}
										if (responseIntervals.properties[j].hasOwnProperty("cleavage_position2")) {
											cleavage += " - " + responseIntervals.properties[j].cleavage_position2;
										}
										if (responseIntervals.properties[j].hasOwnProperty("predicted_TMHs")) {
											TMs = responseIntervals.properties[j].predicted_TMHs;
										}
										if (responseIntervals.properties[j].hasOwnProperty("region")) {
											if (responseIntervals.properties[j].region == "NON CYTOPLASMIC") {
												architecture += "O";
											} else if (responseIntervals.properties[j].region == "TRANSMEM") {
												architecture += "T";
											} else if (responseIntervals.properties[j].region == "CYTOPLASMIC") {
												architecture += "I";
											}
											if (!(j == responseIntervals.properties.length - 1)) {
												architecture += "-";
											}
										}
									}
									if (signal) {
										listHTMLs[counterHTMLs] = "<div class='row architecture-phobius'><div class='col-md-3'><p>Signal peptide:</p></div><div class='col-md-9'><p>Yes</p></div></div>";
										counterHTMLs++;
									}
									if (cleavage != "") {
										listHTMLs[counterHTMLs] = "<div class='row architecture-phobius'><div class='col-md-3'><p>Cleavage positions:</p></div><div class='col-md-9'><p>" + cleavage + "</p></div></div>";
										counterHTMLs++;
									}
									if (TMs != 0) {
										listHTMLs[counterHTMLs] = "<div class='row architecture-phobius'><div class='col-md-3'><p>Transmembrane domains:</p></div><div class='col-md-9'><p>" + TMs + "</p></div></div>";
										counterHTMLs++;
									}
									if (architecture != "") {
										listHTMLs[counterHTMLs] = "<div class='row architecture-phobius'><div class='col-md-3'><p>Architecture:</p></div><div class='col-md-9'><p>" + architecture + "</p></div></div>";
										counterHTMLs++;
										listHTMLs[counterHTMLs] = "<div class='row architecture-phobius'><div class='col-md-12'><div class='alert alert-info'><p>Architecture legend: O, outside the cytoplasm; T, transmembrane domain; I, inside the cytoplasm</p></div></div></div>";
										counterHTMLs++;
									}
									idTable = "#evidence-" + componentTemp + "-" + href.replace("#", "");
								}
								// addPanelResult("#subevidence-"+data.id, html);
								for (var index in listHTMLs) {
									addPanelResult(idTable, listHTMLs[index]);
								}
								console.log(responseIntervals);
							}
						}
					}
				});
			}
		}

		if (data.type == "tRNAscan") {
			var data = getIntervalEvidenceProperties(href.replace("#", ""), data.type).responseJSON.response;
			var htmlBasic = getHTMLContent("website/search-database/tRNABasicResult.tt").responseJSON.response;
			htmlBasic = htmlBasic.replace("[% result.type %]", product);
			htmlBasic = htmlBasic.replace("[% result.aminoacid %]", data.properties[0].aminoacid);
			htmlBasic = htmlBasic.replace("[% result.anticodon %]", data.properties[0].anticodon);
			htmlBasic = htmlBasic.replace("[% result.codon %]", data.properties[0].codon);
			htmlBasic = htmlBasic.replace("[% result.score %]", data.properties[0].score);
			htmlBasic = htmlBasic.replace("[% result.pseudogene %]", data.properties[0].pseudogene);
			htmlContent += htmlBasic;
			if (data.properties[0].hasOwnProperty("intron")) {
				if (data.properties[0].intron == "yes") {
					htmlBasic = getHTMLContent("website/search-database/tRNABasicResultHasIntron.tt").responseJSON.response;
					htmlBasic = htmlBasic.replace("[% result.intron %]", data.properties[0].intron);
					htmlBasic = htmlBasic.replace("[% result.coordinatesGene %]", data.properties[0].coordinatesGene);
					htmlBasic = htmlBasic.replace("[% result.coordinatesGenome %]", data.properties[0].coordinatesGenome);
					htmlContent += htmlBasic;
				}
			}
			htmlContent += htmlSequence;
			addPanelResult(href, htmlContent);


		} else if (data.type == "RNA_scan") {
			var data = getIntervalEvidenceProperties(href.replace("#", ""), data.type).responseJSON.response;
			htmlBasic = getHTMLContent("website/search-database/rnaScanBasicResult.tt").responseJSON.response;
			htmlBasic = htmlBasic.replace("[% result.target_description %]", data.properties[0].target_description);
			htmlBasic = htmlBasic.replace("[% result.score %]", data.properties[0].score);
			htmlBasic = htmlBasic.replace("[% result.evalue %]", data.properties[0].evalue);
			htmlBasic = htmlBasic.replace("[% result.target_identifier %]", data.properties[0].target_identifier);
			htmlBasic = htmlBasic.replace("[% result.target_name %]", data.properties[0].target_name);
			htmlBasic = htmlBasic.replace("[% result.target_type %]", data.properties[0].target_type);
			htmlBasic = htmlBasic.replace("[% result.bias %]", data.properties[0].bias);
			htmlBasic = htmlBasic.replace("[% result.truncated %]", data.properties[0].truncated);
			htmlContent += htmlBasic;
			htmlContent += htmlSequence;
			addPanelResult(href, htmlContent);
		} else if (data.type == "rRNA_prediction") {
			var data = getIntervalEvidenceProperties(href.replace("#", ""), data.type).responseJSON.response;
			var htmlBasic = getHTMLContent("website/search-database/rRNAPredictionBasicResult.tt").responseJSON.response;
			htmlBasic = htmlBasic.replace("[% result.molecule_type %]", data.properties[0].molecule_type);
			htmlBasic = htmlBasic.replace("[% result.score %]", data.properties[0].score);
			htmlContent += htmlBasic;
			htmlContent += htmlSequence;
			addPanelResult(href, htmlContent);
		}
	} else {
		$(href).removeClass("collapsed");
		$(href).addClass("collapse");
		$(href + " .row").remove();
		$(href + " .sequences").remove();
		$(href + " .panel").remove();
		$(href).hide();
	}
}

/**
 * Method used to add a panel of results in default panel
 * 
 * @param href
 *            of the panel
 * @param htmlContent
 *            to be added
 * @returns
 */
function addPanelResult(href, htmlContent) {
	$(href).append(htmlContent);
	$(href).removeClass("collapse");
	$(href).addClass("collapsed");
	$(href).show();
}

/**
 * Method used to change view and show data from the contig search
 */
$(function() {
	$("#formSearchContig").submit(
		function() {
			$(".errors").remove();
			var data = searchContig($(this).serialize()).responseJSON.response;
			var htmlContent = getHTMLContent("website/search-database/contigs.tt").responseJSON.response;
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
			return false;
		}
	);
});