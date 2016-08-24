#!/usr/bin/perl
#
# @File report_html_db.pl
# @Author Wendel Hime Lino Castro
# @Created Jul 19, 2016 10:45:01 AM
#

use strict;
use warnings;
use Getopt::Long;
use Data::Dumper;
use DB_File;
use utf8;
use open qw(:utf8);

#
# ==> BEGIN OF AUTO GENERATED CODE (do not edit!!!)
#
# generateConfigRead.pl version 2.2
#
#
#begin of module configuration
my $print_conf =  <<'CONF';
# Configuration parameters for component (see documentation for details)
# * lines starting with == indicate mandatory parameters, and must be changed to parameter=value
# * parameters containing predefined values indicate component defaults
==organism_name
==fasta_file
html_dir = html_dir
component_name_list=
FT_artemis_dir=
FT_submission_dir=
FT_artemis_selected_dir=
FT_submission_selected_dir=
GFF_dir=
GFF_selected_dir=
aa_fasta_dir=
nt_fasta_dir=
fasta_dir=
blast_dir=
rpsblast_dir=
hmmer_dir=
signalp_dir=
tmhmm_dir=
phobius_dir=
dgpi_dir=
predgpi_dir =
bigpi_dir =
interpro_dir=
eggnog_dir=
cog_dir=
kog_dir=
pathways_dir=
aa_orf_file=
nt_orf_file=
background_image_file=
index_file=
export_subgroup=yes
overwrite_output=yes
report_pathways_dir
report_eggnog_dir
report_cog_dir
report_kog_dir
alienhunter_output_file =
alienhunter_dir = 
infernal_output_file =
infernal_dir = 
rbs_dir =
rnammer_dir = 
transterm_dir = 
tcdb_dir = 
skews_dir =
trf_dir = 
trna_dir = 
string_dir = 
mreps_dir = 
report_go_dir = go_report_dir
report_csv_dir =
csv_file =
go_file
CONF

unless(@ARGV) {
    print $print_conf;
    exit;
}

use strict;
use EGeneUSP::SequenceObject;
use EGeneUSP::Config;
#
#get program version (assumnes CVS)
#
my $version = '$Revision$';
$version =~ s/.*?: ([\d.]+) \$/$1/;#
#mandatory fields
#
my $organism_name;
my $fasta_file;
#
#optional arguments and configuration defaults
#
#####

my $html_dir = "";
my $component_name_list="";
my $FT_artemis_dir="";
my $FT_submission_dir="";
my $FT_artemis_selected_dir="";
my $FT_submission_selected_dir="";
my $GFF_dir="";
my $GFF_selected_dir="";
my $aa_fasta_dir="";
my $nt_fasta_dir="";
#my $xml_dir="xml_dir";
my $fasta_dir="";
my $blast_dir="";
my $rpsblast_dir="";
my $hmmer_dir="";
my $signalp_dir="";
my $tmhmm_dir="";
my $phobius_dir="";
my $dgpi_dir="";
my $predgpi_dir = "";
my $bigpi_dir = "";
my $interpro_dir="";
#my $orthology_dir="";
my $eggnog_dir;
my $cog_dir;
my $kog_dir;
my $orthology_extension="";
my $pathways_dir="";
my $aa_orf_file="";
my $nt_orf_file="";
my $background_image_file="";
my $index_file="";
my $export_subgroup="yes";
my $overwrite_output="yes";
my $report_pathways_dir;
#my $report_orthology_dir;
my $report_eggnog_dir;
my $report_cog_dir;
my $report_kog_dir;
#componentes jota
my $alienhunter_output_file = "";
my $alienhunter_dir = "";
my $infernal_output_file = "";
my $infernal_dir = "";
#my $rbs_output_file = "";
my $rbs_dir = "";
my $rnammer_dir = "";
#my $transterm_output_file = "";
my $transterm_dir = "";
my $tcdb_dir = "";
my $skews_dir = "";
my $trf_dir = "";
my $trna_dir = "";
my $string_dir = "";
my $mreps_dir = "";
my $report_go_dir;
my $go_file;
my $report_csv_dir;
my $csv_file;
#local variables
my @arguments;
my $config;
my $configFile;
my $missingArgument=0;
my $conf;
my $databases_code;
my $databases_dir;

#
#read configuration file
#

my $module=new EGeneUSP::Config($version);

$module->initialize();

$config=$module->config;
#
#check if any mandatory argument is missing
#
if (!exists($config->{"organism_name"})){
    $missingArgument = 1;
    print "Missing mandatory configuration argument:organism_name\n";
}
else {$organism_name = $config->{"organism_name"}};
if (!exists($config->{"fasta_file"})){
}
else {$fasta_file = $config->{"fasta_file"}};
if ($missingArgument) {
    die "\n\nCannot run $0, mandatory configuration argument missing (see above)\n"
}
#
#set optional arguments that were declared in configuration file
#
if (defined($config->{"component_name_list"})){
   $component_name_list = $config->{"component_name_list"};
}
if (defined($config->{"FT_artemis_dir"})){
   $FT_artemis_dir = $config->{"FT_artemis_dir"};
}
else{
   $FT_artemis_dir = undef;
}
if (defined($config->{"FT_submission_dir"})){
   $FT_submission_dir = $config->{"FT_submission_dir"};
}
else{
   $FT_submission_dir = undef;
}
if (defined($config->{"FT_artemis_selected_dir"})){
   $FT_artemis_selected_dir = $config->{"FT_artemis_selected_dir"};
}
else{
   $FT_artemis_selected_dir = undef;
}
if (defined($config->{"html_dir"})){
   $html_dir = $config->{"html_dir"};
}
else{
   $html_dir= "html_dir";
}
if (defined($config->{"FT_submission_selected_dir"})){
   $FT_submission_selected_dir = $config->{"FT_submission_selected_dir"};
}
else{
    $FT_submission_selected_dir = undef;
}
if (defined($config->{"GFF_dir"})){
   $GFF_dir = $config->{"GFF_dir"};
}
else{
   $GFF_dir = undef;
}
if (defined($config->{"GFF_selected_dir"})){
   $GFF_selected_dir = $config->{"GFF_selected_dir"};
}
else{
   $GFF_selected_dir = undef;
}
if (defined($config->{"aa_fasta_dir"})){
   $aa_fasta_dir = $config->{"aa_fasta_dir"};
}
if (defined($config->{"nt_fasta_dir"})){
   $nt_fasta_dir = $config->{"nt_fasta_dir"};
}
if (defined($config->{"fasta_dir"})){
   $fasta_dir = $config->{"fasta_dir"};
}
=pod
if (defined($config->{"blast_dir"})){
   $blast_dir = $config->{"blast_dir"};
}
=cut
if (defined($config->{"rpsblast_dir"})){
   $rpsblast_dir = $config->{"rpsblast_dir"};
}
if (defined($config->{"hmmer_dir"})){
   $hmmer_dir = $config->{"hmmer_dir"};
}
if (defined($config->{"signalp_dir"})){
   $signalp_dir = $config->{"signalp_dir"};
}
if (defined($config->{"tmhmm_dir"})){
   $tmhmm_dir = $config->{"tmhmm_dir"};
}
if (defined($config->{"phobius_dir"})){
   $phobius_dir = $config->{"phobius_dir"};
}
if (defined($config->{"dgpi_dir"})){
   $dgpi_dir = $config->{"dgpi_dir"};
}
if (defined($config->{"predgpi_dir"})){
   $predgpi_dir = $config->{"predgpi_dir"};
}
if (defined($config->{"bigpi_dir"})){
   $bigpi_dir = $config->{"bigpi_dir"};
}
if (defined($config->{"interpro_dir"})){
   $interpro_dir = $config->{"interpro_dir"};
}
if (defined($config->{"eggnog_dir"})){
   $eggnog_dir = $config->{"eggnog_dir"};
}
if (defined($config->{"cog_dir"})){
   $cog_dir = $config->{"cog_dir"};
}
if (defined($config->{"kog_dir"})){
   $kog_dir = $config->{"kog_dir"};
}
if (defined($config->{"report_eggnog_dir"})){
   $report_eggnog_dir = $config->{"report_eggnog_dir"};
}
if (defined($config->{"report_cog_dir"})){
   $report_cog_dir = $config->{"report_cog_dir"};
}
if (defined($config->{"report_kog_dir"})){
   $report_kog_dir = $config->{"report_kog_dir"};
}
if (defined($config->{"pathways_dir"})){
   $pathways_dir = $config->{"pathways_dir"};
}
if (defined($config->{"report_pathways_dir"})){
   $report_pathways_dir = $config->{"report_pathways_dir"};
}
if (defined($config->{"aa_orf_file"})){
   $aa_orf_file = $config->{"aa_orf_file"};
}
if (defined($config->{"nt_orf_file"})){
   $nt_orf_file = $config->{"nt_orf_file"};
}
if (defined($config->{"background_image_file"})){
   $background_image_file = $config->{"background_image_file"};
}
if (defined($config->{"index_file"})){
   $index_file = $config->{"index_file"};
}
else{
   $index_file = "index.html";
}
if (defined($config->{"export_subgroup"})){
   $export_subgroup = $config->{"export_subgroup"};
}
if (defined($config->{"overwrite_output"})){
   $overwrite_output = $config->{"overwrite_output"};
}
#componentes do Jota
if (defined($config->{"alienhunter_output_file"})){
   $alienhunter_output_file = $config->{"alienhunter_output_file"};
}
if (defined($config->{"alienhunter_dir"})){
   $alienhunter_dir = $config->{"alienhunter_dir"};
}
if (defined($config->{"infernal_output_file"})){
   $infernal_output_file = $config->{"infernal_output_file"};
}
if (defined($config->{"infernal_dir"})){
   $infernal_dir= $config->{"infernal_dir"};
}
if (defined($config->{"rbs_dir"})){
   $rbs_dir= $config->{"rbs_dir"};
}
if (defined($config->{"rnammer_dir"})){
   $rnammer_dir= $config->{"rnammer_dir"};
}
if (defined($config->{"transterm_dir"})){
   $transterm_dir= $config->{"transterm_dir"};
}
if (defined($config->{"tcdb_dir"})){
   $tcdb_dir= $config->{"tcdb_dir"};
}
if (defined($config->{"skews_dir"})){
   $skews_dir = $config->{"skews_dir"};
}
if (defined($config->{"trf_dir"})){
   $trf_dir = $config->{"trf_dir"};
}

if (defined($config->{"trna_dir"})){
   $trna_dir = $config->{"trna_dir"};
}

if (defined($config->{"string_dir"})){
   $string_dir = $config->{"string_dir"};
}

if (defined($config->{"mreps_dir"})){
   $mreps_dir = $config->{"mreps_dir"};
}

if (defined($config->{"report_go_dir"})){
   $report_go_dir = $config->{"report_go_dir"};
}

if (defined($config->{"go_file"})){
   $go_file = $config->{"go_file"};
}

if (defined($config->{"database_code_list"})){
   $databases_code = $config->{"database_code_list"};
}

if (defined($config->{"blast_dir_list"})){
   $databases_dir = $config->{"blast_dir_list"};
}
if (defined($config->{"report_csv_dir"})){
   $report_csv_dir = $config->{"report_csv_dir"};
}
if (defined($config->{"csv_file"})){
   $csv_file = $config->{"csv_file"};
}



#
# ==> END OF AUTO GENERATED CODE 
#


###
#
#	Script SQL a ser rodado, necessário instancia nessa parte pois sera realizado concatenações após ler sequencias
#
###

my $scriptSQL = <<SQL;
CREATE TABLE TEXTS (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
	tag VARCHAR(200),
	value VARCHAR(2000),
	details VARCHAR(2000)
);

CREATE TABLE IMAGES (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	tag VARCHAR(200),
	filepath VARCHAR(2000),
	details VARCHAR(2000)
);

CREATE TABLE RELATIONS_TEXTS_IMAGES(
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	idImage INTEGER,
	idText INTEGER,
	FOREIGN KEY(idImage) REFERENCES IMAGES(id),
	FOREIGN KEY(idText) REFERENCES TEXTS(id)
);

CREATE TABLE COMPONENTS(
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,  
	name VARCHAR(2000),
	component VARCHAR(2000),
	filepath VARCHAR(2000)
);

INSERT INTO TEXTS(tag, value, details) VALUES
        ("header-email", "Email:", ""),
        ("header-email-value", "wendelhime\@gmail.com", ""),
        ("header-support", "Support:", ""),
        ("header-support-value", "+55 (13) 99192-9997", ""),
        ("menu", "home", "/home"),
        ("menu", "blast", "/blast"),
        ("menu", "search database", "/searchdatabase"),
        ("menu", "global analyses", "/globalanalyses"),
        ("menu", "downloads", "/downloads"),
        ("menu", "help", "/help"),
        ("menu", "about", "/about"),
        ("footer", "&copy; 2016 YourCompany | By : Wendel Hime", "/#"),
        ("home", "Information", ""),
        ("home-value", "The <i>Photorhabdus luminescens</i> MN7 genome database (<b>PhotoBase</b>) is an integrated resource of genome sequencing and annotation data of the entomopathogenic enterobacterium <i>Photorhabdus luminescens</i> MN7. In addition to sequencing data, <b>PhotoBase</b> provides an organized catalog of functionally annotated predicted protein-coding and RNA genes, in addition to several DNA-based analysis results. The <b>PhotoBase</b> is maintained by the Coccidia Molecular Biology Research Group and the Nematode Molecular Biology Lab at the Institute of Biomedical Sciences, University of São Paulo, Brazil.", ""),
        ("blast-form-title", "Choose program to use and database to search:", ""),
        ("blast-program-title", "Program:", "http://puma.icb.usp.br/blast/docs/blast_program.html"),
        ("blast-program-option", "blastn", ""),
        ("blast-program-option", "blastp", ""),
        ("blast-program-option", "blastx", ""),
        ("blast-program-option", "tblastn", ""),
        ("blast-program-option", "tblastx", ""),
        ("blast-database-title", "Database:", ""),
        ("blast-database-option", "P. luminescens MN7 contigs v. 1.0 (2013-08-01)", "PMN_genome_1"),
        ("blast-database-option", "P. luminescens MN7 genes v. 1.0 (2013-08-01)", "PMN_genes_1"),
        ("blast-database-option", "P. luminescens MN7 proteins v. 1.0 (2013-08-01)", "PMN_prot_1"),
        ("blast-format-title", "Enter sequence below in <a href='http://puma.icb.usp.br/blast/docs/fasta.html'>FASTA</a> format", ""),
        ("blast-sequence-file-title", "Or load it from disk ", ""),
        ("blast-subsequence-title", "Set subsequence ", ""),
        ("blast-subsequence-value", "From:", "QUERY_FROM"),
        ("blast-subsequence-value", "To:", "QUERY_TO"),
        ("blast-search-options-title", "Search options", ""),
        ("blast-search-options-sequence-title", "The query sequence is <a href='http://puma.icb.usp.br/blast/docs/filtered.html'>filtered</a> for low complexity regions by default.", ""),
        ("blast-search-options-filter-title", "Filter:", "http://puma.icb.usp.br/blast/docs/newoptions.html#filter"),
        ("blast-search-options-filter-options", "Low complexity", "value='L' checked=''"),
        ("blast-search-options-filter-options", "Mask for lookup table only", "value='m'"),
        ("blast-search-options-expect", "<a href='http://puma.icb.usp.br/blast/docs/newoptions.html#expect'>Expect</a> (e.g. 1e-6)", ""),
        ("blast-search-options-matrix", "Matrix", "http://puma.icb.usp.br/blast/docs/matrix_info.html"),
        ("blast-search-options-matrix-options", "PAM30", "PAM30	 9	 1"),
        ("blast-search-options-matrix-options", "PAM70", "PAM70	 10	 1"),
        ("blast-search-options-matrix-options", "BLOSUM80", "BLOSUM80	 10	 1"),
        ("blast-search-options-matrix-options", "BLOSUM62", "BLOSUM62	 11	 1"),
        ("blast-search-options-matrix-options", "BLOSUM45", "BLOSUM45	 14	 2"),
        ("blast-search-options-alignment", "Perform ungapped alignment", ""),
        ("blast-search-options-query", "Query Genetic Codes (blastx only)", "http://puma.icb.usp.br/blast/docs/newoptions.html#gencodes"),
        ("blast-search-options-query-options", "Standard (1)", ""),
        ("blast-search-options-query-options", "Vertebrate Mitochondrial (2)", ""),
        ("blast-search-options-query-options", "Yeast Mitochondrial (3)", ""),
        ("blast-search-options-query-options", "Mold Mitochondrial; ... (4)", ""),
        ("blast-search-options-query-options", "Invertebrate Mitochondrial (5)", ""),
        ("blast-search-options-query-options", "Ciliate Nuclear; ... (6)", ""),
        ("blast-search-options-query-options", "Echinoderm Mitochondrial (9)", ""),
        ("blast-search-options-query-options", "Euplotid Nuclear (10)", ""),
        ("blast-search-options-query-options", "Bacterial (11)", ""),
        ("blast-search-options-query-options", "Alternative Yeast Nuclear (12)", ""),
        ("blast-search-options-query-options", "Ascidian Mitochondrial (13)", ""),
        ("blast-search-options-query-options", "Flatworm Mitochondrial (14)", ""),
        ("blast-search-options-query-options", "Blepharisma Macronuclear (15)", ""),
        ("blast-search-options-database", "Database Genetic Codes (tblast[nx] only)", "http://puma.icb.usp.br/blast/docs/newoptions.html#gencodes"),
        ("blast-search-options-database-options", "Standard (1)", ""),
        ("blast-search-options-database-options", "Vertebrate Mitochondrial (2)", ""),
        ("blast-search-options-database-options", "Yeast Mitochondrial (3)", ""),
        ("blast-search-options-database-options", "Mold Mitochondrial; ... (4)", ""),
        ("blast-search-options-database-options", "Invertebrate Mitochondrial (5)", ""),
        ("blast-search-options-database-options", "Ciliate Nuclear; ... (6)", ""),
        ("blast-search-options-database-options", "Echinoderm Mitochondrial (9)", ""),
        ("blast-search-options-database-options", "Euplotid Nuclear (10)", ""),
        ("blast-search-options-database-options", "Bacterial (11)", ""),
        ("blast-search-options-database-options", "Alternative Yeast Nuclear (12)", ""),
        ("blast-search-options-database-options", "Ascidian Mitochondrial (13)", ""),
        ("blast-search-options-database-options", "Flatworm Mitochondrial (14)", ""),
        ("blast-search-options-database-options", "Blepharisma Macronuclear (15)", ""),
        ("blast-search-options-frame-shift-penalty", "<a href='http://puma.icb.usp.br/blast/docs/oof_notation.html'>Frame shift penalty</a> for blastx ", ""),
        ("blast-search-options-frame-shift-penalty-options", "6", ""),
        ("blast-search-options-frame-shift-penalty-options", "7", ""),
        ("blast-search-options-frame-shift-penalty-options", "8", ""),
        ("blast-search-options-frame-shift-penalty-options", "9", ""),
        ("blast-search-options-frame-shift-penalty-options", "10", ""),
        ("blast-search-options-frame-shift-penalty-options", "11", ""),
        ("blast-search-options-frame-shift-penalty-options", "12", ""),
        ("blast-search-options-frame-shift-penalty-options", "13", ""),
        ("blast-search-options-frame-shift-penalty-options", "14", ""),
        ("blast-search-options-frame-shift-penalty-options", "15", ""),
        ("blast-search-options-frame-shift-penalty-options", "16", ""),
        ("blast-search-options-frame-shift-penalty-options", "17", ""),
        ("blast-search-options-frame-shift-penalty-options", "18", ""),
        ("blast-search-options-frame-shift-penalty-options", "19", ""),
        ("blast-search-options-frame-shift-penalty-options", "20", ""),
        ("blast-search-options-frame-shift-penalty-options", "25", ""),
        ("blast-search-options-frame-shift-penalty-options", "30", ""),
        ("blast-search-options-frame-shift-penalty-options", "50", ""),
        ("blast-search-options-frame-shift-penalty-options", "1000", ""),
        ("blast-search-options-other-advanced-options", "Other advanced options:", "http://puma.icb.usp.br/blast/docs/full_options.html"),
        ("blast-display-options-title", "Display options", ""),
        ("blast-display-options-graphical-overview", "Graphical Overview", "http://puma.icb.usp.br/blast/docs/newoptions.html#graphical-overview"),
        ("blast-display-options-alignment-view-title", "Alignment view", "http://puma.icb.usp.br/blast/docs/options.html#alignmentviews"),
        ("blast-display-options-alignment-view-options", "Pairwise", "0"),
        ("blast-display-options-alignment-view-options", "master-slave with identities", "1"),
        ("blast-display-options-alignment-view-options", "master-slave without identities", "2"),
        ("blast-display-options-alignment-view-options", "flat master-slave with identities", "3"),
        ("blast-display-options-alignment-view-options", "flat master-slave without identities", "4"),
        ("blast-display-options-alignment-view-options", "BLAST XML", "7"),
        ("blast-display-options-alignment-view-options", "Hit Table", "9"),
        ("blast-display-options-descriptions", "Descriptions", "http://puma.icb.usp.br/blast/docs/newoptions.html#descriptions"),
        ("blast-display-options-descriptions-options", "0", ""),
        ("blast-display-options-descriptions-options", "10", ""),
        ("blast-display-options-descriptions-options", "50", ""),
        ("blast-display-options-descriptions-options", "100", "selected"),
        ("blast-display-options-descriptions-options", "250", ""),
        ("blast-display-options-descriptions-options", "500", ""),
        ("blast-display-options-alignments", "Alignments", "http://puma.icb.usp.br/blast/docs/newoptions.html#alignments"),
        ("blast-display-options-alignments-options", "0", ""),
        ("blast-display-options-alignments-options", "10", ""),
        ("blast-display-options-alignments-options", "50", "selected"),
        ("blast-display-options-alignments-options", "100", ""),
        ("blast-display-options-alignments-options", "250", ""),
        ("blast-display-options-alignments-options", "500", ""),
        ("blast-display-options-color-schema", "Color schema", "http://puma.icb.usp.br/blast/docs/color_schema.html"),
        ("blast-display-options-color-schema-options", "No color schema", "selected value='0'"),
        ("blast-display-options-color-schema-options", "Color schema 1", "value='1'"),
        ("blast-display-options-color-schema-options", "Color schema 2", "value='2'"),
        ("blast-display-options-color-schema-options", "Color schema 3", "value='3'"),
        ("blast-display-options-color-schema-options", "Color schema 4", "value='4'"),
        ("blast-display-options-color-schema-options", "Color schema 5", "value='5'"),
        ("blast-display-options-color-schema-options", "Color schema 6", "value='6'"),
        ("blast-button", "Clear sequence", "onclick=""MainBlastForm.SEQUENCE.value = '';MainBlastForm.QUERY_FROM.value = '';MainBlastForm.QUERY_TO.value = '';MainBlastForm.SEQUENCE.focus();"" type=""button"" class='btn btn-default' "),
        ("blast-button", "Search", "type='submit' class='btn btn-primary' "),
        ("search-database-form-title", "Search based on sequences or annotations", ""),
        ("search-database-gene-ids-descriptions-title", "Protein-coding gene IDs and descriptions", ""),
        ("search-database-gene-ids-descriptions-tab", "<a href='#geneIdentifier' data-toggle='tab'>Gene identifier</a>", "class='active'"),
        ("search-database-gene-ids-descriptions-tab", "<a href='#geneDescription' data-toggle='tab'>Gene description</a>", ""),
        ("search-database-gene-ids-descriptions-gene-id", "Gene ID: ", ""),
        ("search-database-gene-ids-descriptions-gene-description", "Description: ", ""),
        ("search-database-gene-ids-descriptions-gene-excluding", "Excluding: ", ""),
        ("search-database-analyses-protein-code-title", "Analyses of protein-coding genes", ""),
        ("search-database-analyses-protein-code-limit", "Limit by term(s) in gene description(optional): ", ""),
        ("search-database-analyses-protein-code-excluding", "Excluding: ", ""),
        ("search-database-analyses-protein-code-tab", "Gene ontology", "#geneOntology"),
        ("search-database-analyses-protein-code-tab", "Transporter classification", "#transporterClassification"),
        ("search-database-analyses-protein-code-tab", "Phobius", "#phobius"),
        ("search-database-analyses-protein-code-tab", "BLAST", "#blast"),
        ("search-database-analyses-protein-code-tab", "RPSBLAST", "#rpsBlast"),
        ("search-database-analyses-protein-code-tab", "KEGG", "#kegg"),
        ("search-database-analyses-protein-code-tab", "Orthology analysis (eggNOG)", "#orthologyAnalysis"),
        ("search-database-analyses-protein-code-tab", "Interpro", "#interpro"),
        ("search-database-analyses-protein-code-not-containing-classification", " not containing Gene Ontology classification", ""),
        ("search-database-analyses-protein-code-search-by-sequence", "Search by sequence identifier of match:", ""),
        ("search-database-analyses-protein-code-search-by-description", "Or by description of match:", ""),
        ("search-database-analyses-protein-code-not-containing-classification-tcdb", " not containing TCDB classification", ""),
        ("search-database-analyses-protein-code-search-by-transporter-identifier", "Search by transporter identifier(e.g. 1.A.3.1.1):", ""),
        ("search-database-analyses-protein-code-search-by-transporter-family", "Or by transporter family(e.g. 3.A.17):", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass", "Or by transporter subclass:", ""),
        ("search-database-analyses-protein-code-search-by-transporter-class", "Or by transporter class:", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "1.A α-Type Channels", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "1.B β-Barrel Porins", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "1.C Pore-Forming Toxins (Proteins and Peptides)", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "1.D Non-Ribosomally Synthesized Channels", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "1.E Holins", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "1.F Vesicle Fusion Pores", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "1.G Viral Fusion Pores", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "1.H Paracellular Channels", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "1.I Membrane-bounded Channels", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "1.J Virion Egress Pyramidal Apertures", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "2.A Porters (uniporters, symporters, antiporters)", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "2.B Nonribosomally synthesized porters", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "2.C Ion-gradient-driven energizers", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "3.A P-P-bond-hydrolysis-driven transporters", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "3.B Decarboxylation-driven transporters", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "3.C Methyltransfer-driven transporters", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "3.D Oxidoreduction-driven transporters", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "3.E Light absorption-driven transporters", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "4.A Phosphotransfer-driven Group Translocators", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "4.B Nicotinamide ribonucleoside uptake transporters", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "4.C Acyl CoA ligase-coupled transporters", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "4.D Polysaccharide Synthase/Exporters", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "5.A Transmembrane Electron Carriers", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "5.B Transmembrane 1-electron transfer carriers", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "8.A Auxiliary transport proteins", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "8.B Ribosomally synthesized protein/peptide toxins/agonists that target channels and carriers", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "8.C Non-ribosomally synthesized toxins that target channels and carriers", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "9.A Recognized transporters of unknown biochemical mechanism", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "9.B Putative transport proteins", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "9.C Functionally characterized transporters lacking identified sequences", ""),
        ("search-database-analyses-protein-code-search-by-transporter-class-option", "1 Channels/Pores", ""),
        ("search-database-analyses-protein-code-search-by-transporter-class-option", "2 Electrochemical Potential-driven Transporters", ""),
        ("search-database-analyses-protein-code-search-by-transporter-class-option", "3 Primary Active Transporters", ""),
        ("search-database-analyses-protein-code-search-by-transporter-class-option", "4 Group Translocators", ""),
        ("search-database-analyses-protein-code-search-by-transporter-class-option", "5 Transmembrane Electron Carriers", ""),
        ("search-database-analyses-protein-code-search-by-transporter-class-option", "8 Accessory Factors Involved in Transport", ""),
        ("search-database-analyses-protein-code-search-by-transporter-class-option", "9 Incompletely Characterized Transport Systems", ""),
        ("search-database-analyses-protein-code-not-containing-phobius", " not containing Phobius results", ""),
        ("search-database-analyses-protein-code-number-transmembrane-domain", "Number of transmembrane domains:", ""),
        ("search-database-analyses-protein-code-number-transmembrane-domain-quantity-or-less", " or less", "value='orLess'"),
        ("search-database-analyses-protein-code-number-transmembrane-domain-quantity-or-more", " or more", "value='orMore'"),
        ("search-database-analyses-protein-code-number-transmembrane-domain-quantity-exactly", " exactly", "value='exact' checked"),
        ("search-database-analyses-protein-code-signal-peptide", "With signal peptide?", ""),
        ("search-database-analyses-protein-code-signal-peptide-option", "yes", "value='sigPyes'"),
        ("search-database-analyses-protein-code-signal-peptide-option", "no", "value='sigPno'"),
        ("search-database-analyses-protein-code-signal-peptide-option", "do not care", "value='sigPwhatever' checked=''"),
        ("search-database-analyses-protein-code-not-containing-classification-blast", " not containing BLAST matches", ""),
        ("search-database-analyses-protein-code-not-containing-classification-rpsblast", " not containing RPSBLAST matches", ""),
        ("search-database-analyses-protein-code-not-containing-classification-kegg", " not containing KEGG pathway matches", ""),
        ("search-database-analyses-protein-code-by-orthology-identifier-kegg", "Search by KEGG orthology identifier:", ""),
        ("search-database-analyses-protein-code-by-kegg-pathway", "Or by KEGG pathway:", ""),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "1,2-Diphenyl substitution family", "07112"),                                                                         
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "2-Oxocarboxylic acid metabolism", "01210"),                                                                          
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Acridone alkaloid biosynthesis", "01058"),                                                                           
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Adherens junction", "04520"),                                                                                        
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "African trypanosomiasis", "05143"),                                                                                  
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Alcoholism", "05034"),                                                                                               
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Allograft rejection", "05330"),                                                                                      
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "alpha-Linolenic acid metabolism", "00592"),                                                                          
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Aminoacyl-tRNA biosynthesis", "00970"),                                                                              
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Aminoglycosides", "07021"),                                                                                          
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Amoebiasis", "05146"),                                                                                               
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Amyotrophic lateral sclerosis (ALS)", "05014"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Anthocyanin biosynthesis", "00942"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Anticonvulsants", "07033"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Antidiabetics", "07051"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Antifungal agents", "07026"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Anti-HIV agents", "07053"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Antineoplastics - agents from natural products", "07042"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Antineoplastics - antimetabolic agents", "07041"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Antineoplastics - protein kinases inhibitors", "07045"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Antirheumatics - DMARDs and biological agents", "07050"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Antiulcer drugs", "07038"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Anxiolytics", "07030"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Arachidonic acid metabolism", "00590"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Arrhythmogenic right ventricular cardiomyopathy (ARVC)", "05412"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Asthma", "05310"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Autoimmune thyroid disease", "05320"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Bacterial chemotaxis", "02030"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Bacterial secretion system", "03070"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Basal transcription factors", "03022"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "B cell receptor signaling pathway", "04662"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Benzodiazepine family", "07117"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Benzoxazinoid biosynthesis", "00402"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "beta-Alanine metabolism", "00410"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Betalain biosynthesis", "00965"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Biosynthesis of 12-, 14- and 16-membered macrolides", "00522"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Biosynthesis of alkaloids derived from ornithine, lysine and nicotinic acid", "01064"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Biosynthesis of alkaloids derived from terpenoid and polyketide", "01066"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Biosynthesis of phenylpropanoids", "01061"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Biosynthesis of plant secondary metabolites", "01060"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Biosynthesis of siderophore group nonribosomal peptides", "01053"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Biosynthesis of type II polyketide backbone", "01056"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Biosynthesis of unsaturated fatty acids", "01040"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Biotin metabolism", "00780"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Bladder cancer", "05219"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Butanoate metabolism", "00650"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Butyrophenone family", "07116"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "C5-Branched dibasic acid metabolism", "00660"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Calcium channel blocking drugs", "07036"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Caprolactam degradation", "00930"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Carbon fixation in photosynthetic organisms", "00710"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Cardiac muscle contraction", "04260"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Catecholamine transferase inhibitors", "07216"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Cell cycle - Caulobacter", "04112"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Cell cycle - yeast", "04111"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Cephalosporins - parenteral agents", "07012"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Chemical carcinogenesis", "05204"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Chloroalkane and chloroalkene degradation", "00625"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Cholinergic and anticholinergic drugs", "07220"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Chronic myeloid leukemia", "05220"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Circadian rhythm - fly", "04711"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Circadian rhythm - plant", "04712"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Clavulanic acid biosynthesis", "00331"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Collecting duct acid secretion", "04966"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Complement and coagulation cascades", "04610"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Cyanoamino acid metabolism", "00460"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Cysteine and methionine metabolism", "00270"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Cytosolic DNA-sensing pathway", "04623"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "D-Arginine and D-ornithine metabolism", "00472"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Degradation of aromatic compounds", "01220"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Dilated cardiomyopathy", "05414"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Diterpenoid biosynthesis", "00904"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Dopamine receptor agonists/antagonists", "07213"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Dorso-ventral axis formation", "04320"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Drug metabolism - other enzymes", "00983"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Eicosanoid receptor agonists/antagonists", "07228"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Endocrine and other factor-regulated calcium reabsorption", "04961"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Endometrial cancer", "05213"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Epstein-Barr virus infection", "05169"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Ether lipid metabolism", "00565"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Fanconi anemia pathway", "03460"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Fatty acid biosynthesis", "00061"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Fatty acid metabolism", "00071"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Fc gamma R-mediated phagocytosis", "04666"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Flavone and flavonol biosynthesis", "00944"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Fluorobenzoate degradation", "00364"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Folate biosynthesis", "00790"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Furan family", "07113"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "GABAergic synapse", "04727"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Gap junction", "04540"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Geraniol degradation", "00281"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Glucocorticoid and meneralocorticoid receptor agonists/antagonists", "07225"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Glutamatergic synapse", "04724"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Glycerolipid metabolism", "00561"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Glycine, serine and threonine metabolism", "00260"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Glycosaminoglycan biosynthesis - chondroitin sulfate / dermatan sulfate", "00532"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Glycosaminoglycan biosynthesis - keratan sulfate", "00533"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Glycosphingolipid biosynthesis - ganglio series", "00604"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Glycosphingolipid biosynthesis - lacto and neolacto series", "00601"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Glyoxylate and dicarboxylate metabolism", "00630"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Graft-versus-host disease", "05332"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Hematopoietic cell lineage", "04640"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Hepatitis C", "05160"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "HIF-1 signaling pathway", "04066"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Hippo signaling pathway", "04390"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Histamine H2/H3 receptor agonists/antagonists", "07227"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "HIV protease inhibitors", "07218"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Homologous recombination", "03440"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Huntington", "05016"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Hypnotics", "07032"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Indole alkaloid biosynthesis", "00901"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Inositol phosphate metabolism", "00562"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Insulin secretion", "04911"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Intestinal immune network for IgA production", "04672"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Isoflavonoid biosynthesis", "00943"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Jak-STAT signaling pathway", "04630"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Leishmaniasis", "05140"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Limonene and pinene degradation", "00903"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Lipoic acid metabolism", "00785"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Local analgesics", "07015"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Long-term potentiation", "04720"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Lysine degradation", "00310"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Macrolides and ketolides", "07020"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "MAPK signaling pathway - fly", "04013"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "MAPK signaling pathway - yeast", "04011"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Measles", "05162"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Melanogenesis", "04916"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Metabolic pathways", "01100"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Methane metabolism", "00680"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Mineral absorption", "04978"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Monoterpenoid biosynthesis", "00902"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "mRNA surveillance pathway", "03015"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Mucin type O-Glycan biosynthesis", "00512"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Naphthalene family", "07114"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Neuroactive ligand-receptor interaction", "04080"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Neurotrophin signaling pathway", "04722"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "N-Glycan biosynthesis", "00510"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Nicotine addiction", "05033"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Nitrogen metabolism", "00910"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "N-Metyl-D-aspartic acid receptor antagonists", "07235"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Non-homologous end-joining", "03450"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Non-small cell lung cancer", "05223"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Novobiocin biosynthesis", "00401"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Olfactory transduction", "04740"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Oocyte meiosis", "04114"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Opioid receptor agonists/antagonists", "07224"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Osteoporosis drugs", "07047"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Other types of O-glycan biosynthesis", "00514"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Oxidative phosphorylation", "00190"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Pancreatic cancer", "05212"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Pantothenate and CoA biosynthesis", "00770"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Pathogenic Escherichia coli infection", "05130"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Penicillin and cephalosporin biosynthesis", "00311"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Pentose and glucuronate interconversions", "00040"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Peptidoglycan biosynthesis", "00550"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Peroxisome proliferator-activated receptor (PPAR) agonists", "07222"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Phagosome", "04145"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Phenylalanine metabolism", "00360"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Phenylpropanoid biosynthesis", "00940"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Phosphonate and phosphinate metabolism", "00440"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Photosynthesis - antenna proteins", "00196"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Phototransduction - fly", "04745"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "PI3K-Akt signaling pathway", "04151"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Plant-pathogen interaction", "04626"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Polyketide sugar unit biosynthesis", "00523"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Potassium channel blocking and opening drugs", "07232"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Primary bile acid biosynthesis", "00120"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Prion diseases", "05020"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Progesterone-mediated oocyte maturation", "04914"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Prostaglandins", "07035"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Proteasome", "03050"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Protein export", "03060"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Proximal tubule bicarbonate reclamation", "04964"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Puromycin biosynthesis", "00231"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Pyruvate metabolism", "00620"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Quinolones", "07014"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Regulation of autophagy", "04140"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Renin-angiotensin system inhibitors", "07217"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Retinoic acid receptor (RAR) and retinoid X receptor (RXR) agonists/antagonists", "07223"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Retrograde endocannabinoid signaling", "04723"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Riboflavin metabolism", "00740"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Ribosome", "03010"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "RIG-I-like receptor signaling pathway", "04622"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "RNA polymerase", "03020"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Salivary secretion", "04970"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Secondary bile acid biosynthesis", "00121"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Serotonergic synapse", "04726"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Sesquiterpenoid and triterpenoid biosynthesis", "00909"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Small cell lung cancer", "05222"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Sodium channel blocking drugs", "07231"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Spliceosome", "03040"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Starch and sucrose metabolism", "00500"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Steroid degradation", "00984"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Stilbenoid, diarylheptanoid and gingerol biosynthesis", "00945"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Styrene degradation", "00643"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Sulfonamide derivatives - hypoglycemic agents", "07018"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Sulfonamide family", "07115"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Sulfur relay system", "04122"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Synthesis and degradation of ketone bodies", "00072"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Taste transduction", "04742"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "T cell receptor signaling pathway", "04660"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Tetracycline biosynthesis", "00253"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "TGF-beta signaling pathway", "04350"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Thyroid cancer", "05216"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Toll-like receptor signaling pathway", "04620"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Toxoplasmosis", "05145"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Tropane, piperidine and pyridine alkaloid biosynthesis", "00960"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Tuberculosis", "05152"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Type I diabetes mellitus", "04940"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Type I polyketide structures", "01052"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Ubiquinone and other terpenoid-quinone biosynthesis", "00130"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Valine, leucine and isoleucine biosynthesis", "00290"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Various types of N-glycan biosynthesis", "00513"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Vasopressin-regulated water reabsorption", "04962"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Vibrio cholerae infection", "05110"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Viral carcinogenesis", "05203"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Vitamin B6 metabolism", "00750"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Wnt signaling pathway", "04310"),
        ("search-database-analyses-protein-code-by-kegg-pathway-options", "Zeatin biosynthesis", "00908"),
        ("search-database-analyses-protein-code-not-containing-classification-eggNOG", " not containing eggNOG matches", ""),
        ("search-database-analyses-protein-code-eggNOG", "Search by eggNOG identifier: ", ""),
        ("search-database-analyses-protein-code-not-containing-classification-interpro", " not containing InterProScan matches", ""),
        ("search-database-analyses-protein-code-interpro", "Search by InterPro identifier: ", ""),
        ("search-database-dna-based-analyses-title", "DNA-based analyses", ""),
        ("search-database-dna-based-analyses-tab", "Contigs", "#contigs"),
        ("search-database-dna-based-analyses-tab", "tRNA", "#trna"),
        ("search-database-dna-based-analyses-tab", "Tandem repeats", "#tandemRepeats"),
        ("search-database-dna-based-analyses-tab", "Other non-coding RNAs", "#otherNonCodingRNAs"),
        ("search-database-dna-based-analyses-tab", "Ribosomal binding sites", "#ribosomalBindingSites"),
        ("search-database-dna-based-analyses-tab", "Transcriptional terminators", "#transcriptionalTerminators"),
        ("search-database-dna-based-analyses-tab", "Horizontal gene transfers", "#horizontalGeneTransfers"),
        ("search-database-dna-based-analyses-only-contig-title", "Get only contig: ", ""),
        ("search-database-dna-based-analyses-only-contig", "contig00028", ""),
        ("search-database-dna-based-analyses-only-contig", "contig00044", ""),
        ("search-database-dna-based-analyses-only-contig", "contig00045", ""),
        ("search-database-dna-based-analyses-only-contig", "contig00046", ""),
        ("search-database-dna-based-analyses-only-contig", "contig00053", ""),
        ("search-database-dna-based-analyses-only-contig", "contig00060", ""),
        ("search-database-dna-based-analyses-only-contig", "contig00076", ""),
        ("search-database-dna-based-analyses-only-contig", "contig00078", ""),
        ("search-database-dna-based-analyses-only-contig", "contig00086", ""),
        ("search-database-dna-based-analyses-only-contig", "contig00089", ""),
        ("search-database-dna-based-analyses-only-contig", "contig00093", ""),
        ("search-database-dna-based-analyses-only-contig", "contig_1.2", ""),
        ("search-database-dna-based-analyses-only-contig", "contig_1.3", ""),
        ("search-database-dna-based-analyses-only-contig", "contig_1.7", ""),
        ("search-database-dna-based-analyses-only-contig", "contig_2.1", ""),
        ("search-database-dna-based-analyses-only-contig", "contig_2.2", ""),
        ("search-database-dna-based-analyses-only-contig", "contig_2.3", ""),
        ("search-database-dna-based-analyses-only-contig", "contig_2.4", ""),
        ("search-database-dna-based-analyses-only-contig", "contig_2.5", ""),
        ("search-database-dna-based-analyses-from-base", " from base ", ""),
        ("search-database-dna-based-analyses-to", " to ", ""),
        ("search-database-dna-based-analyses-reverse-complement", " reverse complement?", ""),
        ("search-database-dna-based-analyses-list-rnas", " List all tRNAs", ""),
        ("search-database-dna-based-analyses-get-by-amino-acid", "Or get tRNAs by amino acid: ", ""),
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Alanine (A)", "Ala"),                                                                                                
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Arginine (R)", "Arg"),                                                                                               
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Asparagine (N)", "Asp"),                                                                                             
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Aspartic acid (D)", "Ala"),                                                                                          
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Cysteine (C)", "Cys"),                                                                                               
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Glutamic acid (E)", "Glu"),                                                                                          
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Glutamine (Q)", "Gln"),                                                                                              
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Glycine (G)", "Gly"),                                                                                                
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Histidine (H)", "His"),                                                                                              
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Isoleucine (I)", "Ile"),
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Leucine (L)", "Leu"),
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Lysine (K)", "Lys"),
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Methionine (M)", "Met"),
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Phenylalanine (F)", "Phe"),
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Proline (P)", "Pro"),
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Serine (S)", "Ser"),
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Threonine (T)", "Thr"),
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Tryptophan (W)", "Trp"),
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Tyrosine (Y)", "Tyr"),
        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Valine (V)", "Val");

INSERT INTO TEXTS(tag, value, details) VALUES 
        ("search-database-dna-based-analyses-get-by-codon", "Or get tRNAs by codon: ", ""),
        ("search-database-dna-based-analyses-get-by-codon-options", "AAA", "AAA"),                                                                                                             
        ("search-database-dna-based-analyses-get-by-codon-options", "AAC", "AAC"),                                                                                                             
        ("search-database-dna-based-analyses-get-by-codon-options", "AAG", "AAG"),                                                                                                             
        ("search-database-dna-based-analyses-get-by-codon-options", "AAT", "AAT"),                                                                                                             
        ("search-database-dna-based-analyses-get-by-codon-options", "ACA", "ACA"),                                                                                                             
        ("search-database-dna-based-analyses-get-by-codon-options", "ACC", "ACC"),                                                                                                             
        ("search-database-dna-based-analyses-get-by-codon-options", "ACG", "ACG"),                                                                                                             
        ("search-database-dna-based-analyses-get-by-codon-options", "ACT", "ACT"),                                                                                                             
        ("search-database-dna-based-analyses-get-by-codon-options", "AGA", "AGA"),                                                                                                             
        ("search-database-dna-based-analyses-get-by-codon-options", "AGC", "AGC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "AGG", "AGG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "AGT", "AGT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "ATA", "ATA"),
        ("search-database-dna-based-analyses-get-by-codon-options", "ATC", "ATC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "ATG", "ATG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "ATT", "ATT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CAA", "CAA"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CAC", "CAC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CAG", "CAG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CAT", "CAT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CCA", "CCA"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CCC", "CCC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CCG", "CCG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CCT", "CCT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CGA", "CGA"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CGC", "CGC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CGG", "CGG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CGT", "CGT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CTA", "CTA"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CTC", "CTC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CTG", "CTG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "CTT", "CTT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GAA", "GAA"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GAC", "GAC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GAG", "GAG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GAT", "GAT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GCA", "GCA"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GCC", "GCC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GCG", "GCG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GCT", "GCT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GGA", "GGA"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GGC", "GGC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GGG", "GGG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GGT", "GGT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GTA", "GTA"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GTC", "GTC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GTG", "GTG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "GTT", "GTT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TAC", "TAC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TAT", "TAT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TCA", "TCA"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TCC", "TCC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TCG", "TCG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TCT", "TCT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TGC", "TGC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TGG", "TGG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TGT", "TGT"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TTA", "TTA"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TTC", "TTC"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TTG", "TTG"),
        ("search-database-dna-based-analyses-get-by-codon-options", "TTT", "TTT"),
        ("search-database-dna-based-analyses-tandem-repeats", "Get all tandem repeats that: ", ""),
        ("search-database-dna-based-analyses-contain-sequence-repetition-unit", "Contain the sequence in the repetition unit:", ""),
        ("search-database-dna-based-analyses-repetition-unit-bases", "Has repetition units of bases: ", ""),
        ("search-database-dna-based-analyses-occours-between", "Occurs between ", ""),
        ("search-database-dna-based-analyses-occours-between-and", "and", ""),
        ("search-database-dna-based-analyses-occours-between-and-times", "times", ""),
        ("search-database-dna-based-analyses-tandem-repeats-note", "NOTE: to get an exact number of repetitions, enter the same number in both boxes (numbers can have decimal places). Otherwise, to get 5 or more repetitions, enter 5 in the first box and nothing in the second; for 5 or less repetitions, enter 5 in the second box and nothing in the first. See the 'Help' section for further instructions.", ""),
        ("search-database-dna-based-analyses-search-ncrna-by-target-identifier", "Search ncRNA by target identifier: ", ""),
        ("search-database-dna-based-analyses-or-by-evalue-match", "Or by E-value of match: ", ""),
        ("search-database-dna-based-analyses-or-by-target-name", "Or by target name: ", ""),
        ("search-database-dna-based-analyses-or-by-target-class", "Or by target class: ", ""),
        ("search-database-dna-based-analyses-or-by-target-class-options", "antisense_RNA", "antisense_RNA"),                                                                                   
        ("search-database-dna-based-analyses-or-by-target-class-options", "hammerhead_ribozyme", "hammerhead_ribozyme"),                                                                       
        ("search-database-dna-based-analyses-or-by-target-class-options", "miRNA", "miRNA"),                                                                                                   
        ("search-database-dna-based-analyses-or-by-target-class-options", "other", "other"),                                                                                                   
        ("search-database-dna-based-analyses-or-by-target-class-options", "ribozyme", "ribozyme"),                                                                                             
        ("search-database-dna-based-analyses-or-by-target-class-options", "RNase_MRP_RNA", "RNase_MRP_RNA"),                                                                                   
        ("search-database-dna-based-analyses-or-by-target-class-options", "RNase_P_RNA", "RNase_P_RNA"),                                                                                       
        ("search-database-dna-based-analyses-or-by-target-class-options", "snoRNA", "snoRNA"),                                                                                                 
        ("search-database-dna-based-analyses-or-by-target-class-options", "snRNA", "snRNA"),                                                                                                   
        ("search-database-dna-based-analyses-or-by-target-class-options", "SRP_RNA", "SRP_RNA"),
        ("search-database-dna-based-analyses-or-by-target-class-options", "telomerase_RNA", "telomerase_RNA"),
        ("search-database-dna-based-analyses-or-by-target-class-options", "vault_RNA", "vault_RNA"),
        ("search-database-dna-based-analyses-or-by-target-type", "Or by target type: ", ""),
        ("search-database-dna-based-analyses-or-by-target-description", "Or by target description: ", ""),
        ("search-database-dna-based-analyses-ribosomal-binding", "Search ribosomal binding sites containing sequence pattern: ", ""),
        ("search-database-dna-based-analyses-or-search-all-ribosomal-binding-shift", " Or search for all ribosomal binding site predictions that recommend a shift in start codon position", ""),
        ("search-database-dna-based-analyses-or-search-all-ribosomal-binding-options", " upstream", "value='neg' checked"),
        ("search-database-dna-based-analyses-or-search-all-ribosomal-binding-options", " downstream", "value='pos'"),
        ("search-database-dna-based-analyses-or-search-all-ribosomal-binding-options", " either", "value='both'"),
        ("search-database-dna-based-analyses-or-search-all-ribosomal-binding-start", "Or search for all ribosomal binding site predictions that recommend a change of  start codon", ""),
        ("search-database-dna-based-analyses-transcriptional-terminators-confidence-score", "Get transcriptional terminators with confidence score: ", ""),
        ("search-database-dna-based-analyses-or-hairpin-score", "Or with hairpin score: ", ""),
        ("search-database-dna-based-analyses-or-tail-score", "Or with tail score: ", ""),
        ("search-database-dna-based-analyses-hairpin-note", "NOTE: hairpin and tail scores are negative.", ""),
        ("search-database-dna-based-analyses-predicted-alienhunter", "Get predicted AlienHunter regions of length: ", ""),
        ("search-database-dna-based-analyses-or-get-regions-score", "Or get regions of score: ", ""),
        ("search-database-dna-based-analyses-or-get-regions-threshold", "Or get regions of threshold: ", ""),
        ("search-database-dna-based-analyses-footer", "Search categories in the DNA-based analyses are <b>not</b> additive, i.e. only the category whose ""Search"" button has been pressed will be searched.", ""),
        ("global-analyses-go-terms-mapping", "GO terms mapping", ""),
        ("global-analyses-expansible-tree", "Expansible tree", "data/GO_mapping.xml"),
        ("global-analyses-table-ontologies", "Table of ontologies", "data/GO_mapping.html"),
        ("global-analyses-go-terms-mapping-footer", "NOTE: Please use Mozilla Firefox, Safari or Opera browser to visualize the expansible trees. If you are using Internet Explorer, please use the links to ""Table of ontologies"" to visualize the results.", ""),
        ("global-analyses-eggNOG", "eggNOG", ""),
        ("global-analyses-orthology-analysis-classes", "Orthology analysis by evolutionary genealogy of genes: Non-supervised Orthologous Groups", "data/MN7_eggnog_report/classes.html"),
        ("global-analyses-kegg-pathways", "KEGG Pathways", ""),
        ("global-analyses-kegg-report", "Enzyme by enzyme report of KEGG results", "data/MN7_kegg_report/classes.html"),
        ("global-analyses-kegg-report-page", "Map by map report of KEGG results", "data/MN7_kegg_global/html_page/classes.html"),
        ("global-analyses-comparative-metabolic-reconstruction", "Comparative Metabolic Reconstruction", ""),
        ("global-analyses-comparative-metabolic-reconstruction-topics", "<i>P. luminescens</i> MN7 versus <i>P. asymbiotica</i> ATCC43949</a><br /> (in yellow or red, enzymes found only in either MN7 or <i>P. asymbiotica</i>, respectively; in green, those found in both)", "data/MN7_X_Pasym/html_page/classes.html"),
        ("global-analyses-comparative-metabolic-reconstruction-topics", "<i>P. luminescens</i> MN7 versus <i>P. luminescens</i> TT01</a><br /> (in yellow or dark blue, enzymes found only in either MN7 or TT01, respectively; in green, those found in both)", "data/MN7_X_TT01/html_page/classes.html"),
        ("downloads-genes", "Genes", ""),
        ("downloads-genes-links", "All genes (protein-coding, ribosomal RNA, transfer RNA, and non-coding RNA)", "/cgi-bin/getPMN.cgi?t=ag"),
        ("downloads-genes-links", "Protein-coding genes only", "/cgi-bin/getPMN.cgi?t=pcg"),
        ("downloads-genes-links", "All protein sequences", "/cgi-bin/getPMN.cgi?t=pro"),
        ("downloads-genes-links", "Ribosomal RNA genes only", "/cgi-bin/getPMN.cgi?t=rrg"),
        ("downloads-genes-links", "Transfer RNA genes only", "/cgi-bin/getPMN.cgi?t=trg"),
        ("downloads-genes-links", "Other non-coding RNA genes only", "/cgi-bin/getPMN.cgi?t=oncg"),
        ("downloads-other-sequences", "Other sequences", ""),
        ("downloads-other-sequences-links", "Get all contigs", "/cgi-bin/getPMN.cgi?t=ac"),
        ("downloads-other-sequences-links", "All intergenic regions (sequences that are not a protein-coding, ribosomal RNA, transfer RNA, or non-coding RNA gene)", "/cgi-bin/getPMN.cgi?t=ig"),
        ("downloads-other-sequences-links", "All regions identified as possible lateral transfer (predicted by AlienHunter)", "/cgi-bin/getPMN.cgi?t=ah"),
        ("downloads-other-sequences-links", "All transcriptional terminators (predicted by TransTermHP)", "/cgi-bin/getPMN.cgi?t=tt"),
        ("downloads-other-sequences-links", "All ribosomal binding sites (predicted by RBSfinder)", "/cgi-bin/getPMN.cgi?t=rbs"),
        ("help-questions-feedback", "Questions and feedback", ""),
        ("help-questions-feedback-1-paragraphe", "If you have any question or would like to communicate any error, please contact us:", ""),
        ("help-questions-feedback-2-list-1", "Carlos E. Winter - <a href='mailto:cewinter\@usp.br'>cewinter\@usp.br</a>", ""),
        ("help-questions-feedback-2-list-2", "Arthur Gruber - <a href='mailto:argruber\@usp.br'>argruber\@usp.br</a>", ""),
        ("help-table-contents", "Table of contents", ""),
        ("help-table-contents-1", "1. Introduction", "help_1"),                                                                                                                                
        ("help-table-contents-2", "2. BLAST", "help_2"),                                                                                                                                       
        ("help-table-contents-3", "3. Search database", "help_3"),                                                                                                                             
        ("help-table-contents-3-0", "3.0. Factors affecting database search speed", "help_3.0"),                                                                                                 
        ("help-table-contents-3-0-1", "3.0.1. Amount of results", "help_3.0.1"),                                                                                                                   
        ("help-table-contents-3-0-2", "3.0.2. Specificity of search", "help_3.0.2"),                                                                                                               
        ("help-table-contents-3-0-3", "3.0.3. Complexity of search", "help_3.0.3"),                                                                                                                
        ("help-table-contents-3-1", "3.1. Protein-coding gene IDs and descriptions", "help_3.1"),                                                                                                
        ("help-table-contents-3-1-1", "3.1.1. Gene identifier", "help_3.1.1"),                                                                                                                     
        ("help-table-contents-3-1-2", "3.1.2. Gene description", "help_3.1.2"),
        ("help-table-contents-3-2", "3.2. Analyses of protein-coding genes", "help_3.2"),
        ("help-table-contents-3-2-1", "3.2.1. Excluding criteria", "help_3.2.1"),
        ("help-table-contents-3-2-2", "3.2.2. Search criterion precedence", "help_3.2.2"),
        ("help-table-contents-3-2-3", "3.2.3. Filtering by description keyword(s)", "help_3.2.3"),
        ("help-table-contents-3-3", "3.3. DNA-based analyses", "help_3.3"),
        ("help-table-contents-3-3-1", "3.3.1. Contig sequences", "help_3.3.1"),
        ("help-table-contents-3-3-2", "3.3.2. Other analysis results", "help_3.3.2"),
        ("help-table-contents-4", "4. Global analyses", "help_4"),
        ("help-table-contents-4-1", "4.1. GO term mapping", "help_4.1"),
        ("help-table-contents-4-1-1", "4.1.1. Expansible trees", "help_4.1.1"),
        ("help-table-contents-4-1-2", "4.1.2. Table of ontologies", "help_4.1.2"),
        ("help-table-contents-4-2", "4.2. eggNOG - evolutionary genealogy of genes: Non-supervised Orthologous Groups", "help_4.2"),
        ("help-table-contents-4-3", "4.3. KEGG Pathways", "help_4.3"),
        ("help-table-contents-5", "5. Download", "help_5"),
        ("help-table-contents-5-1", "5.1. Annotation files", "help_5.1"),
        ("help-table-contents-5-2", "5.2. Nucleotide sequences", "help_5.2"),
        ("help-table-contents-5-3", "5.3. Aminoacid sequences", "help_5.3"),
        ("help-table-contents-5-4", "5.4. Other DNA sequences", "help_5.4"),
        ("help-table-contents-6", "6. Some known issues", "help_6"),
        ("help_1-0-paragraph", "This help page describes the data and services available at the <i>P. luminescens</i> MN7 site. Roche 454 sequencing data (shotgun and paired-end libraries) were assembled by Newbler v. 2.7 and assemblies were extended using GeneSeedHMM (an unpublished update of the <a href='http://www.coccidia.icb.usp.br/genseed/'>GenSeed</a> program) and manual verification. 
                                        The assembled contigs were then submitted to an EGene2 (an unpublished update of the <a href='http://www.coccidia.icb.usp.br/egene/'>EGene</a> platform) pipeline for comprehensive sequence annotation.
                                        The pipeline consisted in finding all protein-coding (using Glimmer3), transfer RNA (tRNAscan-SE), ribosomal RNA (RNAmmer), and other non-coding (Infernal + RFAM) genes. 
                                        Translated protein-coding gene sequences were then submitted to a number of analyses, namely sequence similarity (BLAST versus NR), protein domains (RPS-BLAST versus CDD), protein motifs (InterProScan versus all included databases), transmembrane domains and signal peptide (Phobius), and transporter classification (TCDB). 
                                        Using InterPro IDs, we mapped and quantified GO terms using a GO Slim file. <a href='http://eggnog.embl.de/version_3.0/'>eggNOG</a> orthology mapping and <a href='http://www.genome.jp/kegg/'>KEGG</a> pathway mapping were also performed with <a href='http://www.coccidia.icb.usp.br/egene/'>EGene2</a> components.
                                        Finally, DNA sequence-based analyses have also been performed, including searching for regions possibly originated from horizontal gene transfer (by AlienHunter), transcriptional terminators (TransTermHP), ribosomal binding sites (RBSfinder), and GC compositional skew (using an EGene2 component).", ""),
        ("help_1-1-paragraph", "The following sections describe how to:", ""),
        ("help_1-2-list-1", "perform BLAST searches on a number of sequences from <i>P. luminescens</i> MN7", ""),                                                                                                                         
        ("help_1-2-list-2", "search for genes based on their identifiers or product description", ""),                                                                                       
        ("help_1-2-list-3", "search for genes based on characteristics of their annotations", ""),                                                                                           
        ("help_1-2-list-4", "search for other", ""),                                                                                                                                         
        ("help_1-2-list-5", "download bulk data", ""),
        ("help_2-0-paragraph", "A BLAST service is available and searches can be performed against one of three <i>P. luminescens</i> MN7 databases: genomic DNA (contigs), predicted genes, or translated protein-coding genes. BLAST programs to be used are BLASTN, TBLASTN, or TBLASTX (for the first two databases) and BLASTP or BLASTX (for the third database).", ""),
        ("help_2-1-paragraph", "Our BLAST search page is mostly the same as the standard one formerly distributed with the legacy <i>www-blast</i> package, and is therefore familiar to most users. We have made small cosmetic adjustments, the most significant of which being the way in which the E-value cutoff (""Expect"" field in the page) can be entered. Our BLAST page allows for any E-value cutoff, while the original BLAST page contained a dropdown list with six different predetermined values. In our text box, any numeric value can be entered directly, using the syntax 1e-10 for E-values with an exponent.", ""),
        ("help_2-2-paragraph", "<font color='red'>[to be implemented]</font> Links to the GBrowse genome browser are included in the BLAST search results, both linking to the region matched (click on the link present after the match) and to the whole sequence where the match occurred (click on contig or gene name). Retrieval of results for longer sequences might take some time to complete.", ""),
        ("help_3-0-paragraph", "This page allows queries to the <i>P. luminescens</i> MN7 genome database, interrogating either gene identifiers, gene product descriptions, and results from all programs used by EGene2 to collect annotation evidence. It is also possible to retrieve contig sequences, or a user-specified subsubquence, with the option of reversing and complementing the sequence returned.", ""),
        ("help_3-1-paragraph", "Reflecting this variety of possible search strategies, the database search page is divided in three main sections. And each section is in turn divided in subsections, all of which are described in more detail below. But first, a word on search speed.", ""),
        ("help_3-2-title", "3.0. Factors affecting database search speed.", "help_3.0"),
        ("help_3-3-paragraph", "The PhotoBase database search capabilities are based on a <a href='http://gmod.org/wiki/Chado_-_Getting_Started'>Chado</a> database (<a href='http://www.ncbi.nlm.nih.gov/pubmed/17646315'>Mungall et al., 2007</a>), which is a generic and powerful database schema for biological sequence-related information. With generality and power, comes complexity. Therefore, some queries to the database can become quite large and slow, depending on a number of factors. While it is hard to accurately predict how long a query will take, we have observed a number of simple, general characteristics of a search that usually correlate to longer waiting times. The main such characteristics are:", ""),
        ("help_3-4-list-1", "Number of genes (or other records) returned by a query – the more genes, the longer the time", ""),
        ("help_3-4-list-2", "The specificity of the query – the more specific the query, the shorter the time", ""),
        ("help_3-4-list-3", "Complexity of the search – the more complex the query, the longer the time", ""),
        ("help_3-5-title", "3.0.1 Amount of results", "help_3.0.1"),
        ("help_3-6-paragraph", "The first factor, the approximate number of genes retrieved, might not always be knowable in advance. But many times it is possible to control. The most obvious example is a search for gene identifiers; a search for ""PMN_000"" will be much faster than one for ""PMN_"" – which will actually retrieve <b>all</b> genes and will take several minutes to complete. This is valid for comparably complex searches (see below).", ""),
        ("help_3-7-title", "3.0.2 Specifility of search", "help_3.0.2"),
        ("help_3-8-paragraph", "The second factor is somewhat related to the first, since more specific queries will be much more likely to return less genes than less specific ones. Therefore, searching for genes whose proteins have exactly 6 transmembrane domains predicted by Phobius, for example, will be usually faster than searching for those that have 6 or more TM domains. Another example, a search for a very common (i.e., less specific) description keyword will also return more genes and therefore take longer to complete than a search for a more rare and specific keyword.", ""),
        ("help_3-9-title", "3.0.3 Complexity of search", "help_3.0.2"),
        ("help_3-10-paragraph", "And finally, the complexity of the query also directly affects the time needed for a query to complete – the more complex the query, i.e the more criteria chosen to restrict the returned results, the longer the query will usually take to complete. That happens specially when performing searches in the ""Analyses of protein-coding genes"" section. Due to the way the database is structure, each criterion used in the search (e.g. KEGG, eggNOG, description, etc.) actually requires the equivalent of one database search, and then the different searches get combined to yield the final results. The search can be complex enough that it will take about a minute and return no genes at all, given how strict the requirements became – after all, only genes that meet all of them will be returned, and the likelihood of finding a gene diminishes with the more criteria chosen. As can be seen, this contradicts the first factor, since a search for less genes is taking longer.", ""),
        ("help_3-11-paragraph", "Therefore, when tuning searches, please take these factors into account when getting too many (or few) results, or when the search takes too long to complete. Also, try different combinations; given the complexity of the database and of the interactions between database tables, sometimes a more complex search can actually be faster than a less complex one. It is hard to know in advance when that will be the case, so testing the possibilities is the best practice when in doubt.", ""),
        ("help_3-12-title", "3.1 Protein-coding gene IDs and descriptions ", "help_3.1"),
        ("help_3-13-title", "3.1.1 Gene identifier ", "help_3.1.1"),
        ("help_3-14-paragraph", "If the user already knows the sequence ID, then the corresponding annotation can be directly retrieved from the <b>Gene identifier</b> section. For instance, PMN_0003 is a valid ID of a <i>P. luminescens</i> MN7 sequence. It is also possible to retrieve multiple genes by using partial identifiers. If one enters PMN_000 in the search field, for example, all genes whose identifiers start with PMM_000 will be retrieved, i.e genes PMN_0001 to PMN_0009.", ""),
        ("help_3-15-title", "3.1.2 Gene description ", "help_3.1.2"),
        ("help_3-16-paragraph", "In the next section, <b>Gene description</b>, the user can also enter one or more keywords to perform the search based on the text of each gene's product description. Entering more than one keyword will result in an OR-search, i.e the retrieved genes will contain one keyword, or the other, or the other (or more than one of them). For example, if the search was ""protease serine"", genes retrived could contain any or all of the terms ""protease"" and ""serine"" in their description. It is also possible to use partial words to match multiple terms. For example: searching for ""transp"" will match descriptions containing ""transporter"", ""transparent"", ""transport"", etc.", ""),
        ("help_3-17-paragraph", "The two boxes allow searches that require either presence (first box, labeled <i>""Description containing:""</i>) or absence (second box, labeled <i>""Excluding:""</i>) of terms in the description. Using only the first box retrieves genes containing the terms entered; using only the second one retrieves all genes that do not contain the term entered.", ""),
        ("help_3-18-paragraph", "Additionallly, the two boxes can be used in combination, performing an AND-search. As an example, the search could consist of entering ""protease"" in the first box and ""serine"" in the second one. In this case, the retrieved genes should contain ""protease"", but never ""serine"", in the description.", ""),
        ("help_3-19-title", "3.2 Analyses of protein-coding genes", "help_3.2"),
        ("help_3-20-paragraph", "In this section, it is possible to search the database of <i>P. luminescens</i> MN7 gene annotations using an enormous number of combinations. The different subsections can be combined in an AND-search, i.e. the retrieved genes will have to possess all characteristics specified in all the subsections filled. For example: specifying a KEGG pathway, a BLAST result containing the term ""kinase"", and a signal peptide (in Phobius) will retrieve only genes that belong to the pathway <b>and</b> have ""kinase"" in the BLAST hit description <b>and</b> had a signal peptide predicted by Phobius.", ""),
        ("help_3-21-paragraph", "As mentioned above, searches in this section are additive, which means that the criteria in all subsections chosen during a search must be met for a gene to be retrieved. To reflect this fact, there is only one ""Search"" button for the whole section, located at the bottom. So if a search specifies criteria for eggNOG, InterPro, and transporter classification analyses, for example, only genes that meet the eggNOG <b>and</b> InterPro <b>and</b> transporter classification requirements used will appear in the results table. As explained in <a href='#help_3.0'>3.0 Factors affecting database search speed</a> above, the more subsections are chosen here, the longer the query will take – and the lower the probability that any genes will be retrieved.", ""),
        ("help_3-22-title", "3.2.1 Excluding criteria", "help_3.2.1"),
        ("help_3-23-paragraph", "It is possible to restrict results to genes that do not possess annotations generated by a certain analyses, by checking the ""not containing *"" box at the top of the corresponding subsection. As an example: a search for all genes that matched kinases in a BLAST search but had no InterPro matches at all would be performed by entering ""kinase"" in the description field of the BLAST subsection, and checking the box labeled ""not containing InterProScan matches"" in the InterPro subsection.", ""),
        ("help_3-24-title", "3.2.2 Excluding criteria", "help_3.2.2"),
        ("help_3-25-paragraph", "In most of the subsections, some search criteria inside of the subsection take precedence over other. When that is the case, the criterion closer to the top has precedence over the ones below it that happened also have been filled with some value. To indicate such cases, the interface displays the alternative criteria with labels starting with ""Or"". When the criteria labels do not start with ""Or"", it means the different criteria will be applied simultaneously, in an AND-search.", ""),
        ("help_3-26-paragraph", "A couple of examples might make the behavior clearer. A search involving criteria related to transporter classification can restrict results by five different criteria, in order of greater to lesser precedence: transporter identifier; family; subclass; class; decription of match in the transporter database. Therefore, if the search specifies a transporter family (e.g. 1.A.3) and a class (3. Active primary transporters), the results will be constrained only by the first criterion chosen.", ""),
        ("help_3-27-paragraph", "Another example would be a search for genes with certain characteristics in their Phobius results, which can be filtered according to number of transmembrane domains predicted and/or status of signal peptide prediction. In this case, no criterion takes precedence over the other – if both are select, then both (and not just the top one) will be taken into account when performing the search.", ""),
        ("help_3-28-paragraph", "For instance, if one selects serine protease in all organisms, choosing the option “Find one of the query terms”, the database will report 365 sequences. Alternatively, if one chooses the option “Find all query terms”, the database will report 287 sequences found for the first term (serine) and 111 sequences for the second term (protease). Since not all products containing serine in their name are proteases (e.g. serine protein kinases), nor all proteases are serine proteases, the database will only report 33 sequences annotated as serine proteases.", ""),
        ("help_3-29-title", "3.2.3 Filtering by description keyword(s)", "help_3.2.3"),
        ("help_3-30-paragraph", "This capability is identical to the one described above in <a href='#help_3.1'>3.1. Protein-coding gene IDs and descriptions</a>, with the fundamental difference that it can be combined with the annotation subsections present after it, while the description keyword search of the ""Gene description"" subsection of the ""Protein-coding gene IDs and descriptions"" section can not.", ""),
        ("help_3-31-paragraph", "Accordingly, if these description keyword boxes are used but no filtering criteria are entered in the annotation subsections, search results will be identical to the same search had it been performed in the ""Gene descrition"" subsection.", ""),
        ("help_3-32-title", "3.3 DNA-based analyses", "help_3.3"),
        ("help_3-33-paragraph", "In this third and final main section of the database search page, it is possible to search for non-protein-coding genes, as well as other DNA-based analysis features from the genome of <i>P. luminescens</i> MN7. Differently from the section for protein-coding gene annotations, in this section searches are <b>not</b> additive; to reflect that, each subsection has its own ""Search"" button. Each subsection is thus independent from the others, and only the one whose ""Search"" button has been pressed will influence the generated results.", ""),
        ("help_3-34-title", "3.3.1 Contig sequences", "help_3.3.1"),
        ("help_3-35-paragraph", "This subsection can be use for the download of full or partial contig sequences, optionally generating the reverse-complement of the sequence. If the intent is to download all contigs without any modification, it is more efficient to go to the ""Downloads"" tab of PhotoBase and choose ""Get all contigs"", from the ""Other sequences"" section.", ""),
        ("help_3-36-paragraph", "The contig to be downloaded can be chosen by name in the dropdown list. Leaving the two text boxes empty will download the full contig sequence. Start and end positions for the sequence retrieved can specified in the boxes labeled ""from base"" and ""to"", and the sequence retrieved will be the reverse-complement of the original if the box ""reverse complement?"" is checked. Please notice that, when providing start and end positions for the sequence, <b>both</b> figures must be entered.", ""),
        ("help_3-37-title", "3.3.2 Other analysis results", "help_3.3.2"),
        ("help_3-38-paragraph", "The other subsections of the ""DNA-based analyses"" section behave in similar ways to the subsections already described for the ""Analyses of protein-coding genes"" section – with the already mentioned fundamental difference that searches are not additive, so one subsection knows nothing about the criteria specified by the other ones.", ""),
        ("help_3-39-paragraph", "Inside each subsection, criteria can be searched in an additive manner or not, depending on the subsection under consideration. As described above, non-additive searches contain criteria with labels starting with ""Or"", while additive searches do not.", ""),
        ("help_3-40-paragraph", "The ""tRNA"" subsection, for example, performs non-additive, OR-searches. Therefore, it is possible to search for tRNA genes based on amino acid encoded <b>or</b> codon in the gene, but not both simultaneously. The ""Tandem repeats"" subsection on the other hand has additive criteria: it is possible to filter by any of the three possible criteria, or any combination of them. One could then search for tandem repeats containing ""ATGGCT"" in the repeat unit, which also have repeat units of 10 bases (exactly, or more, or less), and which have between three and seven repetitions of the repeat unit.", ""),
        ("help_3-41-paragraph", "Notice that the two boxes for the minimum and maximum number of repetitions of the repeat unit can be used individually or in combination. If both boxes are used, the tandem repeat regions retrieved will have a number of repetitions that is equal to the number in the first box or more, but up to (and including) the number in the second. To get <b>all</b> regions with a certain number of repetitions or more without any upper boundary, the cutoff number should be entered in the first box, <i>leaving the second box empty</i>. Conversely, getting those that contain a number of repetitions or less can be done by filling only the second box.", ""),
        ("help_4-0-paragraph", "This section provides both qualitative and quantitative analyses for the whole set of translated products of <i>P. luminescens</i> MN7. Analyses include Gene Ontology (GO) term mapping, orthology functional classification using the eggNOG database, and pathway mapping using KEGG.", ""),
        ("help_4-1-title", "4.1 GO Term Mapping.", ""),
        ("help_4-2-paragraph", "We have mapped all GO terms found, and quantified the distribution of these terms using a GO Slim file. The results are presented in two different formats: expansible trees and tables. As detailed below, some Web browsers might have problems displaying the expansible tree, in which case the table format should be used.", ""),
        ("help_4-3-title", "4.1.1 Expansible Trees.", ""),
        ("help_4-4-paragraph", "Each expansible/collapsible tree is in fact composed of a set of three trees, each one corresponding to an ontology domain. By clicking on the left plus and minus signs, the branches can be expanded or collapsed, respectively. If the user clicks on the GO term itself, its <a href='http://amigo.geneontology.org'>Amigo</a> page is opened, showing the corresponding term description and other details. The links to the right of each GO term provide all sequences whose products have been mapped to this GO term. The list of sequences is then followed by links to the corresponding nucleotide and protein sequences. Also, links to GO terms display all GO terms mapped to the sequence. ", ""),
        ("help_4-5-paragraph", "Note: this format can only be used on Mozilla Firefox, Safari or Opera browsers, since the XML files are not compatible with MS Internet Explorer. For this latter browser we provide another data format, using conventional HTML tables (see below).", ""),
        ("help_4-6-title", "4.1.2 Table of ontologies.", ""),
        ("help_4-7-paragraph", "An alternative for MS Internet Explorer users to visualize the data is to click on the table of ontologies link. In this case, instead of a hierarchical tree, a typical HTML table will be displayed. The information content, however, is exactly the same as described above, but without the hierarchical view.", ""),
        ("help_4-8-title", "4.2. eggNOG - evolutionary genealogy of genes: Non-supervised Orthologous Groups. ", ""),
        ("help_4-9-paragraph", "We have mapped all predicted gene sequences onto the <a href='http://eggnog.embl.de/version_3.0/'>eggNOG v3.0</a> database, a comprehensive and enriched database of orthologous groups, constructed based on data from 1,133 organisms <a href='http://www.ncbi.nlm.nih.gov/pubmed/22096231'>(Powell et al., 2011)</a>. A table displays eggNOG functional categories and the respective numbers of sequences classified in each category. A pie chart also depicts the same information. By clicking on the one-letter code on the table, the user gets access to a page displaying a list of all proteins classified in that category. BLAST alignments and a link to the corresponding functional category information on the eggNOG site are also provided.", ""),
        ("help_4-10-title", "4.3 KEGG Pathways", ""),
        ("help_4-11-paragraph", "We mapped the translated protein sequences onto <a href='http://www.genome.jp/kegg/ko.html'>KEGG Orthology</a> <a href='http://www.ncbi.nlm.nih.gov/pubmed/18025687'>(Aoki-Kinoshita &amp; Kanehisa, 2007)</a> database. Using the identified <a href='http://www.genome.jp/kegg/ko.html'>KEGG Orthology</a> entries (KOs), we mapped the corresponding metabolic pathways. The <a href='http://www.genome.jp/kegg/pathway.html'>KEGG Pathway</a> classes are listed on a table and the respective sequence counts classified in each class are presented. A pie chart also depicts the <a href='http://www.genome.jp/kegg/'>KEGG</a> category distribution. By clicking on a <a href='http://www.genome.jp/kegg/pathway.html'>KEGG Pathway</a> Class link, an expanded list of subclasses is displayed. Each subclass presents the corresponding number of classified sequences and contains a link that opens up a page with the list of proteins (with links to BLAST alignments), Class Pathway IDs, KO descriptions, E.C. numbers and <a href='http://www.genome.jp/kegg/pathway.html'>KEGG pathways</a>. Each pathway link redirects to a page presenting a graphical representation of the corresponding pathway, as generated by <a href='http://www.genome.jp/kegg/'>KEGG</a>. The protein corresponding to the mapped query protein is displayed in a red-labeled box.", ""),
        ("help_5-0-paragraph", "In this section, the user can download annotation files, genes as nucleotide and (when appropriate) amino acid sequences, and other types of DNA sequences. ", ""),
        ("help_5-1-title", "5.1 Annotation files.", ""),
        ("help_5-2-paragraph", "Annotation files of <i>P. luminescens</i> MN7 are available for download in GenBank Feature Table and Extended Feature Table (Artemis-compatible) formats. Annotation data is provided in compressed zip files. Each file contains the complete annotation of the whole set of contigs, including genes of all types plus results from other analyses, e.g. transcriptional terminators, ribosomal binding sites, etc.", ""),
        ("help_5-3-title", "5.2 Nucleotide sequences.", ""),
        ("help_5-4-paragraph", "Nucleotide sequence data in FASTA format are available for download, separated in files for:", ""),
        ("help_5-5-list-1", "All genes (protein-coding, ribosomal RNA, transfer RNA, and non-coding RNA)", ""),
        ("help_5-5-list-2", "Protein-coding genes only", ""),
        ("help_5-5-list-3", "Ribosomal genes only", ""),
        ("help_5-5-list-4", "Transfer RNA genes only", ""),
        ("help_5-5-list-5", "Other ncRNA genes only", ""),
        ("help_5-6-title", "5.3 Aminoacid sequences.", ""),
        ("help_5-7-paragraph", "Translations of all protein-coding genes are available for download in one file.", ""),
        ("help_5-8-title", "5.4 Other DNA sequences.", ""),
        ("help_5-9-paragraph", "In this section,about.html the user can download files containing all <i>P. luminescens</i> MN7 sequences from a certain category:", ""),
        ("help_5-10-list-1", "All contigs", ""),
        ("help_5-10-list-2", "All intergenic regions", ""),
        ("help_5-10-list-3", "All regions identified as potential lateral transfers", ""),
        ("help_5-10-list-4", "All transcriptional terminators", ""),
        ("help_5-10-list-5", "All ribosomal binding sites", ""),
        ("help_6-0-paragraph", "Linking to GBrowse is still not implemented, therefore some links will currently not work.", ""),
        ("help_6-1-paragraph", "Some files still not present for download.", ""),
        ("help_6-2-paragraph", "To be added...", ""),
        ("about-table-content-1", "Project", "about_1"),
        ("about_1-0-paragraph", "Entomopathogenic nematodes (EPNs) live in symbiosis with specific enterobacteria. EPNs have been used for decades to control agricultural pests in the United States and Europe. Bacteria of the genus <i>Photorhabdus</i> are symbionts of EPNs of the genus <i>Heterorhabditis</i>. Recently, <i>Heterorhabditis bacteriophora</i> and its symbiont, <i>Photorhabdus luminescens laumondii</i>, were considered models for the study of host-pathogen interactions. The genome of <i>P. luminescens laumondii</i> TT01 was completely sequenced a few years ago, and it was discovered that six percent of its genes encode enzymes involved in production of secondary metabolites.", ""),
        ("about_1-1-paragraph", "One of the aims of our laboratory is the study of molecular aspects of Brazilian EPN isolates and their bacterial symbionts. Strains of two species of <i>Heterorhabditis</i> (<i>H. baujardi</i> and <i>H. indica</i>), obtained from the Amazon region, were molecularly characterized by us. The bacteria of <i>H. baujardi</i> (strain LPP7) were grown in isolation. Phylogenetic analysis of the 16 S rRNA sequence of this isolate (called MN7) shows that it can be part of the same clade as <i>P. asymbiotica</i>, a species isolated from wounds in humans in Australia and the United States. Recent data from our laboratory showed that MN7 secretes secondary metabolites of biotechnological interest, plus a protease similar to that found in other species of the genus.", ""),
        ("about_1-2-paragraph", "The aim of this project is the construction of a genome scaffold of <i>Photorhabdus luminescens</i> MN7 through next generation sequencing. This project aims to better understand the biology and evolution of bacteria of the genus <i>Photorhabdus</i> and make an inventory, as complete as possible, of the genes involved in the production of secondary metabolites and toxins that mediate symbiotic relationships with the nematode, the insect, and other species of nematodes. This project will be integrated with other projects of the laboratory studying entomopathogenic nematodes and their bacteria and will generate important data for researchers working on these bacteria in other countries.", ""),
        ("about-table-content-2", "Project members", "about_2"),
        ("about-table-content-3", "Photorhabdus", "about_3"),
        ("about-table-content-4", "Funding and citing", "about_4"),
        ("about_2-0-title", "Project coordinators", ""),
        ("about_2-1-list-1", "<a href='mailto:cewinter\@usp.br'>Carlos E. Winter</a>, Ph.D. - Associate Professor, University of São Paulo", ""),
        ("about_2-1-list-2", "<a href='mailto:argruber\@usp.br'>Arthur Gruber</a>, D.V.M., Ph.D. - Associate Professor, University of São Paulo", ""),
        ("about_2-2-title", "Collaborator", ""),
        ("about_2-3-list-1", "<a href='mailto:alan\@ime.usp.br'>Alan M. Durham</a>, Ph.D., Assistant Professor, University of São Paulo", ""),
        ("about_2-4-title", "Members", ""),
        ("about_2-5-list-1", "João Marcelo P. Alves, Ph.D.", ""),
        ("about_2-5-list-2", "Liliane Santana, MSc student", ""),
        ("about_2-5-list-3", "Maira Rodrigues C. Neves, MSc student", ""),
        ("about_2-5-list-4", "Carolina Rossi, MSc student", ""),
        ("about_2-5-list-5", "Rodrigo Hashimoto, undergraduate student", ""),
        ("about_3-0-title", "<i>Photorhabdus</i> biology", ""),
        ("about_3-1-paragraph", "Enterobacteria of the genus <i>Photorhabdus</i> are symbiotic partners of entomopathogenic nematodes belonging to the genus <i>Heterorhabditis</i>. Both members of this unusual symbiosis are able to efficiently kill any soil dwelling arthropod and are used for agronomic insect pest control. The bacteria serve two purposes after the infective juvenile of <i>Heterorhabditis</i> sp. invades the insect hemolymph; turning off the insect immune response and serving as food for the nematode partner development. The insect killing is attained by a series of mechanisms that go from the secretion of hydrolytic enzymes and very sophisticated protein toxins to the production of secondary metabolites. Both insect killing and nematode symbiosis are dependent on the bacterial colonization through the production of fimbria and adhesin molecules that mediate the production of a biofilm inside their hosts. ", ""),
        ("about_3-2-title", "The genomes", ""),
        ("about_3-3-paragraph", "<i>P. luminescens luminescens</i> MN7 is the first Neotropical entomopathogenic bacterium to have had its genome sequenced and annotated. Its nematode is <i>H. baujardi</i> strain LPP7, previously isolated from the soil of the Amazon forest in Monte Negro (RO), Brazil.", ""),
        ("about_3-4-paragraph", "The genomes of two <i>Photorhabdus</i> have been completely sequenced and annotated: <a href='http://www.ncbi.nlm.nih.gov/genome/1123'><i>P. luminescens laumondii</i> strain TTO1</a> and <a href='http://www.ncbi.nlm.nih.gov/genome/1768'><i>P. asymbiotica</i> strain ATCC43949</a>. Their genomes are roughly 5 to 5.6 Mb long and contain approximately 4,400 to 4,700 ORFs. <i>Steinernema</i>, another genus of entomopathogenic nematode, also contains an enterobacterial partner belonging to the genus <i>Xenorhabdus</i>. The genomes of <a href='http://www.ncbi.nlm.nih.gov/genome/1227'><i>X. nematophila</i> ATCC19061</a> and <a href='http://www.ncbi.nlm.nih.gov/genome/1226'><i>X. bovienii</i> SS-2004</a> have also been sequenced. ", ""),
        ("about_4-0-title", "Funding", ""),
        ("about_4-1-paragraph", "<b>PhotoBase</b> has been developed with support from <a href='http://www.fapesp.br/en/'>FAPESP</a> (São Paulo Research Foundation, grants <b>#2010/51973-0</b> and <b>#2012/20945-7</b>) and <a href='http://www.cnpq.br/english/cnpq/index.htm'>CNPq</a> (National Council for Scientific and Technological Development).", ""),
        ("about_4-2-paragraph", "The opinions, hypotheses, and conclusions or recommendations present in this website are the sole responsibility of its authors and do not necessarily reflect the views of FAPESP.", ""),
        ("about_4-3-title", "Reference", ""),
        ("about_4-4-paragraph", "If you use this database, please cite this page as follows:", ""),
        ("about_4-5-list-1", "Winter, C.E. &amp; Gruber, A. (2013) The <i>Photorhabdus luminescens</i> MN7 genome database, version 1.0: http://www.coccidia.icb.usp.br/PMN.", "");
        
SQL


#apaga diretorios antigos com fastas
if(-d "$html_dir/root/$fasta_dir" && -d "$html_dir/root/$aa_fasta_dir" && -d "$html_dir/root/$nt_fasta_dir")
{
    !system("rm -r $html_dir/$fasta_dir $html_dir/$aa_fasta_dir $html_dir/$nt_fasta_dir")
	or die "Could not removed directories\n";
}

#separa sequencias do multifasta e cria diretorio
if(not -d $html_dir)
{
    !system("mkdir -p $html_dir")
        or die "Could not created directory $html_dir\n";
}
if(not -d "$html_dir/root/$fasta_dir")
{
    !system("mkdir -p $html_dir/root/$fasta_dir")
        or die "Could not created directory $html_dir/root/$fasta_dir\n";
}

$/ = ">";

#separa ORFs em aa do multifasta aa
if(not -d "$html_dir/root/$aa_fasta_dir")
{
    !system("mkdir -p $html_dir/root/$aa_fasta_dir")
        or die "Could not created directory $html_dir/root/$aa_fasta_dir\n";
}

if($aa_orf_file ne "")
{
    open(FILE_AA,"$aa_orf_file") or die "Could not open file $aa_orf_file\n";
}

#separa ORFs nt do multifasta nt
if(not -d "$html_dir/root/$nt_fasta_dir")
{
    !system("mkdir -p $html_dir/root/$nt_fasta_dir")
        or die "Could not created directory $html_dir/root/$nt_fasta_dir\n";
}

#if($nt_orf_file ne "")
#{
#    open(FILE,"$nt_orf_file") or die "Could not open file $nt_orf_file\n";
#}

$/ = ">";


my $name;
my $seq;
#termina funcao para separar sequencias nt das ORFs

my $output_seqs;
my $count = 0;
my $count_ev = 0;
my $count_dna;

#prefix_name for sequence
my $prefix_name;
my $sequence;

#my %ip_id;
my $tmhmm_result = "";
my $signalP_result = "";
my $phobius_result = "";
my $dgpi_result = "";
my $predgpi_result = "";
my $bigpi_result = "";
my $blast_result = "";
my $rpsblast_result = "";
my $hmmer_result = "";
my $interpro_result = "";
#my $ortholgy_result = "";
#my $GO_result = "";
my $header;
my $locus_tag;
my $locus = 0;

#my @components_name = split (';',$component_name_list);
#push @components_name,"go_terms";
#my %comp_names = map {$_ => 1} @components_name;



#my @databases_blast = split(";", $databases_code);
#my @blast_dirs = split(";", $databases_dir);
#
#for(my $i = 0; $i < scalar @databases_blast; $i++)
#{
#	$scriptSQL .= "\nINSERT INTO BLAST(database, directory) VALUES ('".$databases_blast[$i]."', '".$blast_dirs[$i]."');";
#}

#
# Read ALL Sequence Objects and sort by name for nice display
#

my @sequence_objects;
my $index=0;

my $strlen=4;
my $count_seq = 1;

my $sequence_object  = new EGeneUSP::SequenceObject();
my %hash_dna;
my @seq_links;
#contador de sequencias
my $seq_count = 0;
my @components_name = ();
my @filepathsComponents = ();
my $dbName = "";
my $dbHost = "";
my $dbUser = "";
my $dbPassword = "";
while($sequence_object->read())
{	
    ++$seq_count;
    $count_ev = 0;
    my @conclusions = @{$sequence_object->get_conclusions()};
    $header = $sequence_object->fasta_header();
    my $bases = $sequence_object->current_sequence();
    my $name = $sequence_object->sequence_name();
    
    $dbName = $sequence_object->{dbname};
    $dbHost = $sequence_object->{host};
    $dbUser = $sequence_object->{user};
    $dbPassword = $sequence_object->{password};    
    
    
    #TODO - criar controller annotations, ann_file passa a ser a URL para as anotações
    my $ann_file = "annotations/".$name;
    # no script original(report_html.pl) começa a criação da pagina principal onde são listadas as sequencias
    #pulando essa parte, começamos a escrita do arquivo fasta, entra em duvida a necessidade desse arquivo
    open(FASTAOUT, ">$html_dir/root/$fasta_dir/$name.fasta") or die "could not create fasta file $html_dir/root/$fasta_dir/$name.fasta\n";
    my $length = length($bases);
    print FASTAOUT ">$name\n";
    for (my $i = 0; $i < $length; $i += 60)
    {
		my $line = substr($bases, $i, 60);
		print FASTAOUT "$line\n";
    }
    close(FASTAOUT);
    my @programs = ();
    
    if(@{$sequence_object->get_logs})
    {
    	foreach my $log(@{$sequence_object->get_logs()})
    	{
    		my $component = $log->{program};
			if($component =~ /<program name=\"annotation_\w+\.pl\"/gim)
			{
				push @components_name, $component =~ /<program name=\"(annotation_\w+\.pl)\"/gim;
			}
			else
			{
				push @components_name, $component;
			}
#    		foreach my $key(sort keys %$log)
#    		{
#    			$scriptSQL .= "\n--logs\t$key\t".$log->{$key}."\n";
#    		}
    	}
    }    
    
    
#    foreach my $key(sort keys %$sequence_object)
#    {
#    	$scriptSQL .= "\n--sequenceObject\t$key\t".$sequence_object->{$key}."\n";
#    }
    
    $header =~ s/>//g;
    $header =~ m/(\S+)_(\d+)/;
    $prefix_name = $1;
    #aqui começaria a geração da pagina relacionada a cada anotação
    #pulando isso, passamos para geração dos arquivos, volta a duvida sobre a necessidade desses arquivos
    my $file_aa = $name."_CDS_AA.fasta";
    my $file_nt = $name."_CDS_NT.fasta";
    open(FILE_AA,">$html_dir/root/$aa_fasta_dir/$file_aa");
    open(FILE_NT,">$html_dir/root/$nt_fasta_dir/$file_nt");
    my $count;
    my $line_subev;
    foreach my $component (sort @components_name)
	{
		my $component_name = $component;
		my $filepath = "";
		$component_name =~ s/annotation_//g;
		$component_name =~ s/.pl//g;
		
		if($component_name eq "alienhunter")
		{
			#no report original ele utilizaria isso como a coluna da tabela só para passar o caminho do arquivo
			#precisamos inserir no banco de dados a key e o valor = caminho do arquivo
			#ou podemos pegar o valor do arquivo e inserir no banco de dados
			my $file = $alienhunter_output_file."_".$header;
			$filepath = "$alienhunter_dir/$file";
		}
		elsif($component_name eq "skews")
		{
			my $filestring = `ls $skews_dir`;
			my @phdfilenames = split(/\n/,$filestring);
			my $seq_name = $sequence_object->sequence_name();
			my $aux = "";
			foreach my $file (@phdfilenames)
			{
				if($file =~ m/$seq_name/ and $file =~ m/.png/)
				{
					$aux .= "$skews_dir/$file\n";
				}
			}
			$filepath = $aux;
		}
		elsif($component_name	eq	"infernal")
		{
			my	$file	=	$infernal_output_file."_".$header;
			$filepath = "$infernal_dir/$file";
		}
		elsif($component_name	eq	"rbsfinder")
		{
			my	$file	=	$header.".txt";
			$filepath = "$rbs_dir/$file";
		}
		elsif($component_name	eq	"rnammer")
		{
			my	$file	=	$header."_rnammer.gff";
			$filepath	=	"$rnammer_dir/$file";
		}
		elsif($component_name	eq	"transterm")
		{
			my	$file	=	$header.".txt";
			$filepath	=	"$transterm_dir/$file";
		}
		elsif($component_name	eq	"trf")
		{
			my	$file	=	$trf_dir."/".$name."_trf.txt";
			$filepath	=	"$file";
		}
		elsif($component_name	eq	"trna")
		{
			my	$file	=	$trna_dir."/".$name."_trna.txt";
			$filepath	=	"$file";
		}
		elsif($component_name	eq	"mreps")
		{
			my	$name	=	$sequence_object->{sequence_name};
			my	$file	=	$mreps_dir."/".$name."_mreps.txt";
			$filepath	=	"$file";
		}
		elsif($component_name	eq	"string")
		{
			my	$name	=	$sequence_object->{sequence_name};
			my	$file	=	$string_dir."/".$name."_string.txt";
			$filepath	=	"$file";
		}
		
		unless($filepath)
		{
			foreach my $log(@{$sequence_object->get_logs()})
	    	{
	    		if($log->{program} eq $component)
	    		{
	    			my $directory = "";
	    			my $file = "";
	    			if($log->{arguments} =~ /^\w*output_dir=(\w+)"*/gm)
	    			{
	    				$directory = $1;
	    			}
	    			if($log->{arguments} =~ /^\w*output_file=(\w+.+)"*/gm)
	    			{
	    				$file = $1;
	    			}
	    			if($directory || $file)
	    			{
	    				unless($directory)
		    			{
		    				my $dirName = $file;
		    				$dirName  =~ s/.txt//g;
		    				$directory = $dirName."_dir";
		    			}
		    			elsif(!$file)
		    			{
		    				my $fileName = $directory;
		    				$fileName  =~ s/_dir//g;
		    				$file = $fileName.".txt";
		    			}
		    			if($directory && $file)
		    			{
		    				$filepath = "$directory/$file";
		    			}
	    			}
	    		}
	    	}
		}
		
		push @filepathsComponents, $filepath;
		$scriptSQL .= "\nINSERT INTO COMPONENTS(name, component, filepath) VALUES('$component_name', '$component', '$filepath');\n";
	}
	
    close(FILE_AA);
    close(FILE_NT);
    
}


#my $help;
my $nameProject = $html_dir;
my $filepath =  `pwd`;
chomp $filepath;
$filepath .= "/".$nameProject;
my $databaseFilepath = $filepath . "/database.db";
#my $optret = GetOptions(
#	"h|help"     => \$help,
#	"name=s"     => \$nameProject,
#	"database=s" => \$databaseFilepath
#);

#my $helpMessage = <<HELP;
#
###### report_html_db.pl - In development stage 19/06/2016 - Wendel Hime #####
#
#Project of scientific iniciation used to generate site based on content of evidences and results of analysis.
#
#Usage:  report_html_db.pl -name <Name site>
#
#
#Mandatory parameters:
#
#Optional parameters:
#
#-h          Print this help message and exit
#
#-name = html_dir      Name of the site or project to be created
#
#-database = database.db     Filepath to be used like static contents of the project
#
#HELP
#
#if ( $help ) {
#	print $helpMessage;
#	exit;
#}

#path catalyst file
my $pathCatalyst = `which catalyst.pl`;
unless ($pathCatalyst) {
	print
"Catalyst not found, please install dependences:\ncpan DBIx::Class Catalyst::Devel Catalyst::Runtime Catalyst::View::TT Catalyst::View::JSON Catalyst::Model::DBIC::Schema DBIx::Class::Schema::Loader MooseX::NonMoose";
	exit;
}
chomp $pathCatalyst;

#give permission to execute catalyst.pl
chmod( "0755", $pathCatalyst );

#create project
print "Creating project...\n";
`$pathCatalyst $nameProject`;
my $lowCaseName = $nameProject;
$lowCaseName = lc $lowCaseName;

#give permission to execute files script
#chmod("111", "$nameProject/script/".$lowCaseName."_server.pl");
#chmod("111", "$nameProject/script/".$lowCaseName."_create.pl");
#create view
print "Creating view\n";
`./$nameProject/script/"$lowCaseName"_create.pl view TT TT`;
my $fileHandler;
open( $fileHandler, "<", "$nameProject/lib/$nameProject/View/TT.pm" );
my $contentToBeChanged =
"__PACKAGE__->config(\n\tTEMPLATE_EXTENSION\t=>\t'.tt',\n\tTIMER\t=>\t0,\n\tWRAPPER\t=>\t'$lowCaseName/_layout.tt',\n\tENCODING\t=>\t'utf-8',\n);";
my $data = do { local $/; <$fileHandler> };
$data =~ s/__\w+->config\(([\w\s=>''"".,\/]*)\s\);/$contentToBeChanged/igm;
close($fileHandler);
print "Editing view";
writeFile( "$nameProject/lib/$nameProject/View/TT.pm", $data );

#if database file exists, delete
if ( -e $databaseFilepath ) {
	unlink $databaseFilepath;
}

#create the file sql to be used
print "Creating SQL file\n";
writeFile( "script.sql", $scriptSQL );

#create file database
print "Creating database file\n";
`sqlite3 $databaseFilepath < script.sql`;

#create models project
print "Creating models\n";
`$nameProject/script/"$lowCaseName"_create.pl model Basic DBIC::Schema "$nameProject"::Basic create=static "dbi:SQLite:$databaseFilepath" on_connect_do="PRAGMA foreign_keys = ON;PRAGMA encoding='UTF-8'"`;
`$nameProject/script/"$lowCaseName"_create.pl model Chado DBIC::Schema "$nameProject"::Chado create=static "dbi:Pg:dbname=$dbName;host=$dbHost" "$dbUser" "$dbPassword"`;

my $hadGlobal = 0;
my $hadSearchDatabase = 0;
foreach my $component (sort @components_name)
{
	if($component =~ /^report_go_mapping.pl/gi || $component =~ /^report_orthology.pl/gi || $component =~ /^report_pathways.pl/gi || $component =~ /^report_kegg_organism.pl/gi)
	{
		$hadGlobal = 1;
	}
	if($component =~ /^annotation_/gi)
	{
		$hadSearchDatabase = 1;
	}
}

#create controllers project
my @controllers = (
	"Home", "Blast", "Downloads", "Help", "About"
);
if($hadGlobal)
{
	push @controllers, "GlobalAnalyses";
}
if($hadSearchDatabase)
{
	push @controllers, "SearchDatabase";
}

foreach my $controller (@controllers) {
	print "Creating controller $controller\n";
	`$nameProject/script/"$lowCaseName"_create.pl controller $controller`;

#se nome do controller possuir letra maiuscula no meio da string, adicionar - e passar para low case

#    s/"*sub index :Path :Args\(0\) {([\s\w()$,=@_;\->{}""#"\[\]'':%\/.]+)*//igm;

#métodos possuem mesmos nomes, passar nome do controller para low case, abrir arquivo controller, pegar conteúdo
#usar expressão regular para pegar conteúdo do método index, criar variavel com conteúdo substituído, substituír conteudo
#s/$oldContent/$newContent/igm;

	my $lowCaseController = $controller;
	if ( $lowCaseController =~ /([A-Z]+[a-z]+)([A-Z]+[a-z]+)/gm ) {
		my @words = ();
		push @words, $1;
		push @words, $2;
		my $counterWords = 0;
		$lowCaseController = "";
		foreach my $word (@words) {
			$word = lc $word;
			if ( $counterWords < ( scalar @words ) - 1 ) {
				$lowCaseController .= $word . "-";
			}
			else {
				$lowCaseController .= $word;
			}
			$counterWords++;
		}
	}
	else {
		$lowCaseController = lc $lowCaseController;
	}

	my $controllerContent = "\nsub index :Path :Args(0) {\n".
			"\tmy ( \$self, \$c ) = \@_;\n".
			"\tuse utf8;\n".
			"\tuse Encode qw( decode encode );\n".
			"\tmy \@texts = \$c->model('Basic::Text')->search({\n".
				"\t\t-or => [\n".
					"\t\t\ttag => {'like', 'header%'},\n".
					"\t\t\ttag => 'menu',\n".
					"\t\t\ttag => 'footer',\n".
					"\t\t\ttag => {'like', '$lowCaseController%'}\n".
				"\t\t]\n".
			"\t});\n".
			"\tforeach my \$text (\@texts) {\n".
			"\t\tforeach my \$key (keys \%\$text) {\n".
			"\t\t\tif(\$text->{\$key} != 1) {\n".
			"\t\t\t\tmy \$string = decode( 'utf-8', \$text->{\$key}{value});\n".
			"\t\t\t\t\$string = encode('iso-8859-1', \$string);\n".
			"\t\t\t\t\$text->{\$key}{value} = \$string;\n".
			"\t\t\t}\n".
			"\t\t}\n".
			"\t}\n".
			"\t\$c->stash->{titlePage} = '$controller';\n".
			"\t\$c->stash(currentPage => '$lowCaseController');\n".
			"\t\$c->stash(texts => [\@texts]);\n".
#			"\t\$c->stash(testFeatures => [\$c->model('Chado::Feature')->all]);\n".
			"\t\$c->stash(template => '$lowCaseName/$lowCaseController/index.tt');\n";

	if($controller eq "SearchDatabase" || $controller eq "GlobalAnalyses")
	{
		$controllerContent .= "\t\$c->stash(components => [\$c->model('Basic::Component')->all]);\n";
	}
	if($hadGlobal)
	{
		$controllerContent .= "\t\$c->stash->{hadGlobal} = 1;\n";
	}
	else
	{
		$controllerContent .= "\t\$c->stash->{hadGlobal} = 0;\n";
	}
	if($hadSearchDatabase)
	{
		$controllerContent .= "\t\$c->stash->{hadSearchDatabase} = 1;\n";
	}
	else
	{
		$controllerContent .= "\t\$c->stash->{hadSearchDatabase} = 0;\n";
	}
	
	
	$controllerContent .= "\n}\n";
	

	open( my $fileHandler,
		"<",
		"$nameProject/lib/$nameProject/Controller/" . $controller . ".pm" );
	$data = do { local $/; <$fileHandler> };
	$data =~
s/"*sub index :Path :Args\(0\) \{([\s\w()\$,=\@_;\->\{\}\"\[\]\'\:%\/.#]+)\}"*/$controllerContent/igm;
	close($fileHandler);
	writeFile(
		"$nameProject/lib/$nameProject/Controller/" . $controller . ".pm",
		$data );
}


foreach my $filepathComponent (@filepathsComponents)
{
	if($filepathComponent)
	{
		if($filepathComponent =~ /(\w+)\/\w+/g)
		{
			`ln -s ../../$1/ $nameProject/root/$1`;
		}
	}
}


#Descompacta assets
print "Copy files assets\n";
`tar -zxf assets.tar.gz`;
`cp -r assets $nameProject/root/`;
`rm -Rf assets`;

#Conteúdo HTML da pasta root, primeira chave refere-se ao nome do diretório
#O valor do vetor possuí o primeiro valor como nome do arquivo, e os demais como conteúdo do arquivo
my %contentHTML = (
	"about" => {
		"_content.tt" => <<CONTENTABOUT
<!DOCTYPE html>
<div class="row">
    <div class="col-md-12">
        <div class="panel-group" id="accordion">
            
            [% counter = 1 %]
            [% FOREACH text IN texts %]
                [% IF text.tag == 'about-table-content-'_ counter %]
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                [% id = text.details %]
                                <a data-toggle="collapse" data-parent="#accordion" href="#[% id %]" class="collapsed">[% text.value %]</a>
                            </h4>
                        </div>
                        <div id="[% id %]" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="notice-board">
                                    [% counterTexts = 0 %]
                                    [% FOREACH content IN texts %]
                                        [% IF content.tag.search(id _"-"_ counterTexts) %]
                                            [% IF content.tag == id _"-"_ counterTexts _"-title" %]
                                                <h1 id="[% content.details %]" class="page-head-line">[% content.value %]</h1>
                                            [% END %]
                                            [% IF content.tag == id _"-"_ counterTexts _"-paragraph" %]
                                                <p>[% content.value %]</p>
                                            [% END %]
                                            [% IF content.tag.search(id _"-"_ counterTexts _"-list-") %]
                                                <ul>
                                                    [% FOREACH item IN texts %]
                                                        [% IF item.tag.search(id _"-"_ counterTexts _"-list-") %]
                                                            <li>[% item.value %]</li>
                                                        [% END %]
                                                    [% END %]
                                                </ul>
                                            [% END %]
                                            [% counterTexts = counterTexts + 1 %]
                                        [% END %]
                                    [% END %]
                                </div>
                            </div>
                        </div>
                    </div>
                    [% counter = counter + 1 %]
                 [% END %]
             [% END %]
             
        </div>
    </div>
</div>
CONTENTABOUT
		,
		"index.tt" => <<CONTENTABOUTINDEX
<!DOCTYPE html>
<div class="content-wrapper">
    <div class="container">		
        [% INCLUDE '$lowCaseName/about/_content.tt' %]
    </div>
</div>
CONTENTABOUTINDEX
	},
	"blast" => {
		"_forms.tt" => <<CONTENTBLAST
<!DOCTYPE html>
<div class="row">
    <div class="col-md-12">
        <form action="http://puma.icb.usp.br/blast/blast.cgi" method="POST" name="MainBlastForm" enctype="multipart/form-data">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    [% FOREACH text IN texts %]
                        [% IF text.tag.search('blast-form-title') %]
                            [% text.value %]
                        [% END %]
                    [% END %]
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        [% FOREACH text IN texts %]
                            [% IF text.tag.search('blast-program-title') %]
                            <label><a href="[% text.details %]">[% text.value %]</a></label>
                            [% END %]
                        [% END %]
                        <select class="form-control" name="PROGRAM">
                            [% FOREACH text IN texts %]
                                [% IF text.tag.search('blast-program-option') %]
                                <option> [% text.value %] </option>
                                [% END %]
                            [% END %]
                        </select>
                    </div>
                    <div class="form-group">
                        [% FOREACH text IN texts %]
                            [% IF text.tag.search('blast-database-title') %]
                                <label>[% text.value %]</label>
                            [% END %]
                        [% END %]
                        <select class="form-control" name="DATALIB">
                            [% FOREACH text IN texts %]
                                [% IF text.tag.search('blast-database-option') %]
                                    <option value="[% text.details %]"> [% text.value %]</option>
                                [% END %]
                            [% END %]
                        </select>
                    </div>
                    <div class="form-group">
                        [% FOREACH text IN texts %]
                            [% IF text.tag.search('blast-format-title') %]
                                <label>[% text.value %]</label>
                            [% END %]
                        [% END %]
                        <textarea class="form-control" name="SEQUENCE" rows="6" cols="60"></textarea>
                    </div>
                    <div class="form-group">
                        [% FOREACH text IN texts %]
                            [% IF text.tag.search('blast-sequence-file-title') %]
                                <label>[% text.value %]</label>
                            [% END %]
                        [% END %]
                        <input id="SEQFILE" type="file">
                    </div>
                    <div class="form-group">
                        [% FOREACH text IN texts %]
                            [% IF text.tag.search('blast-subsequence') %]
                                [% IF text.tag.search('blast-subsequence-title') %]
                                    <label>[% text.value %]</label>
                                [% ELSIF text.tag.search('blast-subsequence-value') %]
                                    <label for="[% text.details %]"> [% text.value %] </label>
                                    <input class="form-control" type="text" id="[% text.details %]" name="[% text.details %]" value="" size="10">
                                [% END %]
                            [% END %]
                        [% END %]
                    </div>

                    <div class="panel-group" id="accordion">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    [% FOREACH text IN texts %]
                                        [% IF text.tag.search('blast-search-options-title') %]
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="collapsed">[% text.value %]</a>
                                        [% END %]
                                    [% END %]
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse">
                                <div class="panel-body">
                                    [% FOREACH text IN texts %]
                                        [% IF text.tag.search('blast-search-options-sequence-title') %]
                                            <label>[% text.value %]</label>
                                        [% END %]
                                    [% END %]
                                    <div class="form-group">
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag.search('blast-search-options-filter-title') %]
                                                <label>[% text.value %]</label>
                                            [% END %]
                                        [% END %]
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag.search('blast-search-options-filter-options') %]
                                                <div class="checkbox">
                                                    <label><input type="checkbox" name="FILTER" [% text.details %]> [% text.value %] </label>
                                                </div>
                                            [% END %]
                                        [% END %]
                                    </div>
                                    <div class="form-group">
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag.search('blast-search-options-expect') %]
                                                <label>[% text.value %]</label>
                                            [% END %]
                                        [% END %]
                                        <input class="form-control" type="text" name="EXPECT" size="3" value="1e-6">
                                    </div>
                                    <div class="form-group">
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag == "blast-search-options-matrix" %]
                                                <label><a href="[% text.details %]">[% text.value %]</a></label>
                                            [% END %]
                                        [% END %]
                                            <select class="form-control" name="MAT_PARAM">
                                                [% FOREACH text IN texts %]
                                                    [% IF text.tag.search('blast-search-options-matrix-options') %]
                                                        <option value="[% text.details %]" > [% text.value %]</option>
                                                    [% END %]
                                                [% END %]
                                            </select>
                                    </div>
                                    <div class="form-group">
                                        <div class="checkbox">
                                            [% FOREACH text IN texts %]
                                                [% IF text.tag.search('blast-search-options-alignment') %]
                                                    <label><input type="checkbox" name="UNGAPPED_ALIGNMENT" value="is_set"> [% text.value %]</label>
                                                [% END %]
                                            [% END %]
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag == "blast-search-options-query" %]
                                                <label><a href="[% text.details %]">[% text.value %]</a></label>
                                            [% END %]
                                        [% END %]
                                        <select class="form-control" name="GENETIC_CODE">
                                            [% FOREACH text IN texts %]
                                                [% IF text.tag == "blast-search-options-query-options" %]
                                                    <option>[% text.value %]</option>
                                                [% END %]
                                            [% END %]
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag == "blast-search-options-database" %]
                                                <label><a href="[% text.details %]">[% text.value %]</a></label>
                                            [% END %]
                                        [% END %]
                                        <select class="form-control" name="DB_GENETIC_CODE">
                                            [% FOREACH text IN texts %]
                                                [% IF text.tag == "blast-search-options-database-options" %]
                                                    <option>[% text.value %]</option>
                                                [% END %]
                                            [% END %]
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag == "blast-search-options-frame-shift-penalty" %]
                                                <label>[% text.value %]</label>
                                            [% END %]
                                        [% END %]
                                        <select class="form-control" name="OOF_ALIGN"> 
                                            [% FOREACH text IN texts %]
                                                [% IF text.tag == "blast-search-options-frame-shift-penalty-options" %]
                                                    <option>[% text.value %]</option>
                                                [% END %]
                                            [% END %]
                                            <option selected="" value="0"> No OOF</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag == "blast-search-options-other-advanced-options" %]
                                                <label for="OTHER_ADVANCED"><a href="[% text.details %]">[% text.value %]</a></label>
                                            [% END %]
                                        [% END %]
                                        <input class="form-control" type="text" id="OTHER_ADVANCED" name="OTHER_ADVANCED" value="" maxlength="50">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    [% FOREACH text IN texts %]
                                        [% IF text.tag == "blast-display-options-title" %]
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="collapsed">[% text.value %]</a>
                                        [% END %]
                                    [% END %]
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <div class="checkbox">
                                            [% FOREACH text IN texts %]
                                                [% IF text.tag == "blast-display-options-graphical-overview" %]
                                                    <label><input type="checkbox" name="OVERVIEW" checked=""><a href="[% text.details %]">[% text.value %]</a></label>
                                                [% END %]
                                            [% END %]
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag == "blast-display-options-alignment-view-title" %]
                                                <label><a href="[% text.details %]">[% text.value %]</a></label>
                                            [% END %]
                                        [% END %]
                                        <select class="form-control" name="ALIGNMENT_VIEW">
                                            [% FOREACH text IN texts %]
                                                [% IF text.tag == "blast-display-options-alignment-view-options" %]
                                                    <option value="[% text.details %]" >[% text.value %]</option>
                                                [% END %]
                                            [% END %]
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag == "blast-display-options-descriptions" %]
                                                <label><a href="[% text.details %]">[% text.value %]</a></label>
                                            [% END %]
                                        [% END %]
                                        <select class="form-control" name="DESCRIPTIONS">
                                            [% FOREACH text IN texts %]
                                                [% IF text.tag == "blast-display-options-descriptions-options" %]
                                                    <option [% text.details %]>[% text.value %]</option>
                                                [% END %]
                                            [% END %]
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag == "blast-display-options-alignments" %]
                                                <label><a href="[% text.details %]">[% text.value %]</a></label>
                                            [% END %]
                                        [% END %]
                                        <select class="form-control" name="ALIGNMENTS">
                                            [% FOREACH text IN texts %]
                                                [% IF text.tag == "blast-display-options-alignments-options" %]
                                                    <option [% text.details %]>[% text.value %]</option>
                                                [% END %]
                                            [% END %]
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        [% FOREACH text IN texts %]
                                            [% IF text.tag == "blast-display-options-color-schema" %]
                                                <label><a href="[% text.details %]">[% text.value %]</a></label>
                                            [% END %]
                                        [% END %]
                                        <select class="form-control" name="COLOR_SCHEMA">
                                            [% FOREACH text IN texts %]
                                                [% IF text.tag == "blast-display-options-color-schema-options" %]
                                                    <option [% text.details %]>[% text.value %]</option>
                                                [% END %]
                                            [% END %]
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    [% FOREACH text IN texts %]
                        [% IF text.tag == "blast-button" %]
                            <input value="[% text.value %]" [% text.details %]>
                        [% END %]
                    [% END %]
                </div>
            </div>
        </form>
    </div>
</div>
CONTENTBLAST
		,
		"index.tt" => <<CONTENTINDEXBLAST
<!DOCTYPE html>
<div class="content-wrapper">
    <div class="container">	
        [% INCLUDE '$lowCaseName/blast/_forms.tt' %]
    </div>
</div>
CONTENTINDEXBLAST
	},
	"downloads" => {
		"_content.tt" => <<CONTENTDOWNLOADS
<!DOCTYPE html>
<div class="row">
    <div class="col-md-12">
        <div class="panel-group" id="accordion">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        [% FOREACH text IN texts %]
                            [% IF text.tag == 'downloads-genes' %]
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="collapsed">[% text.value %]</a>
                            [% END %]
                        [% END %]
                    </h4>
                </div>
                <div id="collapseOne" class="panel-collapse collapse">
                    <div class="panel-body">
                        <div class="notice-board">
                            <ul>
                                [% FOREACH text IN texts %]
                                    [% IF text.tag == 'downloads-genes-links' %]
                                        <li><a href="[% text.details %]">[% text.value %]</a></li>
                                    [% END %]
                                [% END %]
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        [% FOREACH text IN texts %]
                            [% IF text.tag == 'downloads-other-sequences' %]
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="collapsed">[% text.value %]</a>
                            [% END %]
                        [% END %]
                    </h4>
                </div>
                <div id="collapseTwo" class="panel-collapse collapse">
                    <div class="panel-body">
                        <div class="notice-board">
                            <ul>
                                [% FOREACH text IN texts %]
                                    [% IF text.tag == 'downloads-other-sequences-links' %]
                                        <li><a href="[% text.details %]">[% text.value %]</a></li>
                                    [% END %]
                                [% END %]
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

CONTENTDOWNLOADS
		,
		"index.tt" => <<CONTENTINDEXDOWNLOADS
<!DOCTYPE html>
<div class="content-wrapper">
    <div class="container">		
        [% INCLUDE '$lowCaseName/downloads/_content.tt' %]
    </div>
</div>
CONTENTINDEXDOWNLOADS
	},
	"global-analyses" => {
		"_content.tt" => <<CONTENTGLOBALANALYSES
<!DOCTYPE html>
<div class="row">
    <div class="col-md-12">
        <div class="panel-group" id="accordion">
			[%
				go_mapping = 0
				orthology = 0 
				pathways = 0
				organism = 0 
			%]
			
			[% FOREACH component IN components %]
				[% IF component.component.match("report_go_mapping.pl") %]
					[% go_mapping = 1 %]
				[% END %]
				[% IF component.component.match("report_orthology.pl") %]
					[% orthology = 1 %]
				[% END %]
				[% IF component.component.match("report_pathways.pl") %]
					[% pathways = 1 %]
				[% END %]
				[% IF component.component.match("report_kegg_organism.pl") %]
					[% organism = 1 %]
				[% END %]
			[% END %]
			[% IF go_mapping %]
	            <div class="panel panel-default">
	                <div class="panel-heading">
	                    <h4 class="panel-title">
	                        [% FOREACH text IN texts %]
	                            [% IF text.tag == 'global-analyses-go-terms-mapping' %]
	                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="collapsed">[% text.value %]</a>
	                            [% END %]
	                        [% END %]
	                    </h4>
	                </div>
	                <div id="collapseOne" class="panel-collapse collapse">
	                    <div class="panel-body">
	                        <div class="form-group">
	                            [% FOREACH text IN texts %]
	                                [% IF text.tag == 'global-analyses-expansible-tree' %]
	                                    <label><a href="[% text.details %]">[% text.value %]</a></label>
	                                [% END %]
	                            [% END %]
	                        </div>
	                        <div class="form-group">
	                            [% FOREACH text IN texts %]
	                                [% IF text.tag == 'global-analyses-table-ontologies' %]
	                                    <label><a href="[% text.details %]">[% text.value %]</a></label>
	                                [% END %]
	                            [% END %]
	                        </div>
	                    </div>
	                    <div class="panel-footer">
	                        [% FOREACH text IN texts %]
	                            [% IF text.tag == 'global-analyses-go-terms-mapping-footer' %]
	                                [% text.value %]
	                            [% END %]
	                        [% END %]
	                    </div>
	                </div>
	            </div>
            [% END %]
            
            [% IF orthology %]
	            <div class="panel panel-default">
	                <div class="panel-heading">
	                    <h4 class="panel-title">
	                        [% FOREACH text IN texts %]
	                            [% IF text.tag == 'global-analyses-eggNOG' %]
	                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="collapsed">[% text.value %]</a>
	                            [% END %]
	                        [% END %]
	                    </h4>
	                </div>
	                <div id="collapseTwo" class="panel-collapse collapse">
	                    <div class="panel-body">
	                        <div class="form-group">
	                            [% FOREACH text IN texts %]
	                                [% IF text.tag == 'global-analyses-orthology-analysis-classes' %]
	                                    <label><a href="[% text.details %]">[% text.value %]</a></label>
	                                [% END %]
	                            [% END %]
	                        </div>
	                    </div>
	                </div>
	            </div>
            [% END %]

			[% IF pathways %]
	            <div class="panel panel-default">
	                <div class="panel-heading">
	                    <h4 class="panel-title">
	                        [% FOREACH text IN texts %]
	                            [% IF text.tag == 'global-analyses-kegg-pathways' %]
	                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" class="collapsed">[% text.value %]</a>
	                            [% END %]
	                        [% END %]
	                    </h4>
	                </div>
	                <div id="collapseThree" class="panel-collapse collapse">
	                    <div class="panel-body">
	                        [% FOREACH text IN texts %]
	                            [% IF text.tag.search('global-analyses-kegg-report') %]
	                                <div class="form-group">
	                                    <label><a href="[% text.details %]">[% text.value %]</a></label>
	                                </div>
	                            [% END %]
	                        [% END %]
	                    </div>
	                </div>
	            </div>
	        [% END %]

			[% IF organism %]
	            <div class="panel panel-default">
	                <div class="panel-heading">
	                    <h4 class="panel-title">
	                        [% FOREACH text IN texts %]
	                            [% IF text.tag == 'global-analyses-comparative-metabolic-reconstruction' %]
	                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour" class="collapsed">[% text.value %]</a>
	                            [% END %]
	                        [% END %]
	                    </h4>
	                </div>
	                <div id="collapseFour" class="panel-collapse collapse">
	                    <div class="panel-body">
	                        [% FOREACH text IN texts %]
	                            [% IF text.tag == 'global-analyses-comparative-metabolic-reconstruction-topics' %]
	                                <div class="form-group">
	                                    <label><a href="[% text.details %]">[% text.value %]</a></label>
	                                </div>
	                            [% END %]
	                        [% END %]
	                    </div>
	                </div>
	            </div>
            [% END %]
            
        </div>
    </div>
</div>
CONTENTGLOBALANALYSES
		,
		"index.tt" => <<CONTENTGLOBALANALYSESINDEX
<!DOCTYPE html>
<div class="content-wrapper">
    <div class="container">
        [% INCLUDE '$lowCaseName/global-analyses/_content.tt' %]
    </div>
</div>
CONTENTGLOBALANALYSESINDEX
	},
	"help" => {
		"_content.tt",
		<<CONTENTHELP
<!DOCTYPE html>
<div class="row">
    <div class="col-md-12">
        <div class="panel-group" id="accordion">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        [% FOREACH text IN texts %]
                            [% IF text.tag == 'help-questions-feedback' %]
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="collapsed">[% text.value %]</a>
                            [% END %]
                        [% END %]
                    </h4>
                </div>
                <div id="collapseOne" class="panel-collapse collapse">
                    <div class="panel-body">
                        <div class="notice-board">
                            [% FOREACH text IN texts %]
                                [% IF text.tag.search('help-questions-feedback-')  %]
                                    [% IF text.tag.search('paragraphe')  %]
                                        <p>[% text.value %]</p>
                                    [% END %]
                                [% END %]
                            [% END %]
                        
                            <ul>
                                [% FOREACH text IN texts %]
                                    [% IF text.tag.search('help-questions-feedback-')  %]
                                        [% IF text.tag.search('list')  %]
                                            <li>[% text.value %]</li>
                                        [% END %]
                                    [% END %]
                                [% END %]
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        [% FOREACH text IN texts %]
                            [% IF text.tag == 'help-table-contents' %]
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="collapsed">[% text.value %]</a>
                            [% END %]
                        [% END %]
                    </h4>
                </div>
                <div id="collapseTwo" class="panel-collapse collapse">
                    <div class="panel-body">
                        <div class="notice-board">
                            <ul>
                                [% FOREACH text IN texts %]
                                    [% IF text.tag.search('help-table-contents-')  %]
                                        <li><a data-toggle="collapse" data-parent="#accordion" class="collapsed" href="#[% text.details %]">[% text.value %]</a></li>
                                    [% END %]
                                [% END %]
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            [% counter = 1 %]
            [% FOREACH text IN texts %]
                [% IF text.tag == 'help-table-contents-'_ counter %]
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                [% id = text.details %]
                                <a data-toggle="collapse" data-parent="#accordion" href="#[% id %]" class="collapsed">[% text.value %]</a>
                            </h4>
                        </div>
                        <div id="[% id %]" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="notice-board">
                                    [% counterTexts = 0 %]
                                    [% FOREACH content IN texts %]
                                        [% IF content.tag.search(id _"-"_ counterTexts) %]
                                            [% IF content.tag == id _"-"_ counterTexts _"-title" %]
                                                <h1 id="[% content.details %]" class="page-head-line">[% content.value %]</h1>
                                            [% END %]
                                            [% IF content.tag == id _"-"_ counterTexts _"-paragraph" %]
                                                <p>[% content.value %]</p>
                                            [% END %]
                                            [% IF content.tag.search(id _"-"_ counterTexts _"-list-") %]
                                                <ul>
                                                    [% FOREACH item IN texts %]
                                                        [% IF item.tag.search(id _"-"_ counterTexts _"-list-") %]
                                                            <li>[% item.value %]</li>
                                                        [% END %]
                                                    [% END %]
                                                </ul>
                                            [% END %]
                                            [% counterTexts = counterTexts + 1 %]
                                        [% END %]
                                    [% END %]
                                </div>
                            </div>
                        </div>
                    </div>
                    [% counter = counter + 1 %]
                 [% END %]
             [% END %]

        </div>
    </div>
</div>
CONTENTHELP
		, "index.tt" => <<CONTENTINDEXHELP
<!DOCTYPE html>
<div class="content-wrapper">
    <div class="container">		
        [% INCLUDE '$lowCaseName/help/_content.tt' %]
    </div>
</div>
CONTENTINDEXHELP
	},
	"home" => {
		"_panelInformation.tt" => <<CONTENTHOME
<!DOCTYPE html>
<div class="content-wrapper">
    <div class="container">	
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        [% FOREACH text IN texts %]
                            [% IF text.tag.search('home') && !text.tag.search('value') %]
                                [% text.value %]
                            [% END %]
                        [% END %]
                    </div>
                    <div class="panel-body">
                        [% FOREACH text IN texts %]
                            [% IF text.tag.search('home-value')%]
                                [% text.value %]
                            [% END %]
                        [% END %]
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
CONTENTHOME
		,
		"index.tt" => <<CONTENTINDEXHOME
<!DOCTYPE html>
<div class="content-wrapper">
    <div class="container">
        [% INCLUDE '$lowCaseName/home/_panelInformation.tt' %]
    </div>
</div>
CONTENTINDEXHOME
	},
	"search-database" => {
		"_forms.tt" => <<CONTENTSEARCHDATABASE
<!DOCTYPE html>
<div class="content-wrapper">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        [% FOREACH text IN texts %]
                            [% IF text.tag.search('search-database-form-title') %]
                                [% text.value %]
                            [% END %]
                        [% END %]
                    </div>
                    <div class="panel-body">
                        <div class="panel-group" id="accordion">
                        	[% 
                        		section_protein_coding = 0 
                        		section_dna_based = 0
                        		blast = 0
                        		interpro = 0 
                        		tcdb = 0
                        		phobius = 0
                        		rpsblast = 0
                        		pathways = 0
                        		orthology = 0
                        		trna = 0
                        		trf = 0
                        		mreps = 0
                        		string = 0
                        		infernal = 0
                        		rbs = 0
                        		transterm = 0
                        		alienhunter = 0
                        	%]
                        	
                        	[% FOREACH component IN components %]
                        		[% IF component.component.match('annotation_glimmer3.pl') OR  
                        			component.component.match('annotation_glimmerm.pl') OR 
                        			component.component.match('annotation_augustus.pl') OR 
                        			component.component.match('annotation_myop.pl') OR 
                        			component.component.match('annotation_glimmerhmm.pl') OR 
                        			component.component.match('annotation_phat.pl') OR 
                        			component.component.match('annotation_snap.pl') OR 
                        			component.component.match('annotation_orf.pl') %]
                        			[% section_protein_coding = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_trna.pl') OR 
                        			component.component.match('annotation_mreps.pl') OR 
                        			component.component.match('annotation_string.pl') OR 
                        			component.component.match('annotation_infernal.pl') OR 
                        			component.component.match('annotation_rbs.pl') OR 
                        			component.component.match('annotation_transterm.pl') OR 
                        			component.component.match('annotation_alienhunter.pl') %]
                        			[% section_dna_based = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_blast.pl') %]
                        			[% blast = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_interpro.pl') %]
                        			[% interpro = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_tcdb.pl') %]
                        			[% tcdb = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_phobius.pl') %]
                        			[% phobius = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_rpsblast.pl') %]
                        			[% rpsblast = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_pathways.pl') %]
                        			[% pathways = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_orthology.pl') %]
                        			[% orthology = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_trna.pl') %]
                        			[% trna = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_trf.pl') %]
                        			[% trf = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_mreps.pl') %]
                        			[% mreps = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_string.pl') %]
                        			[% string = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_infernal.pl') %]
                        			[% infernal = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_rbs.pl') %]
                        			[% rbs = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_transterm.pl') %]
                        			[% transterm = 1 %]
                        		[% END %]
                        		[% IF component.component.match('annotation_alienhunter.pl') %]
                        			[% alienhunter = 1 %]
                        		[% END %]
                            [% END %]
                            [% IF section_protein_coding %]
	                            <div id="parentCollapseOne" class="panel panel-default">
	                                <div class="panel-heading">
	                                    <h4 class="panel-title">
	                                        [% FOREACH text IN texts %]
	                                            [% IF text.tag.search('search-database-gene-ids-descriptions-title') %]
	                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="collapsed">[% text.value %]</a>
	                                            [% END %]
	                                        [% END %]
	                                    </h4>
	                                </div>
	                                <div id="collapseOne" class="panel-collapse collapse">
	                                    <div class="panel-body">
	
	                                        <ul class="nav nav-pills">
	                                            [% FOREACH text IN texts %]
	                                                [% IF text.tag.search('search-database-gene-ids-descriptions-tab') %]
	                                                    <li [% text.details %]>[% text.value %]</li>
	                                                [% END %]
	                                            [% END %]
	                                        </ul>
	                                        <div class="tab-content">
	                                            <div id="geneIdentifier" class="tab-pane fade active in">
	                                                <h4></h4>
	                                                <form method="post" action="/cgi-bin/searchPMNseq.cgi" enctype="multipart/form-data">
	                                                    <div class="form-group">
	                                                        [% FOREACH text IN texts %]
	                                                            [% IF text.tag.search('search-database-gene-ids-descriptions-gene-id') %]
	                                                                <label>[% text.value %]</label>
	                                                            [% END %]
	                                                        [% END %]
	                                                        <input class="form-control" type="text" name="geneID">
	                                                    </div>
	                                                    <input class="btn btn-primary btn-sm" type="submit" name="geneIDbutton" value="Search"> 
	                                                    <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="clearForm(this.form);">
	                                                </form>
	                                            </div>
	                                            [% IF blast %]
		                                            <div id="geneDescription" class="tab-pane fade">
		                                                <h4></h4>
		                                                <form method="post" action="/cgi-bin/searchPMNseq.cgi" enctype="multipart/form-data">
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-gene-ids-descriptions-gene-description') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="geneDesc">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-gene-ids-descriptions-gene-excluding') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="noDesc">
		                                                    </div>
		                                                    <input class="btn btn-primary btn-sm" type="submit" name="geneIDbutton" value="Search"> 
		                                                    <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="clearForm(this.form);">
		                                                </form>
		                                            </div>
		                                        [% END %]
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        
	                            <div id="parentCollapseTwo" class="panel panel-default">
	                                <div class="panel-heading">
	                                    <h4 class="panel-title">
	                                        [% FOREACH text IN texts %]
	                                            [% IF text.tag.search('search-database-analyses-protein-code-title') %]
	                                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">[% text.value %]</a>
	                                            [% END %]
	                                        [% END %]
	                                    </h4>
	                                </div>
	                                <div id="collapseTwo" class="panel-collapse collapse">
	                                    <div class="panel-body">
	                                        <form method="post" action="/cgi-bin/searchPMNann.cgi" enctype="multipart/form-data">
	                                        	[% IF blast %]
		                                            <div class="form-group">
		                                                [% FOREACH text IN texts %]
		                                                    [% IF text.tag.search('search-database-analyses-protein-code-limit') %]
		                                                        <label>[% text.value %]</label>
		                                                    [% END %]
		                                                [% END %]
		                                                <input class="form-control" type="text" name="geneDesc">
		                                            </div>
		                                            <div class="form-group">
		                                                [% FOREACH text IN texts %]
		                                                    [% IF text.tag.search('search-database-analyses-protein-code-excluding') %]
		                                                        <label>[% text.value %]</label>
		                                                    [% END %]
		                                                [% END %]
		                                                <input class="form-control" type="text" name="noDesc">
		                                            </div>
		                                        [% END %]
	                                            <ul class="nav nav-pills">
	                                                [% FOREACH text IN texts %]
	                                                    [% IF text.tag.search('search-database-analyses-protein-code-tab') %]
	                                                        <li class=""><a href="[% text.details %]" data-toggle="tab">[% text.value %]</a></li>
	                                                    [% END %]
	                                                [% END %]
	                                            </ul>
	                                            <h4></h4>
	                                            <div class="tab-content">
	                                            	[% IF interpro %]
		                                                <div id="geneOntology" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        <div class="checkbox">
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag == 'search-database-analyses-protein-code-not-containing-classification' %]
		                                                                    <label><input type="checkbox" name="noGO">[% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </div>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-search-by-sequence') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="goID">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-search-by-description') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="goDesc">
		                                                    </div>
		                                                </div>
		                                            [% END %]
		                                            [% IF tcdb %]
		                                                <div id="transporterClassification" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        <div class="checkbox">
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag.search('search-database-analyses-protein-code-not-containing-classification-tcdb') %]
		                                                                    <label><input type="checkbox" name="noGO">[% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </div>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-search-by-transporter-identifier') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="tcdbID">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-search-by-transporter-family') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="tcdbFam">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-analyses-protein-code-search-by-transporter-subclass' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <select class="form-control" name="tcdbSubclass">
		                                                            <option value=""></option>
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag.search('search-database-analyses-protein-code-search-by-transporter-subclass-option') %]
		                                                                    <option value='[% text.value %]'>[% text.value %]</option>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </select>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-analyses-protein-code-search-by-transporter-class' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <select class="form-control" name="tcdbClass">
		                                                            <option value=""></option>
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag.search('search-database-analyses-protein-code-search-by-transporter-class') %]
		                                                                    <option value="[% text.value %]">[% text.value %]</option>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </select>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                                [% IF text.tag.search('search-database-analyses-protein-code-search-by-description') %]
		                                                                    <label>[% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        <input class="form-control" type="text" name="tcdbDesc">
		                                                    </div>
		                                                </div>
	                                                [% END %]
	                                                [% IF phobius %]
		                                                <div id="phobius" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        <div class="checkbox">
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag.search('search-database-analyses-protein-code-not-containing-phobius') %]
		                                                                    <label><input type="checkbox" name="noPhobius">[% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </div>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-analyses-protein-code-number-transmembrane-domain' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="TMdom">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-number-transmembrane-domain-quantity') %]
		                                                                <div class="radio">
		                                                                    <label><input type="radio" name="tmQuant" [% text.details %]> [% text.value %] </label>
		                                                                </div>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-analyses-protein-code-signal-peptide' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-signal-peptide-option') %]
		                                                                <div class="radio">
		                                                                    <label><input type="radio" name="sigP" [% text.details %]> [% text.value %] </label>
		                                                                </div>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                </div>
													[% END %]
	                                                [% IF blast %]
		                                                <div id="blast" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        <div class="checkbox">
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag.search('search-database-analyses-protein-code-not-containing-classification-blast') %]
		                                                                    <label><input type="checkbox" name="noBlast">[% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </div>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-search-by-sequence') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="blastID">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-search-by-description') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="blastDesc">
		                                                    </div>
		                                                </div>
		                                            [% END %]
		                                            [% IF rpsblast %]
		                                                <div id="rpsBlast" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        <div class="checkbox">
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag.search('search-database-analyses-protein-code-not-containing-classification-rpsblast') %]
		                                                                    <label><input type="checkbox" name="noRps">[% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </div>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-search-by-sequence') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="rpsID">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-search-by-description') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="rpsDesc">
		                                                    </div>
		                                                </div>
		                                            [% END %]
		                                            [% IF pathways %]
		                                                <div id="kegg" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        <div class="checkbox">
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag.search('search-database-analyses-protein-code-not-containing-classification-kegg') %]
		                                                                    <label><input type="checkbox" name="noKEGG">[% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </div>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-by-orthology-identifier-kegg') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="koID">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-analyses-protein-code-by-kegg-pathway' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <select class="form-control" name="keggPath">
		                                                            <option value=""></option>
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag.search('search-database-analyses-protein-code-by-kegg-pathway-options') %]
		                                                                    <option value="[% text.details %]">[% text.value %]</option>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </select>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-search-by-description') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="keggDesc">
		                                                    </div>
		                                                </div>
		                                            [% END %]
		                                            [% IF orthology %]
		                                                <div id="orthologyAnalysis" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        <div class="checkbox">
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag.search('search-database-analyses-protein-code-not-containing-classification-eggNOG') %]
		                                                                    <label><input type="checkbox" name="noOrth"> [% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </div>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-eggNOG') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="orthID">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-search-by-description') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="orthDesc">
		                                                    </div>
		                                                </div>
		                                            [% END %]
	                                                [% IF interpro %]
		                                                <div id="interpro" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        <div class="checkbox">
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag.search('search-database-analyses-protein-code-not-containing-classification-interpro') %]
		                                                                    <label><input type="checkbox" name="noIP"> [% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </div>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-interpro') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="interproID">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-search-by-description') %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="interproDesc">
		                                                    </div>
		                                                </div>
		                                            [% END %]
	                                            </div>
	                                            <input class="btn btn-primary btn-sm" type="submit" name="geneIDbutton" value="Search"> 
	                                            <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="clearForm(this.form);">
	                                        </form>
	                                    </div>
	                                </div>
	                            </div>
                            [% END %]
                            [% IF section_dna_based %]
	                            <div id="parentCollapseThree" class="panel panel-default">
	                                <div class="panel-heading">
	                                    <h4 class="panel-title">
	                                        [% FOREACH text IN texts %]
	                                            [% IF text.tag.search('search-database-dna-based-analyses-title') %]
	                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" class="collapsed">[% text.value %]</a>
	                                            [% END %]
	                                        [% END %]
	                                    </h4>
	                                </div>
	                                <div id="collapseThree" class="panel-collapse collapse">
	                                    <div class="panel-body">
	                                        <form method="post" action="/cgi-bin/searchPMNdna.cgi" enctype="multipart/form-data">
	                                            <ul class="nav nav-pills">
	                                                [% FOREACH text IN texts %]
	                                                    [% IF text.tag.search('search-database-dna-based-analyses-tab') %]
	                                                        <li class=""><a href="[% text.details %]" data-toggle="tab">[% text.value %]</a></li>
	                                                    [% END %]
	                                                [% END %]
	                                            </ul>
	                                            <h4></h4>
	                                            <div class="tab-content">
	                                                <div id="contigs" class="tab-pane fade">
	                                                    <div class="form-group">
	                                                        [% FOREACH text IN texts %]
	                                                            [% IF text.tag == 'search-database-dna-based-analyses-only-contig-title' %]
	                                                                <label>[% text.value %]</label>
	                                                            [% END %]
	                                                        [% END %]
	                                                        <select class="form-control"  name="contig">
	                                                            <option value=""></option>
	                                                            [% FOREACH text IN texts %]
	                                                                [% IF text.tag == 'search-database-dna-based-analyses-only-contig' %]
	                                                                    <option value="[% text.value %]">[% text.value %]</option>
	                                                                [% END %]
	                                                            [% END %]
	                                                        </select>
	                                                    </div>
	                                                    <div class="form-group">
	                                                        [% FOREACH text IN texts %]
	                                                            [% IF text.tag == 'search-database-dna-based-analyses-from-base' %]
	                                                                <label>[% text.value %]</label>
	                                                            [% END %]
	                                                        [% END %]
	                                                        <input class="form-control" type="text" name="contigStart">
	                                                    </div>
	                                                    <div class="form-group">
	                                                        [% FOREACH text IN texts %]
	                                                            [% IF text.tag == 'search-database-dna-based-analyses-to' %]
	                                                                <label>[% text.value %]</label>
	                                                            [% END %]
	                                                        [% END %]
	                                                        <input class="form-control" type="text" name="contigEnd">
	                                                    </div>
	                                                    <div class="form-group">
	                                                        <div class="checkbox">
	                                                            [% FOREACH text IN texts %]
	                                                                [% IF text.tag == 'search-database-dna-based-analyses-reverse-complement' %]
	                                                                    <label><input type="checkbox" name="revCompContig">[% text.value %]</label>
	                                                                [% END %]
	                                                            [% END %]
	                                                        </div>
	                                                    </div>
	                                                    <input class="btn btn-primary btn-sm" type="submit" name="geneIDbutton" value="Search"> 
	                                                    <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="clearForm(this.form);">
	                                                </div>
	                                                [% IF trna %]
		                                                <div id="trna" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        <div class="checkbox">
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag == 'search-database-dna-based-analyses-list-rnas' %]
		                                                                    <label><input type="checkbox" name="tRNAall">[% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </div>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-get-by-amino-acid' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <select class="form-control" name="tRNAaa">
		                                                            <option value=""></option>
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag == 'search-database-dna-based-analyses-get-by-amino-acid-options' %]
		                                                                    <option value="[% text.details %]">[% text.value %]</option>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </select>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-get-by-codon' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <select class="form-control" name="tRNAcd">
		                                                            <option value=""></option>
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag == 'search-database-dna-based-analyses-get-by-codon-options' %]
		                                                                    <option value="[% text.details %]">[% text.value %]</option>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </select>
		                                                    </div>
		                                                    <input class="btn btn-primary btn-sm" type="submit" name="geneIDbutton" value="Search"> 
		                                                    <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="clearForm(this.form);">
		                                                </div>
		                                            [% END %]
		                                            [% IF trf OR mreps OR string %]
		                                                <div id="tandemRepeats" class="tab-pane fade">
		                                                    <div class="alert alert-info">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-tandem-repeats' %]
		                                                                [% text.value %]
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-contain-sequence-repetition-unit' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="TRFrepSeq">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-repetition-unit-bases' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="TRFrepSize">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-number-transmembrane-domain-quantity') %]
		                                                                <div class="radio">
		                                                                    <label><input type="radio" name="TRFsize" [% text.details %]>[% text.value %]</label>
		                                                                </div>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-occours-between' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="TRFrepNumMin">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-occours-between-and' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="TRFrepNumMax">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-occours-between-and-times' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <div class="alert alert-warning">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-tandem-repeats-note' %]
		                                                                [% text.value %]
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <input class="btn btn-primary btn-sm" type="submit" name="geneIDbutton" value="Search"> 
		                                                    <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="clearForm(this.form);">
		                                                </div>
		                                            [% END %]
		                                            [% IF infernal %]
		                                                <div id="otherNonCodingRNAs" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-search-ncrna-by-target-identifier' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="ncRNAtargetID">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-or-by-evalue-match' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="ncRNAevalue">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-number-transmembrane-domain-quantity') %]
		                                                                <div class="radio">
		                                                                    <label><input type="radio" name="ncRNAevM" [% text.details %]>[% text.value %]</label>
		                                                                </div>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <div class="form-group">
		                                                        <label>Or by target name: </label>
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-or-by-target-name' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="ncRNAtargetName">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-or-by-target-class' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <select class="form-control"  name="ncRNAtargetClass">
		                                                            <option value=""></option>
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag == 'search-database-dna-based-analyses-or-by-target-class-options' %]
		                                                                    <option value="[% text.details %]">[% text.value %]</option>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </select>
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-or-by-target-type' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="ncRNAtargetType">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-or-by-target-description' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="ncRNAtargetDesc">
		                                                    </div>
		                                                    <input class="btn btn-primary btn-sm" type="submit" name="geneIDbutton" value="Search"> 
		                                                    <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="clearForm(this.form);">
		                                                </div>
		                                            [% END %]
		                                            [% IF rbs %]
		                                                <div id="ribosomalBindingSites" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-ribosomal-binding' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="RBSpattern">
		                                                    </div>
		                                                    <div class="form-group">
		                                                        <div class="checkbox">
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag == 'search-database-dna-based-analyses-or-search-all-ribosomal-binding-shift' %]
		                                                                    <label><input type="checkbox" name="RBSshift">[% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </div>
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-or-search-all-ribosomal-binding-options' %]
		                                                                <div class="radio">
		                                                                    <label><input type="radio" name="RBSshiftM" [% text.details %]>[% text.value %]</label>
		                                                                </div>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <div class="form-group">
		                                                        <div class="checkbox">
		                                                            [% FOREACH text IN texts %]
		                                                                [% IF text.tag == 'search-database-dna-based-analyses-or-search-all-ribosomal-binding-start' %]
		                                                                    <label><input type="checkbox" name="RBSnewcodon">[% text.value %]</label>
		                                                                [% END %]
		                                                            [% END %]
		                                                        </div>
		                                                    </div>
		                                                    <input class="btn btn-primary btn-sm" type="submit" name="geneIDbutton" value="Search"> 
		                                                    <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="clearForm(this.form);">
		                                                </div>
		                                            [% END %]
		                                            [% IF transterm %]
		                                                <div id="transcriptionalTerminators" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-transcriptional-terminators-confidence-score' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="TTconf">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-number-transmembrane-domain-quantity') %]
		                                                                <div class="radio">
		                                                                    <label><input type="radio" name="TTconfM" [% text.details %]>[% text.value %]</label>
		                                                                </div>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-or-hairpin-score' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="TThp">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-number-transmembrane-domain-quantity') %]
		                                                                <div class="radio">
		                                                                    <label><input type="radio" name="TThpM" [% text.details %]>[% text.value %]</label>
		                                                                </div>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-or-tail-score' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="TTtail">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-number-transmembrane-domain-quantity') %]
		                                                                <div class="radio">
		                                                                    <label><input type="radio" name="TTtailM" [% text.details %]>[% text.value %]</label>
		                                                                </div>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <div class="alert alert-warning">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-hairpin-note' %]
		                                                                [% text.value %]
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <input class="btn btn-primary btn-sm" type="submit" name="geneIDbutton" value="Search"> 
		                                                    <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="clearForm(this.form);">
		                                                </div>
		                                            [% END %]
		                                            [% IF alienhunter %]
		                                                <div id="horizontalGeneTransfers" class="tab-pane fade">
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-predicted-alienhunter' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="AHlen">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-number-transmembrane-domain-quantity') %]
		                                                                <div class="radio">
		                                                                    <label><input type="radio" name="AHlenM" [% text.details %]>[% text.value %]</label>
		                                                                </div>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-or-get-regions-score' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="AHscore">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-number-transmembrane-domain-quantity') %]
		                                                                <div class="radio">
		                                                                    <label><input type="radio" name="AHscM" [% text.details %]>[% text.value %]</label>
		                                                                </div>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <div class="form-group">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag == 'search-database-dna-based-analyses-or-get-regions-threshold' %]
		                                                                <label>[% text.value %]</label>
		                                                            [% END %]
		                                                        [% END %]
		                                                        <input class="form-control" type="text" name="AHthr">
		                                                        [% FOREACH text IN texts %]
		                                                            [% IF text.tag.search('search-database-analyses-protein-code-number-transmembrane-domain-quantity') %]
		                                                                <div class="radio">
		                                                                    <label><input type="radio" name="AHthrM" [% text.details %]>[% text.value %]</label>
		                                                                </div>
		                                                            [% END %]
		                                                        [% END %]
		                                                    </div>
		                                                    <input class="btn btn-primary btn-sm" type="submit" name="geneIDbutton" value="Search"> 
		                                                    <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="clearForm(this.form);">
		                                                </div>
		                                            [% END %]
	                                            </div>
	                                        </form>
	                                    </div>
	                                    <div class="panel-footer">
	                                        [% FOREACH text IN texts %]
	                                            [% IF text.tag == 'search-database-dna-based-analyses-footer' %]
	                                                [% text.value %]
	                                            [% END %]
	                                        [% END %]
	                                    </div>
	                                </div>
	                            </div>
	                        [% END %]
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
</div>
<!-- CONTENT-WRAPPER SECTION END-->
CONTENTSEARCHDATABASE
		,
		"index.tt" => <<CONTENTINDEXSEARCHDATABASE
<!DOCTYPE html>
<div class="content-wrapper">
    <div class="container">
        [% INCLUDE '$lowCaseName/search-database/_forms.tt' %]
    </div>
</div>
<script>
    $("#parentCollapseOne").click(function ()
    {
        $("#parentCollapseOne").removeClass("panel-default");
        $("#parentCollapseTwo").removeClass("panel-primary");
        $("#parentCollapseThree").removeClass("panel-primary");
        $("#parentCollapseOne").addClass("panel-primary");
        $("#parentCollapseTwo").addClass("panel-default");
        $("#parentCollapseThree").addClass("panel-default");
    });
    $("#parentCollapseTwo").click(function ()
    {
        $("#parentCollapseTwo").removeClass("panel-default");
        $("#parentCollapseOne").removeClass("panel-primary");
        $("#parentCollapseThree").removeClass("panel-primary");
        $("#parentCollapseTwo").addClass("panel-primary");
        $("#parentCollapseOne").addClass("panel-default");
        $("#parentCollapseThree").addClass("panel-default");
    });
    $("#parentCollapseThree").click(function ()
    {
        $("#parentCollapseThree").removeClass("panel-default");
        $("#parentCollapseTwo").removeClass("panel-primary");
        $("#parentCollapseOne").removeClass("panel-primary");
        $("#parentCollapseThree").addClass("panel-primary");
        $("#parentCollapseOne").addClass("panel-default");
        $("#parentCollapseTwo").addClass("panel-default");
    });
</script>

CONTENTINDEXSEARCHDATABASE
	},
	shared => {
		"_footer.tt" => <<FOOTER
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                [% FOREACH text IN texts %]
                    [% IF text.tag == 'footer' %]
                        <a href="[% c.uri_for(text.details) %]">[% text.value %]</a>
                    [% END %]
                [% END %]

            </div>

        </div>
    </div>
</footer>
FOOTER
		,
		"_head.tt" => <<HEAD
<!DOCTYPE html>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <![endif]-->
<title>[% titlePage %]</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="assets/css/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="assets/css/style.css" rel="stylesheet" />
 <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn''t work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->


HEAD
		,
		"_header.tt" => <<HEADER
<!DOCTYPE html>
<header>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                [% FOREACH text IN texts %]
                    [% IF text.tag.search('header') %]
                        [% IF !(text.tag.search('value')) %]
                            <strong>[% text.value %]</strong>
                        [% ELSE %]
                            [% text.value %]
                            &nbsp;&nbsp;
                        [% END %]
                    [% END %]
                [% END %]
            </div>

        </div>
    </div>
</header>
HEADER
		,
		"_menu.tt" => <<MENU
<!DOCTYPE html>
<div class="navbar navbar-inverse set-radius-zero">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.html">

                <img src="assets/img/logo.png" />
            </a>

        </div>
    </div>
</div>
<!-- LOGO HEADER END-->
<section class="menu-section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="navbar-collapse collapse ">
                    <ul id="menu-top" class="nav navbar-nav navbar-right">
                        [% FOREACH text IN texts %]
                            [% IF text.tag.search('menu') %]
                                [% IF text.value == currentPage %]
                                    <li><a class="menu-top-active" href="[% c.uri_for(text.details) %]">[% text.value %]</a></li>
                                [% ELSE %]
                                	[% IF hadSearchDatabase && text.value.match("search database") %]
			                        	<li><a  href="[% c.uri_for('/searchdatabase') %]">Search database</a></li>
			                        [% ELSIF hadGlobal && text.value.match("global analyses") %]
			                        	<li><a	href="[% c.uri_for('/globalanalyses') %]">Global analyses</a></li>
			                        [% ELSIF !text.value.match("global analyses") && !text.value.match("search database")%]
			                        	<li><a href="[% c.uri_for(text.details) %]">[% text.value %]</a></li>
			                        [% END %]
                                [% END %]
                            [% END %]
                        [% END %]
                        <!--<li><a  class="menu-top-active" href="[% c.uri_for('/home') %]">Home</a></li>
                       	<li><a	href="[% c.uri_for('/blast') %]">BLAST</a></li>
                        <li><a	href="[% c.uri_for('/downloads') %]">Downloads</a></li>
                        <li><a	href="[% c.uri_for('/help') %]">Help</a></li>
                        <li><a	href="[% c.uri_for('/about') %]">About</a></li>-->
                    </ul>
                </div>
            </div>

        </div>
    </div>
</section>

MENU
	}
);

unless($hadGlobal)
{
	delete $contentHTML{"global-analyses"};
}
unless($hadSearchDatabase)
{
	delete $contentHTML{"search-database"};
}

writeFile("log-report-html-db.log", $scriptSQL);

print "Creating html views\n";
foreach my $directory ( keys %contentHTML ) {
	if ( !( -e "$nameProject/root/$lowCaseName/$directory" ) ) {
		`mkdir -p "$nameProject/root/$lowCaseName/$directory"`;
	}
	foreach my $file ( keys %{ $contentHTML{$directory} } ) {
		writeFile( "$nameProject/root/$lowCaseName/$directory/$file",
			$contentHTML{$directory}{$file} );
	}
}

#Create file wrapper
print "Creating wrapper\n";
my $wrapper = <<WRAPPER;
﻿<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        [% INCLUDE '$lowCaseName/shared/_head.tt' %]
        <!-- import _head from Views/Shared -->
    </head>
    <body>
        <!-- CORE JQUERY SCRIPTS -->
        <script src="assets/js/jquery-1.11.1.js"></script>
        <!-- BOOTSTRAP SCRIPTS  -->
        <script src="assets/js/bootstrap.js"></script>
        [% INCLUDE '$lowCaseName/shared/_header.tt' %]
        <!--import _header from Views/Shared-->
        [% INCLUDE '$lowCaseName/shared/_menu.tt' %]
        <!--import _menu from Views/Shared-->
        [% content %]
        <!--Content page-->
        [% INCLUDE '$lowCaseName/shared/_footer.tt' %]
        <!--import _footer from Views/Shared-->
    </body>
</html>
WRAPPER
writeFile( "$nameProject/root/$lowCaseName/_layout.tt", $wrapper );

my $changeRootFile = "
sub index :Path :Args(0) {
    my ( \$self, \$c ) = \@_;

    # Hello World
    #\$c->response->body( \$c->welcome_message );
    \$c->res->redirect('/home');
}

=head2 default
";
print "Editing root file\n";
open( $fileHandler, "<", "$nameProject/lib/$nameProject/Controller/Root.pm" );
$data = do { local $/; <$fileHandler> };
$data =~ 
s/"*sub index :Path :Args\(0\) \{([\s\w()\$,=\@_;\->\{\}\"\[\]\'\:%\/.#]+)\}"*\s*=head2 default*/$changeRootFile/igm;
close($fileHandler);
writeFile( "$nameProject/lib/$nameProject/Controller/Root.pm", $data );

#inicialize server project
#`./$nameProject/script/"$lowCaseName"_server.pl -r`;
print "Done\nTurn on the server with this command:\n./$nameProject/script/"
  . $lowCaseName
  . "_server.pl -r\n"
  . "http://localhost:3000\n";
exit;

###
#   Method used to write files
#   @param $filepath => path with the file to be write or edit
#   @param $content => content to be insert
#
sub writeFile 
{
	my ( $filepath, $content ) = @_;
	open( my $FILEHANDLER, ">:encoding(UTF-8)", $filepath ) or die "Error opening file";
#	binmode($FILEHANDLER, ":utf8");
	print $FILEHANDLER $content;
	close($FILEHANDLER);
}

sub get_code_number_product {
    my $subject_id = shift;
    my $code_number;
    my $product;

    if($subject_id =~ m/\S+\|(\S+)\|(.*)/){
        $code_number = $1;
	$product = $2;
    }
    elsif($subject_id =~ m/(\S+)_(\S+) (.*)/){
        $code_number = $2;
	$product = $3;
    }
    elsif($subject_id =~ m/(\S+)/){
		$code_number = $1;
		
	 	if($code_number =~ m/(\S+)\_\[(\S+)\_\[/){
		    $code_number = $1;
		    $product = "similar to " . $code_number;
		}
    }
 
    $product =~ s/^ //g;
    $product =~ s/ $//g;
    
    return ($code_number, $product);
}
