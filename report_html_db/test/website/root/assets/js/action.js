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
					if(data.length > 0) {
						contentGeneData(data);
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
					if(data.length > 0) {
						contentGeneData(data);
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
					if(data.length > 0) {
						var featuresIDs = data.join(" ");
						$.getJSON("/SearchDatabase/Gene/?featureId="+featuresIDs, "")
						.done(
							function(data) {
								if(data.length > 0) {
									contentGeneData(data);
								}
								else {
									$("#formAnalysesProteinCodingGenes").append("<div class='alert alert-danger errors'>Oops, not found any gene</div>");
								}
							}
						);
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
					if(data.length > 0) {
						var featuresIDs = "";
						for(i = 0; i < data.length; i++) {
							featuresIDs += data[i].id+" ";
						}
						$.getJSON("/SearchDatabase/Gene/?featureId="+featuresIDs, "")
						.done(
							function(data) {
								if(data.length > 0) {
									contentGeneData(data);
								}
								else {
									$("#formAnalysesProteinCodingGenes").append("<div class='alert alert-danger errors'>Oops, not found any gene</div>");
								}
								
							}
						);
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
					if(data.length > 0) {
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
						for(i = 0; i < data.length; i++) {
							html += "		<tr>" +
									"			<td>"+data[i].contig+"</td>" +
									"			<td>"+data[i].start+"</td>" +
									"			<td>"+data[i].end+"</td>" +
									"			<td>"+data[i].length+"</td>" +
									"			<td>"+data[i].copy_number+"</td>" +
									"			<td>"+data[i].sequence+"</td>" +
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
	$("#otherNonCodingRNAs-form").submit(
		function() {
			$(".errors").remove();
			$.getJSON($(this).attr('action'), $(this).serialize())
			.done(
				function(data) {
					if(data.length > 0) {
						var featuresIDs = "";
						for(i = 0; i < data.length; i++) {
							featuresIDs += data[i].id+" ";
						}
						$.getJSON("/SearchDatabase/Gene/?featureId="+featuresIDs, "")
						.done(
							function(data) {
								if(data.length > 0) {
									contentGeneData(data);
								}
								else {
									$("#otherNonCodingRNAs-form").append("<div class='alert alert-danger errors'>Oops, not found any gene</div>");
								}
							}
						);
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
					if(data.length > 0) {
						$("#searchPanel").hide();
						$("#back").show();
						var html = "<table class='table table-striped table-bordered table-hover result'>" +
									"	<thead>" +
									"		<tr>"+
									"			<th>Contig</th>"+
									"			<th>Start coordinate</th>"+
									"			<th>End coordinate</th>";
						if("confidence" in data[0]) {
							html += "			<th>Confidence</th>";
						} else if("hairpin_score" in data[0]) {
							html += "			<th>Hairpin score</th>";
						} else if("tail_score" in data[0]) {
							html += "			<th>Tail score</th>";
						}
									
						html +=		"		</tr>" +
									"	</thead>" +
									"	<tbody>";
						for(i = 0; i < data.length; i++) {
							html += "		<tr>" +
									"			<td>"+data[i].contig+"</td>" +
									"			<td>"+data[i].start+"</td>" +
									"			<td>"+data[i].end+"</td>";
							if("confidence" in data[0]) {
								html += "		<td>"+data[i].confidence+"</td>";
							} else if("hairpin_score" in data[0]) {
								html += "		<td>"+data[i].hairpin_score+"</td>";
							} else if("tail_score" in data[0]) {
								html += "		<td>"+data[i].tail_score+"</td>";
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
					if(data.length > 0) {
						$("#searchPanel").hide();
						$("#back").show();
						var html = "<table class='table table-striped table-bordered table-hover result'>" +
									"	<thead>" +
									"		<tr>"+
									"			<th>Contig</th>"+
									"			<th>Start coordinate</th>"+
									"			<th>End coordinate</th>";
						if("old_start" in data[0]) {
							html +=
									"			<th>Old start</th>"+
									"			<th>New start</th>";
						}
						else if("position_shift" in data[0]) {
							html += 
									"			<th>Position shift</th>";
						}
						else if("site_pattern" in data[0]) {
							html += 
									"			<th>Site pattern</th>";
						}
									"		</tr>" +
									"	</thead>" +
									"	<tbody>";
						for(i = 0; i < data.length; i++) {
							html += "		<tr>" +
									"			<td>"+data[i].contig+"</td>" +
									"			<td>"+data[i].start+"</td>" +
									"			<td>"+data[i].end+"</td>";
							if("old_start" in data[i]) {
								html += 
									"			<td>"+data[i].old_start+"</td>" +
									"			<td>"+data[i].new_start+"</td>" +
									"		</tr>";
							} else if("position_shift" in data[i]) {
								html += 
									"			<td>"+data[i].position_shift+"</td>" +
									"		</tr>";
							} else if("site_pattern" in data[i]) {
								html += 
									"			<td>"+data[i].site_pattern+"</td>";
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
					if(data.length > 0) {
						$("#searchPanel").hide();
						$("#back").show();
						var html = "<table class='table table-striped table-bordered table-hover result'>" +
									"	<thead>" +
									"		<tr>"+
									"			<th>ID</th>"+
									"			<th>Contig</th>"+
									"			<th>Start coordinate</th>"+
									"			<th>End coordinate</th>";
						if("score" in data[0]) {
							html += "			<th>Score</th>";
						} else if("length" in data[0]) {
							html += "			<th>Length</th>";
						} else if("threshold" in data[0]) {
							html += "			<th>Threshold</th>";
						}
						html +=		"		</tr>" +
									"	</thead>" +
									"	<tbody>";
						for(i = 0; i < data.length; i++) {
							html += "		<tr>" +
									"			<td>"+data[i].id+"</td>" +
									"			<td>"+data[i].contig+"</td>" +
									"			<td>"+data[i].start+"</td>" +
									"			<td>"+data[i].end+"</td>";
							if("score" in data[i]) {
								html += "		<td>"+data[i].score+"</td>";
							} else if("length" in data[i]) {
								html += "		<td>"+data[i].length+"</td>";
							} else if("threshold" in data[i]) {
								html += "		<td>"+data[i].threshold+"</td>";
							}
							html +=	"		</tr>";
						}
						html += "	</tbody>" +
								"</table>";
						$("#searchPanel").parent().append(html);
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
			$.getJSON("/SearchDatabase/GetGeneBasics/"+href.replace("#", ""), "")
			.done(
				function(data) {
					dealDataResults(href, name, data);
				}
			)
			.fail(
				function(jqxhr, textStatus, error) {
					var err = textStatus + ", " + error;
					console.log(err);
				}
			);
		
			return false;
		});
	}
}

/**
 * Method used to deal with data results and standard
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
		$.getJSON("/SearchDatabase/GetSubsequence/"+type+"/"+featureName+"/"+name+"/"+data.fstart+"/"+data.fend, "")
		.done(
			function(data) {
				htmlSequence = data.html;
				htmlSequence = htmlSequence.replace("[% result.feature_id %]", href.replace("#", ""));
				htmlSequence = htmlSequence.replace("[% result.feature_id %]", href.replace("#", ""));
				htmlSequence = htmlSequence.replace("[% result.sequence %]", data.sequence);
				if(type == "CDS") {
					htmlContent += htmlSequence;
					$.getJSON("/SearchDatabase/subEvidences/"+href.replace("#", ""), "")
					.done(
						function(data) {
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
								$("#anchor-evidence-"+component+"-"+href.replace("#", "")).click(function() {
									var componentTemp = this.id.replace("anchor-evidence-", "");
									componentTemp = componentTemp.replace("-"+href.replace("#", ""), "");
									console.log(componentTemp);
									if($("#evidence-"+componentTemp+"-"+href.replace("#", "")).is(":hidden")) {
										for(i = 0; i < components[componentTemp].length; i++) {
											var htmlSubevidence = data.subEvidencesHtml.content;
											htmlSubevidence = htmlSubevidence.replace("[% result.feature_id %]", components[componentTemp][i].id);
											htmlSubevidence = htmlSubevidence.replace("[% result.feature_id %]", components[componentTemp][i].id);
											htmlSubevidence = htmlSubevidence.replace("[% result.feature_id %]", components[componentTemp][i].id);
											addPanelResult("#evidence-"+componentTemp+"-"+href.replace("#", ""), htmlSubevidence);
											if(components[componentTemp][i].type == "similarity") {
												$.getJSON("/SearchDatabase/getSimilarityEvidenceProperties/"+components[componentTemp][i].id, "")
												.done(function(data) {
													var html = data.html;
													html = html.replace("[% result.evalue %]", data.evalue);
													html = html.replace("[% result.percent_id %]", data.percent_id);
													html = html.replace("[% result.similarity %]", data.similarity);
													html = html.replace("[% result.score %]", data.score);
													html = html.replace("[% result.block_size %]", data.block_size);
													addPanelResult("#subevidence-"+data.id, html);
													console.log(data);
												});
											} else if(components[componentTemp][i].type == "intervals") {
												$.getJSON("/SearchDatabase/getIntervalEvidenceProperties/"+components[componentTemp][i].id+"/"+componentTemp, "")
												.done(function(data) {
													var html = data.html;
													var listHTMLs = new Array();
													var counterHTMLs = 0;
													var idTable = "";

													if(componentTemp == 'annotation_interpro') {
														for(var i = 0; i < data.properties.length; i++) {
															html = data.html;
															html = html.replace("[% result.componentName %]", componentTemp);
															html = html.replace("[% result.componentName %]", componentTemp);
															html = html.replace("[% result.feature_id %]", href.replace("#", ""));
															html = html.replace("[% result.feature_id %]", href.replace("#", ""));
															html = html.replace("[% result.counter %]", counterHTMLs);
															html = html.replace("[% result.counter %]", counterHTMLs);
															html = html.replace("[% result.counter %]", counterHTMLs);
															html = html.replace("[% result.interpro_id %]", data.properties[i].interpro_id);
															html = html.replace("[% result.interpro_id %]", data.properties[i].interpro_id);
															html = html.replace("[% result.description_interpro %]", data.properties[i].description_interpro);
															html = html.replace("[% result.DB_id %]", data.properties[i].DB_id);
															html = html.replace("[% result.DB_id %]", data.properties[i].DB_id);
															html = html.replace("[% result.DB_name %]", data.properties[i].DB_name);
															html = html.replace("[% result.description %]", data.properties[i].description);
															html = html.replace("[% result.evidence_process %]", data.properties[i].evidence_process);
															html = html.replace("[% result.evidence_function %]", data.properties[i].evidence_function);
															html = html.replace("[% result.evidence_component %]", data.properties[i].evidence_component);
															html = html.replace("[% result.score %]", data.properties[i].score);
															listHTMLs[counterHTMLs] = html;
															counterHTMLs++;
														}
														idTable = "#subevidence-"+data.id;
													} else if(componentTemp == 'annotation_tmhmm') {
														for(var i = 0; i < data.properties.length; i++) {
															html = data.html;
															html = html.replace("[% result.predicted_TMHs %]", data.properties[i].predicted_TMHs);
															html = html.replace("[% result.version %]", data.properties[i].version);
															html = html.replace("[% result.direction %]", data.properties[i].direction);
															listHTMLs[counterHTMLs] = html;
															counterHTMLs++;
														}
														idTable = "#subevidence-"+data.id;
													} else if(componentTemp == 'annotation_tcdb') {
														for(var i = 0; i < data.properties.length; i++) {
															html = data.html;
															html = html.replace("[% result.TCDB_ID %]", data.properties[i].TCDB_ID);
															html = html.replace("[% result.TCDB_ID %]", data.properties[i].TCDB_ID);
															html = html.replace("[% result.hit_description %]", data.properties[i].hit_description);
															html = html.replace("[% result.TCDB_class %]", data.properties[i].TCDB_class);
															html = html.replace("[% result.TCDB_subclass %]", data.properties[i].TCDB_subclass);
															html = html.replace("[% result.TCDB_family %]", data.properties[i].TCDB_family);
															html = html.replace("[% result.hit_name %]", data.properties[i].hit_name);
															html = html.replace("[% result.hit_name %]", data.properties[i].hit_name);
															html = html.replace("[% result.evalue %]", data.properties[i].evalue);
															html = html.replace("[% result.percent_id %]", data.properties[i].percent_id);
															html = html.replace("[% result.similarity %]", data.properties[i].similarity);
															listHTMLs[counterHTMLs] = html;
															counterHTMLs++;
														}
														idTable = "#subevidence-"+data.id;
													} else if(componentTemp == 'annotation_pathways') {
														for(var i = 0; i < data.properties.length; i++) {
															html = data.html;
															html = html.replace("[% result.orthologous_group_id %]", data.properties[i].orthologous_group_id);
															html = html.replace("[% result.orthologous_group_id %]", data.properties[i].orthologous_group_id);
															html = html.replace("[% result.orthologous_group_id %]", data.properties[i].orthologous_group_id);
															html = html.replace("[% result.orthologous_group_description %]", data.properties[i].orthologous_group_description);
															addPanelResult("#subevidence-"+data.id, html);
															for(var pathway in data.pathways) {
																var htmlPathway = data.htmlPathways;
																htmlPathway = htmlPathway.replace("[% result.metabolic_pathway_id %]", data.pathways[pathway].id);
																htmlPathway = htmlPathway.replace("[% result.metabolic_pathway_id %]", data.pathways[pathway].id);
																htmlPathway = htmlPathway.replace("[% result.metabolic_pathway_description %]", data.pathways[pathway].description);
																listHTMLs[counterHTMLs] = htmlPathway;
																counterHTMLs++;
															}
															idTable = "#pathways-"+data.properties[i].orthologous_group_id;
														}
													} else if(componentTemp == 'annotation_orthology') {
														for(var i = 0; i < data.properties.length; i++) {
															html = html.replace("[% result.orthologous_hit %]", data.properties[i].orthologous_hit);
															html = html.replace("[% result.id %]", data.id);
															addPanelResult("#subevidence-"+data.id, html);
															for(var orthology in data.orthologous_groups) {
																var htmlOrthology = data.htmlOrthology;
																htmlOrthology = htmlOrthology.replace("[% result.orthologous_group %]", data.orthologous_groups[orthology].group);
																htmlOrthology = htmlOrthology.replace("[% result.orthologous_group %]", data.orthologous_groups[orthology].group);
																htmlOrthology = htmlOrthology.replace("[% result.orthologous_group_description %]", data.orthologous_groups[orthology].description);
																listHTMLs[counterHTMLs] = htmlOrthology;
																counterHTMLs++;
															}
															idTable = "#orthology-"+data.id;
														}
													} else if(componentTemp == 'annotation_phobius') {
														var signal = false;
														var cleavage = "";
														var architecture = "";
														var TMs = 0;
														for(var i = 0; i < data.properties.length; i++) {
															if(data.properties[i].classification == 'SIGNAL') {
																signal = true;
															}
															if(data.properties[i].hasOwnProperty("cleavage_position1")) {
																cleavage += data.properties[i].cleavage_position1;
															}
															if(data.properties[i].hasOwnProperty("cleavage_position2")) {
																cleavage += " - " + data.properties[i].cleavage_position2;
															}
															if(data.properties[i].hasOwnProperty("predicted_TMHs")) {
																TMs = data.properties[i].predicted_TMHs;
															}
															if(data.properties[i].hasOwnProperty("region")) {
																if(data.properties[i].region == "NON CYTOPLASMIC") {
																	architecture += "-O-";
																}
																else if(data.properties[i].region == "TRANSMEM") {
																	architecture += "T";
																}
																else if(data.properties[i].region == "CYTOPLASMIC") {
																	architecture += "-I-";
																}
															}
														}
														if(signal) {
															listHTMLs[counterHTMLs] = "<div class='row'><div class='col-md-3'><p>Signal peptide:</p></div><div class='col-md-9'><p>Yes</p></div></div>";
															counterHTMLs++;
														}
														if(cleavage != "") {
															listHTMLs[counterHTMLs] = "<div class='row'><div class='col-md-3'><p>Cleavage positions:</p></div><div class='col-md-9'><p>"+cleavage+"</p></div></div>";
															counterHTMLs++;
														}
														if(TMs != 0) {
															listHTMLs[counterHTMLs] = "<div class='row'><div class='col-md-3'><p>Transmembrane domains:</p></div><div class='col-md-9'><p>"+TMs+"</p></div></div>";
															counterHTMLs++;
														}
														if(architecture != "") {
															listHTMLs[counterHTMLs] = "<div class='row'><div class='col-md-3'><p>Architecture:</p></div><div class='col-md-9'><p>"+architecture+"</p></div></div>";
															counterHTMLs++;
															listHTMLs[counterHTMLs] = "<div class='row'><div class='col-md-12'><div class='alert alert-info'><p>Architecture legend: O, outside the cytoplasm; T, transmembrane domain; I, inside the cytoplasm</p></div></div></div>";
															counterHTMLs++;
														}
														idTable = "#subevidence-"+data.id;
													}
//													addPanelResult("#subevidence-"+data.id, html);
													for(var index in listHTMLs) {
														addPanelResult(idTable, listHTMLs[index]);
													}
													console.log(data);
												});
											}
										}
									} else {
										$("#evidence-"+componentTemp+"-"+href.replace("#", "")).empty();
									}
									
								});
							}
						}
					);
				}
			}
		)
		.fail(
			function(jqxhr, textStatus, error) {
				var err = textStatus + ", " + error;
				console.log("Erro ao pegar subsequencia: "+err);
			}
		);
		
		if(data.value == "tRNAscan") {
			$.getJSON("/SearchDatabase/getIntervalEvidenceProperties/"+href.replace("#", "")+"/"+data.value, "")
			.done(
				function(data) {
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
				}
			)
			.fail(
				function(jqxhr, textStatus, error) {
					var err = textStatus + ", " + error;
					console.log("Erro: "+err);
				}
			);
			
		} else if(data.value == "RNA_scan") {
			var htmlBasic = "";
			$.when($.getJSON("/SearchDatabase/getIntervalEvidenceProperties/"+href.replace("#", "")+"/"+data.value, ""))
			.done(
				function(data) {
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
				}				
			)
			.fail(
				function(jqxhr, textStatus, error) {
					var err = textStatus + ", " + error;
					console.log("Erro: "+err);
				}
			);
		} else if(data.value == "rRNA_prediction") {
			$.getJSON("/SearchDatabase/getIntervalEvidenceProperties/"+href.replace("#", "")+"/"+data.value, "")
			.done(
				function(data) {
					var htmlBasic = data.htmlBasicResult;
					htmlBasic = htmlBasic.replace("[% result.molecule_type %]", data.properties[0].molecule_type);
					htmlBasic = htmlBasic.replace("[% result.score %]", data.properties[0].score);
					htmlContent += htmlBasic;
					htmlContent += htmlSequence;
					addPanelResult(href, htmlContent);
				}
			)
			.fail(
				function(jqxhr, textStatus, error) { 
					var err = textStatus + ", " + error;
					console.log("Erro: "+err);
				}
			);
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
 * Method used to get components
 * @returns components
 */
function getComponents() {
	var components;
	$.getJSON("getComponents", "")
	.done(
		function(data) {
			components = data;
		}
	)
	.fail(
		function(jqxhr, textStatus, error) {
			var err = textStatus + ", " + error;
			console.log("Erro: "+err);
		}
	);
	return components;
}

/**
 * Method used to get subevidences
 * @param featureId
 * @returns subevidences
 */
function getSubEvidences(featureId) {
	var subEvidences;
	$.getJSON("subEvidences/"+featureId, "")
	.done(
		function(data) {
			subEvidences = data;
		}
	)
	.fail(
		function(jqxhr, textStatus, error) {
			var err = textStatus + ", " + error;
			console.log("Erro: "+err);
		}
	);
	return subEvidences;
}

/**
 * Method used to get properties of internal evidences
 * @param featureId
 * @param type
 * @returns properties
 */
function getIntervalEvidenceProperties(featureId, type) {
	var properties;
	$.getJSON("getIntervalEvidenceProperties/"+featureId+"/"+type, "")
	.done(
		function(data) {
			properties = data;
		}
	)
	.fail(
		function(jqxhr, textStatus, error) {
			var err = textStatus + ", " + error;
			console.log("Erro: "+err);
		}
	);
	return properties;
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

