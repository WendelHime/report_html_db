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
					if(data.length > 0) {
						contentGeneData("#formGeneIdentifier", data);
					} else {
						$(id).append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
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

$(function() {
	$("#formGeneDescription").submit(
		function() {
			$(".errors").remove();
			$.getJSON($(this).attr('action'), $(this).serialize())
			.done(
				function(data) {
					if(data.length > 0) {
						contentGeneData("#formGeneDescription", data);
					} else {
						$(id).append("<div class='alert alert-danger errors'>Oops, not found anything like that</div>");
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

function contentGeneData(id, data) {
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
			$.getJSON("GetGeneBasics/"+href.replace("#", ""), "")
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


function dealDataResults(href, featureName, data) {
	if($(href).is(":hidden")) {
		var htmlContent = data.html;
		htmlContent = htmlContent.replace("[% result.type %]", data.value);
		htmlContent = htmlContent.replace("[% result.uniquename %]", data.uniquename);
		htmlContent = htmlContent.replace("[% result.fstart %]", data.fstart);
		htmlContent = htmlContent.replace("[% result.fend %]", data.fend);
		htmlContent = htmlContent.replace("[% result.length %]", (data.fend - data.fstart + 1));
		var type = data.value;  
		var htmlSequence = "";
		$.getJSON("GetSubsequence/"+featureName, "")
		.done(
			function(data) {
				htmlSequence = data.html;
				htmlSequence = htmlSequence.replace("[% result.feature_id %]", href.replace("#", ""));
				htmlSequence = htmlSequence.replace("[% result.feature_id %]", href.replace("#", ""));
				htmlSequence = htmlSequence.replace("[% result.sequence %]", data.sequence);
				if(type == "CDS") {
					htmlContent += htmlSequence;
					$.getJSON("subEvidences/"+href.replace("#", ""), "")
					.done(
						function(data) {
							var evidence = {
								id:0,
								type:""
							}
							var component = {
								name:"",
								evidences: []
							};
							var componentsEvidences = new Array();
							var counterComponentsEvidences = 0;
							var evidences = new Array();
							for(i = 0; i < data.subevidences.length; i++) {
								var componentName = data.subevidences[i].program.replace(".pl", "");
								evidence.id = data.subevidences[i].subev_id
								evidence.type = data.subevidences[i].subev_type;
								evidences[i] = evidence;
								
								if($.inArray(componentName, componentsEvidences) == -1) {
									component.name = componentName;
									var htmlEvidence = data.evidencesHtml.content;
									htmlEvidence = htmlEvidence.replace("[% result.componentName %]", componentName);
									htmlEvidence = htmlEvidence.replace("[% result.componentName %]", componentName);
									htmlEvidence = htmlEvidence.replace("[% result.descriptionComponent %]", data.subevidences[i].descriptionProgram);
									htmlContent += htmlEvidence;
									componentsTypes[counterComponentsEvidences] = data.subevidences[i].subev_type;
									componentsEvidences[counterComponentsEvidences] = componentName;
									counterComponentsEvidences++;
								}
							}
							addPanelResult(href, htmlContent);
							
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
		
		/**
		 * criar html para subevidencias
		 * método para pegar subevidencias esta pronto e funcionando
		 * criar função e modelo para função do banco: get_interval_evidence_properties
		 * Em caso de erro interno 500 que refaça a consulta -> gambiarra não funciona, tem q resolver o erro no controller
		 */
		if(data.value == "CDS") {
			
			/**
			 * criar arquivo para saídas de evidencia em paineis de forma padronizada, 
			 * no ID do painel sera necessario definir nome do componente sem a extensão (pq tem '.')-id feature
			 * saída padronizada então o método de consulta de subevidencias vai retornar 1 só html
			 * para cada subevidencia
			 * 		se !$("#"+id do painel do resultado).length > 0 
			 * 			cria painel de evidencia $(id do painel do resultado) 
			 * 		adiciona subevidencias no painel de evidencias (paineis de subevidencias)
			 * 		on click em quada a das subevidencias ele faz consulta json get_similarity_evidence_properties
			 * 		adiciona html dos paineis 
			 * 
			 * perguntar a professora sobre como pegar as propriedades dos intervalos
			 */
		} else if(data.value == "tRNAscan") {

			$.getJSON("getIntervalEvidenceProperties/"+href.replace("#", "")+"/"+data.value, "")
			.done(
				function(data) {
					var properties = data;
					var htmlBasic = properties.htmlBasicResult;
					htmlBasic = htmlBasic.replace("[% result.type %]", properties.type);
					htmlBasic = htmlBasic.replace("[% result.aminoacid %]", properties.aminoacid);
					htmlBasic = htmlBasic.replace("[% result.anticodon %]", properties.anticodon);
					htmlBasic = htmlBasic.replace("[% result.codon %]", properties.codon);
					htmlBasic = htmlBasic.replace("[% result.score %]", properties.score);
					htmlBasic = htmlBasic.replace("[% result.pseudogene %]", properties.pseudogene);
					htmlContent += htmlBasic;
					if(properties.hasOwnProperty("intron")) {
						if(properties.intron == "yes") {
							htmlBasic = properties.htmlHasIntron;
							htmlBasic = htmlBasic.replace("[% result.intron %]", properties.intron);
							htmlBasic = htmlBasic.replace("[% result.coordinatesGene %]", properties.coordinatesGene);
							htmlBasic = htmlBasic.replace("[% result.coordinatesGenome %]", properties.coordinatesGenome);
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
			$.when($.getJSON("getIntervalEvidenceProperties/"+href.replace("#", "")+"/"+data.value, ""))
			.done(
				function(data) {
					var properties = data;
					htmlBasic = properties.htmlBasicResult;
					htmlBasic = htmlBasic.replace("[% result.target_description %]", properties.target_description);
					htmlBasic = htmlBasic.replace("[% result.score %]", properties.score);
					htmlBasic = htmlBasic.replace("[% result.evalue %]", properties.evalue);
					htmlBasic = htmlBasic.replace("[% result.target_identifier %]", properties.target_identifier);
					htmlBasic = htmlBasic.replace("[% result.target_name %]", properties.target_name);
					htmlBasic = htmlBasic.replace("[% result.target_type %]", properties.target_type);
					htmlBasic = htmlBasic.replace("[% result.bias %]", properties.bias);
					htmlBasic = htmlBasic.replace("[% result.truncated %]", properties.truncated);
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
			$.getJSON("getIntervalEvidenceProperties/"+href.replace("#", "")+"/"+data.value, "")
			.done(
				function(data) {
					var properties = data;
					var htmlBasic = properties.htmlBasicResult;
					htmlBasic = htmlBasic.replace("[% result.molecule_type %]", properties.molecule_type);
					htmlBasic = htmlBasic.replace("[% result.score %]", properties.score);
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
	}
	else {
		$(href).removeClass("collapsed");
		$(href).addClass("collapse");
		$(href + " .row").remove();
		$(href + " .sequences").remove();
		$(href).hide();
	}
}

function addPanelResult(href, htmlContent) {
	$(href).append(htmlContent);
	$(href).removeClass("collapse");
	$(href).addClass("collapsed");
	$(href).show();
}

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
