/**
 * File with actions of the website
 * @author Wendel Hime Lino Castro
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

/**
 * Add function to submit form
 */
$(function() {
	$("#formGeneIdentifier").submit(
		function() {
			$(".errors").remove();
			$.getJSON($(this).attr('action'), $(this).serialize())
			.done(
				function(data) {
					if(data.response.length > 0) {
						contentGeneData(data.response);
					} else {
						$("#formGeneIdentifier").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
						status = "404";
					}
				}
			)
			.fail(
				function(jqxhr, textStatus, error) {
					if(error.indexOf("Internal Server Error") !== -1) {
						status = "Internal Server Error"
					} else if(error.indexOf("Not Found") !== -1) {
						status = "200";
						var err = textStatus + ", " + error;
						$("#formGeneIdentifier").append("<div class='alert alert-danger errors'>Oops, there is a error on the research: "+ err + "</div>");
					}
				}
			);			
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
			$.getJSON($(this).attr('action'), $(this).serialize())
			.done(
				function(data) {
					if(data.response.length > 0) {
						contentGeneData(data.response);
					} else {
						$("#formGeneDescription").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
					}
				}
			)
			.fail(
				function(jqxhr, textStatus, error) {
					if(error.indexOf("Internal Server Error") !== -1) {
						status = "Internal Server Error"
					} else if(error.indexOf("Not Found") !== -1) {
						status = "200";
						var err = textStatus + ", " + error;
						$("#formGeneDescription").append("<div class='alert alert-danger errors'>Oops, there is a error on the research: "+ err + "</div>");
					}
				}
			);
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
			$.getJSON($(this).attr('action'), $(this).serialize())
			.done(
				function(data) {
					if(data.response.length > 0) {
						var featuresIDs = data.response.join(" ");
						var data = searchGene("", "", "", "", featuresIDs).responseJSON.response;
						if(data.length > 0) {
							contentGeneData(data);
						}
						else {
							$("#formAnalysesProteinCodingGenes").append("<div class='alert alert-danger errors'>Oops, not found any gene</div>");
						}
					}
					else {
						$("#formAnalysesProteinCodingGenes").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
					}
				}
			)
			.fail(
				function(jqxhr, textStatus, error) {
					var err = textStatus + ", " + error;
					console.log(err);
				}
			);
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
			$.getJSON($(this).attr('action'), $(this).serialize())
			.done(
				function(data) {
					if(data.response.length > 0) {
						var featuresIDs = "";
						for(i = 0; i < data.response.length; i++) {
							featuresIDs += data.response[i].id+" ";
						}
						var data = searchGene("", "", "", "", featuresIDs).responseJSON.response;
							
						if(data.length > 0) {
							contentGeneData(data);
						}
						else {
							$("#formAnalysesProteinCodingGenes").append("<div class='alert alert-danger errors'>Oops, not found any gene</div>");
						}	
					}
					else {
						$("#trna-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
					}
				}
			)
			.fail(
				function(jqxhr, textStatus, erro) {
					var err = textStatus + ", " + error;
					console.log(err);
				}
			);
			return false;
		}
	);
});

/**
 * Add function to submit form
 */
$(function() {
	$("#tandemRepeats-form").submit(
		function() {
			$(".errors").remove();
			$.getJSON($(this).attr('action'), $(this).serialize())
			.done(
				function(data) {
					if(data.response.length > 0) {
						$("#searchPanel").hide();
						$("#back").show();
						var html = "<table class='table table-striped table-bordered table-hover result'>" +
									"	<thead>" +
									"		<tr>"+
									"			<th>Contig</th>"+
									"			<th>Start coordinate</th>"+
									"			<th>End coordinate</th>"+
									"			<th>Repeat length</th>"+
									"			<th>Copy number</th>"+
									"			<th>Repeat sequence</th>"+
									"		</tr>" +
									"	</thead>" +
									"	<tbody>";
						for(i = 0; i < data.response.length; i++) {
							html += "		<tr>" +
									"			<td>"+data.response[i].contig+"</td>" +
									"			<td>"+data.response[i].start+"</td>" +
									"			<td>"+data.response[i].end+"</td>" +
									"			<td>"+data.response[i].length+"</td>" +
									"			<td>"+data.response[i].copy_number+"</td>" +
									"			<td>"+data.response[i].sequence+"</td>" +
									"		</tr>";
						}
						html += "	</tbody>" +
								"</table>";
						$("#searchPanel").parent().append(html);
					}
					else {
						$("#tandemRepeats-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
					}
				}
			)
			.fail(
				function(jqxhr, textStatus, error) {
					var err = textStatus + ", " + error;
					console.log(err);
				}
			);
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
			$.getJSON($(this).attr('action'), $(this).serialize())
			.done(
				function(data) {
					if(data.response.length > 0) {
						var featuresIDs = "";
						for(i = 0; i < data.response.length; i++) {
							featuresIDs += data.response[i].id+" ";
						}
						var data = searchGene("", "", "", "", featuresIDs).responseJSON.response;
						if(data.length > 0) {
							contentGeneData(data);
						}
						else {
							$("#otherNonCodingRNAs-form").append("<div class='alert alert-danger errors'>Oops, not found any gene</div>");
						}
					}
					else {
						$("#otherNonCodingRNAs-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
					}
				}
			);
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
			$.getJSON($(this).attr('action'), $(this).serialize())
			.done(
				function(data) {
					if(data.response.length > 0) {
						$("#searchPanel").hide();
						$("#back").show();
						var html = "<table class='table table-striped table-bordered table-hover result'>" +
									"	<thead>" +
									"		<tr>"+
									"			<th>Contig</th>"+
									"			<th>Start coordinate</th>"+
									"			<th>End coordinate</th>";
						if("confidence" in data.response[0]) {
							html += "			<th>Confidence</th>";
						} else if("hairpin_score" in data.response[0]) {
							html += "			<th>Hairpin score</th>";
						} else if("tail_score" in data.response[0]) {
							html += "			<th>Tail score</th>";
						}
									
						html +=		"		</tr>" +
									"	</thead>" +
									"	<tbody>";
						for(i = 0; i < data.response.length; i++) {
							html += "		<tr>" +
									"			<td>"+data.response[i].contig+"</td>" +
									"			<td>"+data.response[i].start+"</td>" +
									"			<td>"+data.response[i].end+"</td>";
							if("confidence" in data.response[0]) {
								html += "		<td>"+data.response[i].confidence+"</td>";
							} else if("hairpin_score" in data.response[0]) {
								html += "		<td>"+data.response[i].hairpin_score+"</td>";
							} else if("tail_score" in data.response[0]) {
								html += "		<td>"+data.response[i].tail_score+"</td>";
							}
							html +=	"		</tr>";
						}
						html += "	</tbody>" +
								"</table>";
						$("#searchPanel").parent().append(html);
					}
					else {
						$("#transcriptionalTerminators-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
					}
				}
			)
			.fail(
				function(jqxhr, textStatus, erro) {
					var err = textStatus + ", " + error;
					console.log(err);
				}
			);
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
			$.getJSON($(this).attr('action'), $(this).serialize())
			.done(
				function(data) {
					if(data.response.length > 0) {
						$("#searchPanel").hide();
						$("#back").show();
						var html = "<table class='table table-striped table-bordered table-hover result'>" +
									"	<thead>" +
									"		<tr>"+
									"			<th>Contig</th>"+
									"			<th>Start coordinate</th>"+
									"			<th>End coordinate</th>";
						if("old_start" in data.response[0]) {
							html +=
									"			<th>Old start</th>"+
									"			<th>New start</th>";
						}
						else if("position_shift" in data.response[0]) {
							html += 
									"			<th>Position shift</th>";
						}
						else if("site_pattern" in data.response[0]) {
							html += 
									"			<th>Site pattern</th>";
						}
									"		</tr>" +
									"	</thead>" +
									"	<tbody>";
						for(i = 0; i < data.response.length; i++) {
							html += "		<tr>" +
									"			<td>"+data.response[i].contig+"</td>" +
									"			<td>"+data.response[i].start+"</td>" +
									"			<td>"+data.response[i].end+"</td>";
							if("old_start" in data.response[i]) {
								html += 
									"			<td>"+data.response[i].old_start+"</td>" +
									"			<td>"+data.response[i].new_start+"</td>" +
									"		</tr>";
							} else if("position_shift" in data.response[i]) {
								html += 
									"			<td>"+data.response[i].position_shift+"</td>" +
									"		</tr>";
							} else if("site_pattern" in data.response[i]) {
								html += 
									"			<td>"+data.response[i].site_pattern+"</td>";
							}
						}
						html += "	</tbody>" +
								"</table>";
						$("#searchPanel").parent().append(html);
					} else {
						$("#ribosomalBindingSites-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
					}
				}
			)
			.fail(
				function(jqxhr, textStatus, erro) {
					var err = textStatus + ", " + error;
					console.log(err);
				}
			);
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
			$.getJSON($(this).attr('action'), $(this).serialize())
			.done(
				function(data) {
					if(data.response.length > 0) {
						$("#searchPanel").hide();
						$("#back").show();
						var html = "<table class='table table-striped table-bordered table-hover result'>" +
									"	<thead>" +
									"		<tr>"+
									"			<th>ID</th>"+
									"			<th>Contig</th>"+
									"			<th>Start coordinate</th>"+
									"			<th>End coordinate</th>";
						if("score" in data.response[0]) {
							html += "			<th>Score</th>";
						} else if("length" in data.response[0]) {
							html += "			<th>Length</th>";
						} else if("threshold" in data.response[0]) {
							html += "			<th>Threshold</th>";
						}
						html +=		"		</tr>" +
									"	</thead>" +
									"	<tbody>";
						for(var i = 0; i < data.response.length; i++) {
							html += "		<tr>" +
									"			<td><a id='horizontal-transference-"+data.response[i].id+"' href='#'>"+data.response[i].id+"</a></td>" +
									"			<td>"+data.response[i].contig+"</td>" +
									"			<td>"+data.response[i].start+"</td>" +
									"			<td>"+data.response[i].end+"</td>";
							if("score" in data.response[i]) {
								html += "		<td>"+data.response[i].score+"</td>";
							} else if("length" in data.response[i]) {
								html += "		<td>"+data.response[i].length+"</td>";
							} else if("threshold" in data.response[i]) {
								html += "		<td>"+data.response[i].threshold+"</td>";
							}
							html +=	"		</tr>";
						}
						html += "	</tbody>" +
								"</table>";
						$("#searchPanel").parent().append(html);
						for(var i = 0; i < data.response.length; i++) {
							var result = data.response[i];
							$("#horizontal-transference-"+result.id).click(function() {
								$(".result").remove();
								$.getJSON("/SearchDatabase/geneByPosition/"+result.start+"/"+result.end, "")
								.done(
									function(data) {
										contentGeneData(data.response);
									}
								);
							});
						}
					}
					else {
						$("#horizontalGeneTransfers-form").append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
					}
				}
			)
			.fail(
				function(jqxhr, textStatus, erro) {
					var err = textStatus + ", " + error;
					console.log(err);
				}
			);
			return false;
		}
	);
});

/**
 * Method used to deal with content of gene
 * @param data
 * @returns
 */
function contentGeneData(data) {
	for(var i = 0; i < data.length; i++) {
		var feature = data[i];
		var htmlContent = feature.html;
		htmlContent = htmlContent.replace(/(\[\% result.feature_id \%\])+/gim, feature.feature_id);
		htmlContent = htmlContent.replace(/(\[\% result.name \%\])/gim, feature.name);
		htmlContent = htmlContent.replace(/(\[\% result.uniquename \%\])/gim, feature.uniquename);
		$("#searchPanel").hide();
		$("#back").show();
		$("#searchPanel").parent().append(htmlContent);
		
		$("#result-panel-title-"+feature.feature_id).on("click", function() {
			var href = $(this).attr('href');
			var name = $(this).text().substring(0, $(this).text().indexOf("-") - 1) ;
			var data = getGeneBasics(href.replace("#", "")).responseJSON.response;
			
			dealDataResults(href, name, data);
		
			return false;
		});
	}
}

/**
 * Method used to deal with data results and standard visualization, need to modularize
 * @param href panel of results
 * @param featureName 
 * @param data
 * @returns 
 */
function dealDataResults(href, featureName, data) {
	if($(href).is(":hidden")) {
		data = data[0];
		var htmlContent = data.html;
		htmlContent = htmlContent.replace("[% result.type %]", data.value);
		htmlContent = htmlContent.replace("[% result.uniquename %]", data.uniquename);
		htmlContent = htmlContent.replace("[% result.fstart %]", data.fstart);
		htmlContent = htmlContent.replace("[% result.fend %]", data.fend);
		htmlContent = htmlContent.replace("[% result.length %]", (data.fend - data.fstart + 1));
		var type = data.value;
		var name = data.uniquename;
		var htmlSequence = "";
		var subsequence = getSubsequence(type, featureName, name, data.fstart, data.fend).responseJSON.response;
		htmlSequence += subsequence.html;
		htmlSequence = htmlSequence.replace("[% result.feature_id %]", href.replace("#", ""));
		htmlSequence = htmlSequence.replace("[% result.feature_id %]", href.replace("#", ""));
		htmlSequence = htmlSequence.replace("[% result.sequence %]", subsequence.sequence);
		if(type == "CDS") {
			htmlContent += htmlSequence;
			var data = getSubEvidences(href.replace("#", "")).responseJSON.response;
			
			var components = new Object();
			var componentsEvidences = new Array();
			var counterComponentsEvidences = 0; 
			for(i = 0; i < data.subevidences.length; i++) {
				var componentName = data.subevidences[i].program.replace(".pl", "");
				
				if($.inArray(componentName, componentsEvidences) == -1) {
					var htmlEvidence = data.evidencesHtml.content;
					htmlEvidence = htmlEvidence.replace("[% result.componentName %]", componentName);
					htmlEvidence = htmlEvidence.replace("[% result.componentName %]", componentName);
					htmlEvidence = htmlEvidence.replace("[% result.componentName %]", componentName);
					htmlEvidence = htmlEvidence.replace("[% result.id %]", href.replace("#", ""));
					htmlEvidence = htmlEvidence.replace("[% result.id %]", href.replace("#", ""));
					htmlEvidence = htmlEvidence.replace("[% result.id %]", href.replace("#", ""));
					htmlEvidence = htmlEvidence.replace("[% result.descriptionComponent %]", data.subevidences[i].descriptionProgram);
					htmlContent += htmlEvidence;
					componentsEvidences[counterComponentsEvidences] = componentName;
					counterComponentsEvidences++;
				}

				if(typeof components[componentName] == 'undefined') {
					components[componentName] = new Array();
				} 
				var arrayEvidences = components[componentName];
				arrayEvidences[components[componentName].length] = { "id" : data.subevidences[i].subev_id, "type" : data.subevidences[i].subev_type };
				components[componentName] = arrayEvidences;
			}
			
			addPanelResult(href, htmlContent);
		
			for(var component in components) {
				console.log(component);
				$("#anchor-evidence-"+component+"-"+href.replace("#", "")).click(function clickEvidences() {
					var componentTemp = this.id.replace("anchor-evidence-", "");
					componentTemp = componentTemp.replace("-"+href.replace("#", ""), "");
					console.log(componentTemp);
					if($("#evidence-"+componentTemp+"-"+href.replace("#", "")).is(":hidden")) {
						for(i = 0; i < components[componentTemp].length; i++) {
							if(componentTemp != "annotation_phobius" && componentTemp != "annotation_tmhmm" && componentTemp != 'annotation_orthology' && componentTemp != 'annotation_pathways' 
								&& componentTemp != 'annotation_interpro') {
								var htmlSubevidence = data.subEvidencesHtml.content;
								htmlSubevidence = htmlSubevidence.replace("[% result.feature_id %]", components[componentTemp][i].id);
								htmlSubevidence = htmlSubevidence.replace("[% result.feature_id %]", components[componentTemp][i].id);
								htmlSubevidence = htmlSubevidence.replace("[% result.feature_id %]", components[componentTemp][i].id);
								addPanelResult("#evidence-"+componentTemp+"-"+href.replace("#", ""), htmlSubevidence);
							}
							if(components[componentTemp][i].type == "similarity") {
								var response = getSimilarityEvidenceProperties(components[componentTemp][i].id, componentTemp).responseJSON.response;
								var html = response.html;
								html = html.replace("[% result.evalue %]", response.evalue);
								html = html.replace("[% result.percent_id %]", response.percent_id);
                                html = html.replace("[% result.similarity %]", response.similarity);
                                html = html.replace("[% result.score %]", response.score);
                                html = html.replace("[% result.block_size %]", response.block_size);
                                addPanelResult("#subevidence-"+response.id, html);
                                console.log(response);
							} else if(components[componentTemp][i].type == "intervals") {
								var responseIntervals = getIntervalEvidenceProperties(components[componentTemp][i].id, componentTemp).responseJSON.response;
								var html = responseIntervals.html;
								var listHTMLs = new Array();
								var counterHTMLs = 0;
								var idTable = "";
								var architecture = "";
								var counterTMHMM = 0;
								if($("#counterTMHMM").val() >= components[componentTemp].length) {
									counterTMHMM = 0;
								} else if($("#counterTMHMM").val() != undefined) {
									counterTMHMM = $("#counterTMHMM").val();
								} 
								
								if($("#architecture-tmhmm").text() == "" || 
										$("#architecture-tmhmm").text() == undefined ||
										$("#counterTMHMM").val() >= components[componentTemp].length) {
									architecture = "";
								} else {
									architecture = $("#architecture-tmhmm").text() + "-";
								}

								if(componentTemp == 'annotation_interpro') {
									for(var j = 0; j < data.properties.length; j++) {
										html = responseIntervals.html;
										html = html.replace("[% result.componentName %]", componentTemp);
										html = html.replace("[% result.componentName %]", componentTemp);
										html = html.replace("[% result.feature_id %]", href.replace("#", ""));
										html = html.replace("[% result.feature_id %]", href.replace("#", ""));
										html = html.replace("[% result.counter %]", counterHTMLs);
										html = html.replace("[% result.counter %]", counterHTMLs);
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
									idTable = "#evidence-"+componentTemp+"-"+href.replace("#", "");
								} else if(componentTemp == 'annotation_tmhmm') {
									idTable = "#evidence-"+componentTemp+"-"+href.replace("#", "");
									for(var j = 0; j < responseIntervals.properties.length; j++) {
										$(".architecture-tmhmm").remove();
										counterTMHMM++;
										if(responseIntervals.properties[j].direction == "inside") {
											architecture += "I";
										}
										else if(responseIntervals.properties[j].direction == "outside") {
											architecture += "O";
										}
										else if(responseIntervals.properties[j].direction == "TMhelix") {
											architecture += "T";
										}
										listHTMLs[counterHTMLs] = "<div class='row architecture-tmhmm'><div class='col-md-3'><p>Predicted TMHs</p></div><div class='col-md-9'>"+responseIntervals.properties[j].predicted_TMHs+"</div></div>";
										counterHTMLs++;
										listHTMLs[counterHTMLs] = "<div class='row architecture-tmhmm'><div class='col-md-3'><p>Architecture:</p></div><div class='col-md-9'><p id='architecture-tmhmm'>"+architecture+"</p></div></div>";
										counterHTMLs++;
										listHTMLs[counterHTMLs] = "<div class='row architecture-tmhmm'><div class='col-md-12'><div class='alert alert-info'><p>Architecture legend: O, outside the cytoplasm; T, transmembrane domain; I, inside the cytoplasm</p></div></div></div>";
										counterHTMLs++;
										listHTMLs[counterHTMLs] = "<input type='hidden' class='architecture-tmhmm' id='counterTMHMM' value='"+counterTMHMM+"' \>";
										counterHTMLs++;
									}
								} else if(componentTemp == 'annotation_tcdb') {
									for(var j = 0; j < responseIntervals.properties.length; j++) {
										html = responseIntervals.html;
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
									idTable = "#subevidence-"+responseIntervals.id;
								} else if(componentTemp == 'annotation_pathways') {
									for(var j = 0; j < responseIntervals.properties.length; j++) {
										html = responseIntervals.html;
										html = html.replace("[% result.orthologous_group_id %]", responseIntervals.properties[j].orthologous_group_id);
										html = html.replace("[% result.orthologous_group_id %]", responseIntervals.properties[j].orthologous_group_id);
										html = html.replace("[% result.orthologous_group_id %]", responseIntervals.properties[j].orthologous_group_id);
										html = html.replace("[% result.orthologous_group_description %]", responseIntervals.properties[j].orthologous_group_description);
										addPanelResult("#evidence-"+componentTemp+"-"+href.replace("#", ""), html);
										for(var pathway in responseIntervals.pathways) {
											var htmlPathway = responseIntervals.htmlPathways;
											htmlPathway = htmlPathway.replace("[% result.metabolic_pathway_id %]", responseIntervals.pathways[pathway].id);
											htmlPathway = htmlPathway.replace("[% result.metabolic_pathway_id %]", responseIntervals.pathways[pathway].id);
											htmlPathway = htmlPathway.replace("[% result.metabolic_pathway_description %]", responseIntervals.pathways[pathway].description);
											listHTMLs[counterHTMLs] = htmlPathway;
											counterHTMLs++;
										}
										idTable = "#pathways-"+responseIntervals.properties[j].orthologous_group_id;
									}
								} else if(componentTemp == 'annotation_orthology') {
									for(var j = 0; j < responseIntervals.properties.length; j++) {
										html = html.replace("[% result.orthologous_hit %]", responseIntervals.properties[j].orthologous_hit);
										html = html.replace("[% result.id %]", responseIntervals.id);
										addPanelResult("#evidence-"+componentTemp+"-"+href.replace("#", ""), html);
										for(var orthology in responseIntervals.orthologous_groups) {
											var htmlOrthology = responseIntervals.htmlOrthology;
											htmlOrthology = htmlOrthology.replace("[% result.orthologous_group %]", responseIntervals.orthologous_groups[orthology].group);
											htmlOrthology = htmlOrthology.replace("[% result.orthologous_group %]", responseIntervals.orthologous_groups[orthology].group);
											htmlOrthology = htmlOrthology.replace("[% result.orthologous_group_description %]", responseIntervals.orthologous_groups[orthology].description);
											listHTMLs[counterHTMLs] = htmlOrthology;
											counterHTMLs++;
										}
										idTable = "#orthology-"+responseIntervals.id;
									}
								} else if(componentTemp == 'annotation_phobius') {
									$(".architecture-phobius").remove();
									var signal = false;
									var cleavage = "";
									architecture = "";
									var TMs = 0;
									for(var j = 0; j < responseIntervals.properties.length; j++) {
										if(responseIntervals.properties[j].classification == 'SIGNAL') {
											signal = true;
										}
										if(responseIntervals.properties[j].hasOwnProperty("cleavage_position1")) {
											cleavage += responseIntervals.properties[j].cleavage_position1;
										}
										if(responseIntervals.properties[j].hasOwnProperty("cleavage_position2")) {
											cleavage += " - " + responseIntervals.properties[j].cleavage_position2;
										}
										if(responseIntervals.properties[j].hasOwnProperty("predicted_TMHs")) {
											TMs = responseIntervals.properties[j].predicted_TMHs;
										}
										if(responseIntervals.properties[j].hasOwnProperty("region")) {
											if(responseIntervals.properties[j].region == "NON CYTOPLASMIC") {
												architecture += "O";
											}
											else if(responseIntervals.properties[j].region == "TRANSMEM") {
												architecture += "T";
											}
											else if(responseIntervals.properties[j].region == "CYTOPLASMIC") {
												architecture += "I";
											}
											if(!(j == responseIntervals.properties.length - 1)) {
												architecture += "-";
											}
										}
									}
									if(signal) {
										listHTMLs[counterHTMLs] = "<div class='row architecture-phobius'><div class='col-md-3'><p>Signal peptide:</p></div><div class='col-md-9'><p>Yes</p></div></div>";
										counterHTMLs++;
									}
									if(cleavage != "") {
										listHTMLs[counterHTMLs] = "<div class='row architecture-phobius'><div class='col-md-3'><p>Cleavage positions:</p></div><div class='col-md-9'><p>"+cleavage+"</p></div></div>";
										counterHTMLs++;
									}
									if(TMs != 0) {
										listHTMLs[counterHTMLs] = "<div class='row architecture-phobius'><div class='col-md-3'><p>Transmembrane domains:</p></div><div class='col-md-9'><p>"+TMs+"</p></div></div>";
										counterHTMLs++;
									}
									if(architecture != "") {
										listHTMLs[counterHTMLs] = "<div class='row architecture-phobius'><div class='col-md-3'><p>Architecture:</p></div><div class='col-md-9'><p>"+architecture+"</p></div></div>";
										counterHTMLs++;
										listHTMLs[counterHTMLs] = "<div class='row architecture-phobius'><div class='col-md-12'><div class='alert alert-info'><p>Architecture legend: O, outside the cytoplasm; T, transmembrane domain; I, inside the cytoplasm</p></div></div></div>";
										counterHTMLs++;
									}
									idTable = "#evidence-"+componentTemp+"-"+href.replace("#", "");
								}
//												addPanelResult("#subevidence-"+data.id, html);
								for(var index in listHTMLs) {
									addPanelResult(idTable, listHTMLs[index]);
								}
								console.log(responseIntervals);
							} 
						}
					} 
				});
			}
		}
		
		if(data.value == "tRNAscan") {
		    var data = getIntervalEvidenceProperties(href.replace("#", ""), data.value).responseJSON.response;
			var htmlBasic = data.htmlBasicResult;
			htmlBasic = htmlBasic.replace("[% result.type %]", data.properties[0].type);
			htmlBasic = htmlBasic.replace("[% result.aminoacid %]", data.properties[0].aminoacid);
			htmlBasic = htmlBasic.replace("[% result.anticodon %]", data.properties[0].anticodon);
			htmlBasic = htmlBasic.replace("[% result.codon %]", data.properties[0].codon);
			htmlBasic = htmlBasic.replace("[% result.score %]", data.properties[0].score);
			htmlBasic = htmlBasic.replace("[% result.pseudogene %]", data.properties[0].pseudogene);
			htmlContent += htmlBasic;
			if(data.properties[0].hasOwnProperty("intron")) {
				if(data.properties[0].intron == "yes") {
					htmlBasic = data.properties[0].htmlHasIntron;
					htmlBasic = htmlBasic.replace("[% result.intron %]", data.properties[0].intron);
					htmlBasic = htmlBasic.replace("[% result.coordinatesGene %]", data.properties[0].coordinatesGene);
					htmlBasic = htmlBasic.replace("[% result.coordinatesGenome %]", data.properties[0].coordinatesGenome);
					htmlContent += htmlBasic;
				}
			}
			htmlContent += htmlSequence;
			addPanelResult(href, htmlContent);
			
			
		} else if(data.value == "RNA_scan") {
		    var data = getIntervalEvidenceProperties(href.replace("#", ""), data.value).responseJSON.response;
			htmlBasic = data.htmlBasicResult;
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
		} else if(data.value == "rRNA_prediction") {
		    var data = getIntervalEvidenceProperties(href.replace("#", ""), data.value).responseJSON.response;
			var htmlBasic = data.htmlBasicResult;
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
 * @param href of the panel
 * @param htmlContent to be added
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
			$.getJSON($(this).attr('action'), $(this).serialize())
				.done(
					function(data) {
					    data = data.response;
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

