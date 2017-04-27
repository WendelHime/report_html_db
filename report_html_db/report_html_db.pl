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
use experimental 'smartmatch';

#
# ==> BEGIN OF AUTO GENERATED CODE (do not edit!!!)
#
# generateConfigRead.pl version 2.2
#
#
#begin of module configuration
my $print_conf = <<'CONF';
# Configuration parameters for component (see documentation for details)
# * lines starting with == indicate mandatory parameters, and must be changed to parameter=value
# * parameters containing predefined values indicate component defaults
==organism_name
==uniquename
==fasta_file
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
go_file
TCDB_file=
==homepage_text_file
homepage_banner_image=
CONF

unless (@ARGV) {
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
$version =~ s/.*?: ([\d.]+) \$/$1/;    #

#mandatory fields
#
my $organism_name;
my $fasta_file;
my $standard_dir;
#
#optional arguments and configuration defaults
#
#####

#my $FT_artemis_selected_dir="";
#my $FT_submission_selected_dir="";
#my $GFF_dir="";
#my $GFF_selected_dir="";
my $type_target_class_id = 0;
my $pipeline             = 0;
my $aa_fasta_dir         = "";

my $nt_fasta_dir = "";

#my $xml_dir="xml_dir";
my $fasta_dir = "";

#my $blast_dir="";
#my $rpsblast_dir="";
#my $hmmer_dir="";
#my $signalp_dir="";
#my $tmhmm_dir="";
#my $phobius_dir="";
#my $dgpi_dir="";
#my $predgpi_dir = "";
#my $bigpi_dir = "";
#my $interpro_dir="";
#my $orthology_dir="";
#my $eggnog_dir;
#my $cog_dir;
#my $kog_dir;
#my $orthology_extension="";
#my $pathways_dir="";
my $aa_orf_file = "";

#my $nt_orf_file="";
#my $background_image_file="";
#my $index_file="";
#my $export_subgroup="yes";
#my $overwrite_output="yes";
my @report_pathways_dir = ();

#my $report_orthology_dir;
my @report_eggnog_dir;
my @report_go_dir = ();

#my $eggnog_file;
my @report_kegg_organism_dir = ();

#my $report_cog_dir;
#my $report_kog_dir;
#componentes jota
my $alienhunter_output_file = "";
my $alienhunter_dir         = "";
my $infernal_output_file    = "";
my $infernal_dir            = "";

#my $rbs_output_file = "";
my $rbs_dir     = "";
my $rnammer_dir = "";

#my $transterm_output_file = "";
my $transterm_dir = "";
my $tcdb_dir      = "";
my $skews_dir     = "";
my $trf_dir       = "";
my $trna_dir      = "";
my $string_dir    = "";
my $mreps_dir     = "";

#my $report_csv_dir;
my $filepath_log = "";

#my $csv_file;
my $component_name_list;

#local variables
my @arguments;
my $config;
my $configFile;
my $missingArgument = 0;
my $conf;
my $databases_code;
my $databases_dir;
my $html_file;
my $banner;
my $tcdb_file = "";
my $ko_file;
my $uniquename;

#
#read configuration file
#

my $module = new EGeneUSP::Config($version);

$module->initialize();

$config = $module->config;
#
#check if any mandatory argument is missing
#
if (   !exists( $config->{"organism_name"} )
	|| !exists( $config->{"uniquename"} ) )
{
	$missingArgument = 1;
	print "Missing mandatory configuration argument:organism_name\n";
}
else { $organism_name = $config->{"organism_name"} }
if ( !exists( $config->{"fasta_file"} ) ) {
}
else { $fasta_file = $config->{"fasta_file"} }
if ($missingArgument) {
	die
"\n\nCannot run $0, mandatory configuration argument missing (see above)\n";
}
#
#set optional arguments that were declared in configuration file
#
if ( defined( $config->{"std_dir"} ) ) {
	$standard_dir = $config->{"std_dir"};
}
if ( defined( $config->{"aa_fasta_dir"} ) ) {
	$aa_fasta_dir = $config->{"aa_fasta_dir"};
}

if ( defined( $config->{"nt_fasta_dir"} ) ) {
	$nt_fasta_dir = $config->{"nt_fasta_dir"};
}
if ( defined( $config->{"fasta_dir"} ) ) {
	$fasta_dir = $config->{"fasta_dir"};
}

=pod
if (defined($config->{"blast_dir"})){
   $blast_dir = $config->{"blast_dir"};
}
=cut

if ( defined( $config->{"aa_orf_file"} ) ) {
	$aa_orf_file = $config->{"aa_orf_file"};
}

#if (defined($config->{"nt_orf_file"})){
#   $nt_orf_file = $config->{"nt_orf_file"};
#}
if ( defined( $config->{"type_target_class_id"} ) ) {
	$type_target_class_id = $config->{"type_target_class_id"};
}
if ( defined( $config->{"pipeline"} ) ) {
	$pipeline = $config->{"pipeline"};
}

#componentes do Jota
if ( defined( $config->{"alienhunter_output_file"} ) ) {
	$alienhunter_output_file = $config->{"alienhunter_output_file"};
}
if ( defined( $config->{"alienhunter_dir"} ) ) {
	$alienhunter_dir = $config->{"alienhunter_dir"};
}
if ( defined( $config->{"infernal_output_file"} ) ) {
	$infernal_output_file = $config->{"infernal_output_file"};
}
if ( defined( $config->{"infernal_dir"} ) ) {
	$infernal_dir = $config->{"infernal_dir"};
}
if ( defined( $config->{"rbs_dir"} ) ) {
	$rbs_dir = $config->{"rbs_dir"};
}
if ( defined( $config->{"rnammer_dir"} ) ) {
	$rnammer_dir = $config->{"rnammer_dir"};
}
if ( defined( $config->{"transterm_dir"} ) ) {
	$transterm_dir = $config->{"transterm_dir"};
}
if ( defined( $config->{"tcdb_dir"} ) ) {
	$tcdb_dir = $config->{"tcdb_dir"};
}
if ( defined( $config->{"skews_dir"} ) ) {
	$skews_dir = $config->{"skews_dir"};
}
if ( defined( $config->{"trf_dir"} ) ) {
	$trf_dir = $config->{"trf_dir"};
}

if ( defined( $config->{"trna_dir"} ) ) {
	$trna_dir = $config->{"trna_dir"};
}

if ( defined( $config->{"string_dir"} ) ) {
	$string_dir = $config->{"string_dir"};
}

if ( defined( $config->{"mreps_dir"} ) ) {
	$mreps_dir = $config->{"mreps_dir"};
}

if ( defined( $config->{"report_go_dir"} ) ) {
	@report_go_dir = split( ";", $config->{"report_go_dir"} );
}

if ( defined( $config->{"report_eggnog_dir"} ) ) {
	@report_eggnog_dir = split( ";", $config->{"report_eggnog_dir"} );
}
if ( defined( $config->{"report_pathways_dir"} ) ) {
	@report_pathways_dir = split( ";", $config->{"report_pathways_dir"} );
}
if ( defined( $config->{"comparative_metabolic_reconstruction"} ) ) {
	@report_kegg_organism_dir =
	  split( ";", $config->{"report_kegg_organism_dir"} );
}
if ( defined( $config->{"database_code_list"} ) ) {
	$databases_code = $config->{"database_code_list"};
}

if ( defined( $config->{"blast_dir_list"} ) ) {
	$databases_dir = $config->{"blast_dir_list"};
}
if ( defined( $config->{"homepage_text_file"} ) ) {
	$html_file = $config->{"homepage_text_file"};
}
if ( defined( $config->{"homepage_banner_image"} ) ) {
	$banner = $config->{"homepage_banner_image"};
}
if ( defined( $config->{"TCDB_file"} ) ) {
	$tcdb_file = $config->{"TCDB_file"};
}
if ( defined( $config->{"ko_file"} ) ) {
	$ko_file = $config->{"ko_file"};
}
if ( defined( $config->{"uniquename"} ) ) {
	$uniquename = $config->{"uniquename"};
}
if ( defined( $config->{"filepath_log"} ) ) {
	$filepath_log = $config->{"filepath_log"};
}
if ( defined( $config->{"component_name_list"} ) ) {
	$component_name_list = $config->{"component_name_list"};
}

#
# ==> END OF AUTO GENERATED CODE
#

open( my $LOG, ">", $filepath_log );
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

CREATE TABLE FILES (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	tag VARCHAR(200),
	filepath VARCHAR(2000),
	details VARCHAR(2000)
);

CREATE TABLE COMPONENTS(
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,  
	name VARCHAR(2000),
	locus_tag VARCHAR(2000),
	component VARCHAR(2000),
	filepath VARCHAR(2000)
);

CREATE TABLE SEQUENCES(
	id INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(2000),
	filepath VARCHAR(2000)
);

INSERT INTO TEXTS(tag, value, details) VALUES
        ("menu", "home", "/"),
        ("menu", "blast", "/Blast"),
        ("menu", "search database", "/SearchDatabase"),
        ("menu", "global analyses", "/GlobalAnalyses"),
        ("menu", "downloads", "/Downloads"),
        ("menu", "help", "/Help"),
        ("menu", "about", "/About"),
        ("blast-form-title", "Choose program to use and database to search:", ""),
        ("blast-program-title", "Program:", "http://puma.icb.usp.br/blast/docs/blast_program.html"),
        ("blast-program-option", "blastn", ""),
        ("blast-program-option", "blastp", ""),
        ("blast-program-option", "blastx", ""),
        ("blast-program-option", "tblastn", ""),
        ("blast-program-option", "tblastx", ""),
        ("blast-database-title", "Database:", ""),
        ("blast-database-option", "All genes", "PMN_genome_1"),
        ("blast-database-option", "Contigs", "PMN_genes_1"),
        ("blast-database-option", "Protein code", "PMN_prot_1"),
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
        ("search-database-gene-ids-descriptions-title", "Protein-sequence and gene IDs", ""),
        ("search-database-gene-ids-descriptions-tab", "<a href='#geneIdentifier' data-toggle='tab'>Gene identifier</a>", "class='active'"),
        ("search-database-gene-ids-descriptions-tab", "<a href='#geneDescription' data-toggle='tab'>Gene description</a>", ""),
        ("search-database-gene-ids-descriptions-gene-id", "Gene ID: ", ""),
        ("search-database-gene-ids-descriptions-gene-description", "Description: ", ""),
        ("search-database-gene-ids-descriptions-gene-excluding", "Excluding: ", ""),
        ("search-database-gene-ids-descriptions-gene-match-all", "Match all terms", ""),
        ("search-database-analyses-protein-code-title", "Analyses of protein-coding genes", ""),
        ("search-database-analyses-protein-code-limit", "Limit by term(s) in gene description(optional): ", ""),
        ("search-database-analyses-protein-code-excluding", "Excluding: ", ""),
        ("search-database-analyses-protein-code-tab", "KEGG", "#kegg"),
        ("search-database-analyses-protein-code-tab", "Orthology analysis (eggNOG)", "#orthologyAnalysis"),
        ("search-database-analyses-protein-code-tab", "Interpro", "#interpro"),
        
        
        ("search-database-analyses-protein-code-search-by-sequence", "Search by sequence identifier of match:", ""),
        ("search-database-analyses-protein-code-search-by-description", "Or by description of match:", ""),
        
        ("search-database-analyses-protein-code-not-containing-classification-rpsblast", " not containing RPSBLAST matches", ""),
        
        ("search-database-dna-based-analyses-title", "DNA-based analyses", ""),
        ("search-database-dna-based-analyses-tab", "Contigs", "#contigs"),
        ("search-database-dna-based-analyses-tab", "Tandem repeats", "#tandemRepeats"),
        ("search-database-dna-based-analyses-tab", "Other non-coding RNAs", "#otherNonCodingRNAs"),
        ("search-database-dna-based-analyses-tab", "Transcriptional terminators", "#transcriptionalTerminators"),
        ("search-database-dna-based-analyses-tab", "Horizontal gene transfers", "#horizontalGeneTransfers"),
        ("search-database-dna-based-analyses-only-contig-title", "Get only contig: ", ""),
        ("search-database-dna-based-analyses-from-base", " from base ", ""),
        ("search-database-dna-based-analyses-to", " to ", ""),
        ("search-database-dna-based-analyses-reverse-complement", " reverse complement?", "");

INSERT INTO TEXTS(tag, value, details) VALUES
		("search-database-dna-based-analyses-tandem-repeats", "Get all tandem repeats that: ", ""),
        ("search-database-dna-based-analyses-contain-sequence-repetition-unit", "Contain the sequence in the repetition unit:", ""),
        ("search-database-dna-based-analyses-repetition-unit-bases", "Has repetition units of bases: ", ""),
        ("search-database-dna-based-analyses-occours-between", "Occurs between ", ""),
        ("search-database-dna-based-analyses-occours-between-and", "and", ""),
        ("search-database-dna-based-analyses-occours-between-and-times", "times", ""),
        ("search-database-dna-based-analyses-tandem-repeats-note", "NOTE: to get an exact number of repetitions, enter the same number in both boxes (numbers can have decimal places). Otherwise, to get 5 or more repetitions, enter 5 in the first box and nothing in the second; for 5 or less repetitions, enter 5 in the second box and nothing in the first. See the 'Help' section for further instructions.", ""),
        
        ("search-database-dna-based-analyses-footer", "Search categories in the DNA-based analyses are <b>not</b> additive, i.e. only the category whose ""Search"" button has been pressed will be searched.", ""),
        ("global-analyses-go-terms-mapping", "GO terms mapping", ""),
        ("global-analyses-go-terms-mapping-footer", "NOTE: Please use Mozilla Firefox, Safari or Opera browser to visualize the expansible trees. If you are using Internet Explorer, please use the links to ""Table of ontologies"" to visualize the results.", ""),
        ("global-analyses-eggNOG", "eggNOG", ""),
        ("global-analyses-kegg-pathways", "KEGG Pathways", ""),
        ("global-analyses-comparative-metabolic-reconstruction", "Comparative Metabolic Reconstruction", ""),
        ("downloads-genes", "Genes", ""),
        ("downloads-other-sequences", "Other sequences", ""),
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
        ("result-warning-contigs", "Stretch not exist", "");
        
	INSERT INTO TEXTS(tag, value, details) VALUES
		("search-database-analyses-protein-code-not-containing-classification-eggNOG", " not containing eggNOG matches", ""),
        ("search-database-analyses-protein-code-eggNOG", "Search by eggNOG identifier: ", "");
        
    INSERT INTO TEXTS(tag, value, details) VALUES
		("search-database-analyses-protein-code-not-containing-classification-kegg", " not containing KEGG pathway matches", ""),
        ("search-database-analyses-protein-code-by-orthology-identifier-kegg", "Search by KEGG orthology identifier:", ""),
        ("search-database-analyses-protein-code-by-kegg-pathway", "Or by KEGG pathway:", ""),
        ("search-database-analyses-protein-code-not-containing-classification", " not containing Gene Ontology classification", ""),
        ("search-database-analyses-protein-code-not-containing-classification-interpro", " not containing InterProScan matches", ""),
        ("search-database-analyses-protein-code-interpro", "Search by InterPro identifier: ", ""),
        ("search-database-analyses-protein-code-not-containing-classification-blast", " not containing BLAST matches", "");
SQL

#        ("search-database-dna-based-analyses-only-contig", "contig00028", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig00044", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig00045", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig00046", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig00053", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig00060", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig00076", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig00078", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig00086", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig00089", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig00093", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig_1.2", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig_1.3", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig_1.7", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig_2.1", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig_2.2", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig_2.3", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig_2.4", ""),
#        ("search-database-dna-based-analyses-only-contig", "contig_2.5", ""),

###
#
#	Realiza a leitura do arquivo example.html
#	Pega o conteúdo e concatena a query no script SQL
#
###
$scriptSQL .= readJSON($html_file);
print $LOG "\n$html_file read!\n";

###
#
#	Realiza leitura do arquivo de TCDBs
#
###
if ($tcdb_file) {
	$scriptSQL .= readTCDBFile($tcdb_file);
	$scriptSQL .= <<SQL;
	INSERT INTO TEXTS(tag, value, details) VALUES
		("search-database-analyses-protein-code-tab", "Transporter classification", "#transporterClassification"),
        ("search-database-analyses-protein-code-not-containing-classification-tcdb", " not containing TCDB classification", ""),
        ("search-database-analyses-protein-code-search-by-transporter-identifier", "Search by transporter identifier(e.g. 1.A.3.1.1):", ""),
        ("search-database-analyses-protein-code-search-by-transporter-family", "Or by transporter family(e.g. 3.A.17):", ""),
        ("search-database-analyses-protein-code-search-by-transporter-subclass", "Or by transporter subclass:", ""),
        ("search-database-analyses-protein-code-search-by-transporter-class", "Or by transporter class:", ""),
        ("search-database-dna-based-analyses-search-ncrna-by-target-identifier", "Search ncRNA by target identifier: ", ""),
        ("search-database-dna-based-analyses-or-by-evalue-match", "Or by E-value of match: ", ""),
        ("search-database-dna-based-analyses-or-by-target-name", "Or by target name: ", ""),
        ("search-database-dna-based-analyses-or-by-target-class", "Or by target class: ", ""),
        ("search-database-dna-based-analyses-or-by-target-type", "Or by target type: ", ""),
        ("search-database-dna-based-analyses-or-by-target-description", "Or by target description: ", "");
SQL
}
print $LOG "\n$tcdb_file read!\n";

#apaga diretorios antigos com fastas
print $LOG "\nDeleting old fasta directories\n";

#if(-d "$html_dir/root/$fasta_dir" && -d "$html_dir/root/$aa_fasta_dir" && -d "$html_dir/root/$nt_fasta_dir")
#{
#    !system("rm -r $html_dir/root/$fasta_dir $html_dir/root/$aa_fasta_dir $html_dir/root/$nt_fasta_dir")
#	or die "Could not removed directories\n";
#}

print $LOG "\nSeparating sequences od multifasta and create directory\n";

#separa sequencias do multifasta e cria diretorio
my $html_dir     = "website";
my $services_dir = "services";
print $LOG "\nCreating $html_dir\n";
!system("mkdir -p $html_dir")
  or die "Could not created directory $html_dir\n";
print $LOG "\nCreating $fasta_dir\n";
!system("mkdir -p $html_dir/root/$fasta_dir")
  or die "Could not created directory $html_dir/root/$fasta_dir\n";

#print $LOG "Separating ORFs em AA of multifasta AA";
##separa ORFs em aa do multifasta aa
print $LOG "\nCreating $aa_fasta_dir\n";
!system("mkdir -p $html_dir/root/$aa_fasta_dir")
  or die "Could not created directory $html_dir/root/$aa_fasta_dir\n";
#
#if ( $aa_orf_file ne "" ) {
#	open( FILE_AA, "$aa_orf_file" ) or print $LOG "Could not open file $aa_orf_file\n";
#}
#
#print $LOG "Separating ORFs NT of multifasta NT";
##separa ORFs nt do multifasta nt
print $LOG "\nCreating $nt_fasta_dir\n";
!system("mkdir -p $html_dir/root/$nt_fasta_dir")
  or print $LOG "Could not created directory $html_dir/root/$nt_fasta_dir\n";

#if($nt_orf_file ne "")
#{
#    open(FILE,"$nt_orf_file") or die "Could not open file $nt_orf_file\n";
#}

#prefix_name for sequence
my $prefix_name;
my $header;
print $LOG "\nComponent list: " . $component_name_list . "\n";
my @components_name = split( ';', $component_name_list );

#push @components_name,"go_terms";
my @comp_dna = ();
my @comp_ev  = ();
foreach my $c ( sort @components_name ) {
	if (   $c eq "annotation_alienhunter.pl"
		|| $c eq "annotation_skews.pl"
		|| $c eq "annotation_infernal.pl"
		|| $c eq "annotation_rbsfinder.pl"
		|| $c eq "annotation_rnammer.pl"
		|| $c eq "annotation_transterm.pl"
		|| $c eq "annotation_trf.pl"
		|| $c eq "annotation_trna.pl"
		|| $c eq "annotation_string.pl"
		|| $c eq "annotation_mreps.pl"
		|| $c eq "annotation_glimmer3.pl"
		|| $c eq "annotation_trna.pl"
		|| $c eq "annotation_alienhunter.pl" )
	{
		$c =~ s/.pl//g;
		push @comp_dna, $c;
	}
	else {
		$c =~ s/.pl//g;
		push @comp_ev, $c;
	}
}
#
# Read ALL Sequence Objects and sort by name for nice display
#

my @sequence_objects;
my $index = 0;

my $strlen    = 4;
my $count_seq = 1;

my $sequence_object = new EGeneUSP::SequenceObject();
my %hash_ev         = ();
my %hash_dna        = ();
my @seq_links;

#contador de sequencias
my $seq_count           = 0;
my %components          = ();
my @filepathsComponents = ();
my $dbName              = "";
my $dbHost              = "";
my $dbUser              = "";
my $dbPassword          = "";
my $locus               = 0;

if ( scalar @report_go_dir > 0 ) {
	foreach my $path (@report_go_dir) {
		$components{"report_go"} .= $path . ";";
		$scriptSQL .=
"\nINSERT INTO COMPONENTS(name, component, filepath) VALUES('go', 'report_go', '$components{report_go}');\n";
	}
}
if ( scalar @report_eggnog_dir > 0 ) {
	foreach my $path (@report_eggnog_dir) {
		$components{"report_eggnog"} .= $path . ";";
		$scriptSQL .=
"\nINSERT INTO COMPONENTS(name, component, filepath) VALUES('eggnog', 'report_eggnog', '$components{report_eggnog}');\n";
	}
}
if ( scalar @report_pathways_dir > 0 ) {
	foreach my $path (@report_pathways_dir) {
		$components{"report_pathways"} .= $path . ";";
		$scriptSQL .=
"\nINSERT INTO COMPONENTS(name, component, filepath) VALUES('pathways', 'report_pathways', '$components{report_pathways}');\n";
	}
}
if ( scalar @report_kegg_organism_dir > 0 ) {
	foreach my $path (@report_kegg_organism_dir) {
		$components{"report_kegg_organism"} .= $path . ";";
		$scriptSQL .=
"\nINSERT INTO COMPONENTS(name, component, filepath) VALUES('kegg_organism', 'report_kegg_organism', '$components{report_kegg_organism}');\n";
	}
}

print $LOG "\nReading sequences\n";
while ( $sequence_object->read() ) {
	++$seq_count;
	$header = $sequence_object->fasta_header();
	my @conclusions = @{ $sequence_object->get_conclusions() };
	my $n           = scalar(@conclusions);

	#	print STDERR "N de conc: $n\n";
	my $bases = $sequence_object->current_sequence();
	my $name  = $sequence_object->sequence_name();
	$dbName     = $sequence_object->{dbname};
	$dbHost     = $sequence_object->{host};
	$dbUser     = $sequence_object->{user};
	$dbPassword = $sequence_object->{password};
	print $LOG "\nDatabase name:\t$dbName\nHost:\t$dbHost\nUser:\t$dbUser\n";

#aqui começaria a geração da pagina relacionada a cada anotação
#pulando isso, passamos para geração dos arquivos, volta a duvida sobre a necessidade desses arquivos
	my $file_aa = $name . "_CDS_AA.fasta";
	my $file_nt = $name . "_CDS_NT.fasta";
	open( FILE_AA, ">$html_dir/root/$aa_fasta_dir/$file_aa" );
	open( FILE_NT, ">$html_dir/root/$nt_fasta_dir/$file_nt" );

	#	print $LOG "\n$name\n$bases\n\n";
	$scriptSQL .=
	    "\nINSERT INTO SEQUENCES(id, name, filepath) VALUES ("
	  . $sequence_object->{sequence_id} . ", '"
	  . $name . "', '"
	  . $fasta_dir . "/"
	  . $name
	  . ".fasta');\n";

#    my $ann_file = "annotations/".$name;
# no script original(report_html.pl) começa a criação da pagina principal onde são listadas as sequencias
# pulando essa parte, começamos a escrita do arquivo fasta, entra em duvida a necessidade desse arquivo
	open( FASTAOUT, ">$html_dir/root/$fasta_dir/$name.fasta" )
	  or die
	  "could not create fasta file $html_dir/root/$fasta_dir/$name.fasta\n";
	my $length = length($bases);
	print FASTAOUT ">$name\n";
	print FASTAOUT $bases;
	close(FASTAOUT);

#	my @logs = @{ $sequence_object->get_logs_hash() };

	foreach my $conclusion (@conclusions) {
		$sequence_object->get_evidence_for_conclusion();
		my %hash      = %{ $sequence_object->{array_evidence} };
		my @evidences = @{ $conclusion->{evidence_number} };

		###
		#
		# Receber lista de componentes rodados
		#
		###

		foreach my $ev (@evidences) {
			my $evidence      = $hash{$ev};
			my $ev_name = $sequence_object->fasta_header_evidence($evidence);
			$ev_name =~ s/>//;
			my $fasta_header_evidence =
			  $sequence_object->fasta_header_evidence($evidence);

			$fasta_header_evidence =~ s/>//g;
			$fasta_header_evidence =~ s/>//g;
			$fasta_header_evidence =~ s/\|/_/g;
			$fasta_header_evidence =~ s/__/_/g;

			$fasta_header_evidence =~ s/>//g;

			my $component = $sequence_object->fasta_header_program($evidence);
			my $component_name =
			  !$evidence->{log}{name}
			  ? ( $component =~ /(annotation[_\w]+)/g )[0]
			  : $evidence->{log}{name};
			$component_name =~ s/.pl//g;
			my $locus_tag;

			if ( $conclusion->{locus_tag} ) {
				$locus_tag = $conclusion->{locus_tag};
			}
			else {
				$locus++;
				$locus_tag = "NOLOCUSTAG_$locus";
			}
			
			if ( $component && $component_name ) {
				my $resp = verify_element( $component_name, \@comp_dna );
				print $LOG "\n[948] $component_name -  resp = $resp\n";
				if ($resp) {
					if (   !exists $components{$component}
						&& !$components{$component} )
					{
						if ( $component_name eq "annotation_trf" ) {
							my $file = $name . "_trf.txt";
							$components{$component} = "$component/$file";
						}
						elsif ( $component_name eq "annotation_trna" ) {
							my $file = $name . "_trna.txt";
							$components{$component} = "$component/$file";
							$scriptSQL .= <<SQL;
				INSERT INTO TEXTS(tag, value, details) VALUES 
					("search-database-dna-based-analyses-tab", "tRNA", "#trna"),
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
			        ("search-database-dna-based-analyses-get-by-amino-acid-options", "Valine (V)", "Val"),
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
			        ("search-database-dna-based-analyses-get-by-codon-options", "TTT", "TTT");
SQL
						}
						elsif ( $component_name eq "annotation_alienhunter" ) {
							my $name = $sequence_object->{sequence_name};
							my $file = $alienhunter_output_file . "_" . $name;
							$components{$component} = $component . "/" . $file;
							$scriptSQL .= <<SQL;
				INSERT INTO TEXTS(tag, value, details) VALUES 
					("search-database-dna-based-analyses-predicted-alienhunter", "Get predicted AlienHunter regions of length: ", ""),
			        ("search-database-dna-based-analyses-or-get-regions-score", "Or get regions of score: ", ""),
			        ("search-database-dna-based-analyses-or-get-regions-threshold", "Or get regions of threshold: ", "");
SQL
						}
						elsif ( $component_name eq "annotation_infernal" ) {
							my $file = $infernal_output_file . "_" . $name;
							$components{$component} = "$component/$file";
						}
						elsif ( $component_name eq "annotation_skews" ) {
							my $filestring = `ls $skews_dir`;
							my @phdfilenames = split( /\n/, $filestring );
							my $seq_name = $sequence_object->sequence_name();
							my $aux      = "";
							foreach my $file (@phdfilenames) {
								if (    $file =~ m/$seq_name/
									and $file =~ m/.png/ )
								{
									$aux .= "$component/$file\n";
								}
							}
							$components{$component} = $aux;
						}
						elsif ( $component_name eq "annotation_rbsfinder" ) {
							my $file = $name . ".txt";
							$components{$component} = "$component/$file";
							$scriptSQL .= <<SQL;
				INSERT INTO TEXTS(tag, value, details) VALUES 
					("search-database-dna-based-analyses-tab", "Ribosomal binding sites", "#ribosomalBindingSites"),
			        ("search-database-dna-based-analyses-ribosomal-binding", "Search ribosomal binding sites containing sequence pattern: ", ""),
			        ("search-database-dna-based-analyses-or-search-all-ribosomal-binding-shift", " Or search for all ribosomal binding site predictions that recommend a shift in start codon position", ""),
			        ("search-database-dna-based-analyses-or-search-all-ribosomal-binding-options", " upstream", "value='neg' checked"),
			        ("search-database-dna-based-analyses-or-search-all-ribosomal-binding-options", " downstream", "value='pos'"),
			        ("search-database-dna-based-analyses-or-search-all-ribosomal-binding-options", " either", "value='both'"),
			        ("search-database-dna-based-analyses-or-search-all-ribosomal-binding-start", "Or search for all ribosomal binding site predictions that recommend a change of  start codon", "");
SQL
						}
						elsif ( $component_name eq "annotation_rnammer" ) {
							my $file = $name . "_rnammer.gff";
							$components{$component} = "$component/$file";
						}
						elsif ( $component_name eq "annotation_glimmer3" ) {
							$components{$component} =
							  $component . "/glimmer3.txt";
						}
						elsif ( $component_name eq "annotation_transterm" ) {
							my $file = $name . ".txt";
							$components{$component} = "$component/$file";
							$scriptSQL .= <<SQL;
				INSERT INTO TEXTS(tag, value, details) VALUES 
					("search-database-dna-based-analyses-transcriptional-terminators-confidence-score", "Get transcriptional terminators with confidence score: ", ""),
			        ("search-database-dna-based-analyses-or-hairpin-score", "Or with hairpin score: ", ""),
			        ("search-database-dna-based-analyses-or-tail-score", "Or with tail score: ", ""),
			        ("search-database-dna-based-analyses-hairpin-note", "NOTE: hairpin and tail scores are negative.", "");
SQL
						}
						elsif ( $component_name eq "annotation_mreps" ) {
							my $name = $sequence_object->{sequence_name};
							my $file = $component . "/" . $name . "_mreps.txt";
							$components{$component} = "$file";
						}
						elsif ( $component_name eq "annotation_string" ) {
							my $name = $sequence_object->{sequence_name};
							my $file =
							  $string_dir . "/" . $name . "_string.txt";
							$components{$component} = "$component/$file";
						}
					}
#					if ( $component_name =~ /annotation_/g ) {
#						$component_name =~ s/annotation_//g;
#					}
#					els
					if ( $component_name =~ /report_/g ) {
						$component_name =~ s/report_//g;
					}

					push @filepathsComponents, $components{$component};

#					print STDERR "\n[1119] Name:\t$component_name\nComponent:\t$component\nfilepath:\t$components{$component}\n\n";
					$scriptSQL .=
"\nINSERT INTO COMPONENTS(name, locus_tag, component, filepath) VALUES('$component_name', '$locus_tag', '$component', '$components{$component}');\n";
				}

			}
			
			$fasta_header_evidence =~ s/>//g;
			$fasta_header_evidence =~ s/>//g;
			$fasta_header_evidence =~ s/\|/_/g;
			$fasta_header_evidence =~ s/__/_/g;
			my $html_file = $fasta_header_evidence . ".html";
			my $txt_file  = $fasta_header_evidence . ".txt";
			my $png_file  = $fasta_header_evidence . ".png";
			$component_name = $evidence->{log}{name};
			$fasta_header_evidence =~ s/>//g;

			if ( $evidence->{tag} eq "CDS" ) {

				#				foreach my $subevidence ( @{ $evidence->{evidences} } ) {
				#					push @subevidences, $subevidence;
				#				}

				

				print $LOG "\nLocus tag: " . $locus_tag . "\n";

				#####
#
#
#	Sequência da evidência: verificar o campo strand (tag intervals) e calcular o reverso complementar da sequência caso a fita seja negativa (verificar se a strand é ‘-1’ ou ‘-’)
#
#
				#####

				my $number = $evidence->{number};
				my $start;
				my $end;

				if ( $evidence->{start} < $evidence->{end} ) {
					$start = $evidence->{start};
					$end   = $evidence->{end};
				}
				else {
					$start = $evidence->{end};
					$end   = $evidence->{start};
				}
#				@logs = ();
#				foreach my $log (@logs) {
#					my %hash_log = %{$log};
#					my $log_name = $hash_log{program};
#
#					#					$log_name =~ s/annotation_//g;
#					$log_name =~ s/.pl//g;
#					my $resp = verify_element( $log_name, \@comp_ev );
#					if ($resp) {
#						my $dir =
#						  $hash_log{program} . "_log_" . $hash_log{log_number};
#						if ( $log_name eq "blast" ) {
#	
#						}
#						elsif ( $component_name eq "annotation_interpro" ) {
#							$components{$component} = "$dir/HTML/$html_file";
#						}
#						elsif ( $log_name eq "annotation_orthology" ) {
#							my $code;
#							
#							while ( $hash_log{arguments} =~
#								/database_code\s*=\s*(\w+)+\s*/ig )
#							{
#								$code = $1;
#							}
#							my $aux_html = $html_file;
#							$code = "." . $code . ".html";
#							$aux_html =~ s/.html/$code/g;
#							$components{$component} = "$dir/$aux_html";
#						}
#						elsif ( $log_name eq "annotation_pathways" ) {
#							###
#							#
#							#	Pegando todos os pathways do arquivo KO
#							#
#							###
#							open( my $KOFILE, "<", $ko_file )
#							  or warn
#							  "WARNING: Could not open KO file $ko_file: $!\n";
#							my $content        = do { local $/; <$KOFILE> };
#							my @idKEGG         = ();
#							my %workAroundSort = (); 
#							while (
#								$content =~ /[PATHWAY]*\s+ko(\d*)\s*(.*)/gm )
#							{
#								if ( !( $1 ~~ @idKEGG ) && $1 ne "" ) {
#									$workAroundSort{$2} = $1;
#									push @idKEGG, $1;
#								}
#							}
#
#							foreach my $key ( sort keys %workAroundSort ) {
#								my $value = $workAroundSort{$key};
#							}
#							close($KOFILE);
#							$components{$component} = "$dir/$html_file";
#							
#						}
#						elsif ( $log_name eq "annotation_phobius" ) {
#							$components{$component} = "$dir/$png_file";
#						}
#						elsif ( $component_name eq "annotation_rpsblast.pl" ) {
#							$components{$component} = "$dir/$txt_file";
#
#						}
#						elsif ( $log_name eq "annotation_signalP" ) {
#							$components{$component} = "$dir/$png_file";
#						}
#						elsif ( $log_name eq "annotation_psort" ) {
#							$components{$component} = "psort_dir/$txt_file";
#						}
#					}
#				}
				my @sub_evidences = @{ $evidence->{evidences} };
				
				foreach my $sub_evidence (@sub_evidences) {
					my $component_name = $sub_evidence->{log}{name};
#					print STDERR "\n[1252]\t$sub_evidence->{log}{arguments}\n";
					$component_name =~ s/.pl//g;
					my $component =
					  $sequence_object->fasta_header_program($sub_evidence);

#					print STDERR "\n[1297] - Program ev: $program_ev\n";
					#$signalp_dir = $program_ev;
					my $resp = verify_element( $component_name, \@comp_ev );
					print $LOG "\n[1263] - $component - $component_name - resp = $resp - locus_tag = $locus_tag\n";
#					print STDERR "\n[1263]\t-\t$component/$html_file\n";
					
					if (  $resp  )
					{
#						print STDERR "\n[1268]\t-\t$component_name\t$component/$html_file\n" ;
						if ( $component_name eq "annotation_blast" ) {
							$scriptSQL .= <<SQL;
				INSERT INTO TEXTS(tag, value, details) VALUES
					("search-database-analyses-protein-code-tab", "BLAST", "#blast");
SQL
							$components{$component} = "$component/$html_file";
							$scriptSQL .=
								"\nINSERT INTO COMPONENTS(name, locus_tag, component, filepath) VALUES('$component_name', '$locus_tag', '$component', '$component/$html_file');\n";

					   #print $LOG "\nComponent blast test[917]:\t$component\n";
						}
						elsif ( $component_name eq "annotation_glimmer3" ) {
							$components{$component} =
							  $component . "/glimmer3.txt";
							  $scriptSQL .=
								"\nINSERT INTO COMPONENTS(name, locus_tag, component, filepath) VALUES('$component_name', '$locus_tag', '$component', '$component/glimmer3.txt');\n";
						}
						elsif ( $component_name eq "annotation_interpro" ) {
							$components{$component} = "$component/";
							$scriptSQL .=
								"\nINSERT INTO COMPONENTS(name, locus_tag, component, filepath) VALUES('$component_name', '$locus_tag', '$component', '$component/HTML/$html_file');\n";
							$scriptSQL .= <<SQL;
				INSERT INTO TEXTS(tag, value, details) VALUES
					("search-database-analyses-protein-code-tab", "Gene ontology", "#geneOntology");
SQL
						}
						elsif ( $component_name eq "annotation_orthology" ) {
							my $code;
							
							while ( $sub_evidence->{log}{arguments} =~
								/database_code\s*=\s*(\w+)+\s*/ig )
							{
								$code = $1;
							}
							my $aux_html = $html_file;
							$code = "." . $code . ".html";
							$aux_html =~ s/.html/$code/g;
							$components{$component} = "$component/$aux_html";
							$scriptSQL .=
								"\nINSERT INTO COMPONENTS(name, locus_tag, component, filepath) VALUES('$component_name', '$locus_tag', '$component', '$component/$aux_html');\n";
							$scriptSQL .= <<SQL;
				INSERT INTO TEXTS(tag, value, details) VALUES
					("search-database-analyses-protein-code-tab", "Orthology", "#orthologyAnalysis");
SQL
						}
						elsif ( $component_name eq "annotation_pathways" ) {
							###
							#
							#	Pegando todos os pathways do arquivo KO
							#
							###
							open( my $KOFILE, "<", $ko_file )
							  or warn
							  "WARNING: Could not open KO file $ko_file: $!\n";
							my $content        = do { local $/; <$KOFILE> };
							my @idKEGG         = ();
							my %workAroundSort = ();
							while (
								$content =~ /[PATHWAY]*\s+ko(\d*)\s*(.*)/gm )
							{
								if ( !( $1 ~~ @idKEGG ) && $1 ne "" ) {
									$workAroundSort{$2} = $1;
									push @idKEGG, $1;
								}
							}

							foreach my $key ( sort keys %workAroundSort ) {
								my $value = $workAroundSort{$key};
								$scriptSQL .= <<SQL;
									INSERT INTO TEXTS(tag, value, details) VALUES ("search-database-analyses-protein-code-by-kegg-pathway-options", "$key", "$value");
SQL
							}
							close($KOFILE);
							$components{$component} = "$component/$html_file";
							$scriptSQL .=
								"\nINSERT INTO COMPONENTS(name, locus_tag,  component, filepath) VALUES('$component_name', '$locus_tag', '$component', '$component/$html_file');\n";
							$scriptSQL .= <<SQL;
				INSERT INTO TEXTS(tag, value, details) VALUES
					("search-database-analyses-protein-code-tab", "Pathways", "#pathways");
SQL
						}
						elsif ( $component_name eq "annotation_phobius" ) {
							$components{$component} = "$component/$png_file";
							$scriptSQL .=
								"\nINSERT INTO COMPONENTS(name, locus_tag, component, filepath) VALUES('$component_name', '$locus_tag', '$component', '$component/$png_file');\n";
							$scriptSQL .= <<SQL;
				INSERT INTO TEXTS(tag, value, details) VALUES
					("search-database-analyses-protein-code-tab", "Phobius", "#phobius");
SQL
						}
						elsif ( $component_name eq "annotation_rpsblast" ) {
							$components{$component} = "$component/$txt_file";
							$scriptSQL .=
								"\nINSERT INTO COMPONENTS(name, locus_tag, component, filepath) VALUES('$component_name', '$locus_tag', '$component', '$component/$txt_file');\n";
							$scriptSQL .= <<SQL;
				INSERT INTO TEXTS(tag, value, details) VALUES
					("search-database-analyses-protein-code-tab", "RPSBlast", "#rpsblast");
SQL
						}
					}
					push @filepathsComponents, $components{$component};
				}
				
				###
	   #
	   #	TODO: confirmar com a professora os erros existentes para depois tentar
	   #
				####

			   #				unless ($filepath) {
			   #			foreach my $log ( @{ $sequence_object->get_logs() } ) {
			   #				if ( $log->{program} eq $component ) {
			   #					my $directory = "";
			   #					my $file      = "";
			   #					if ( $log->{arguments} =~ /^\w*output_dir=(\w+)"*/gm ) {
			   #						$directory = $1;
			   #					}
			   #					if ( $log->{arguments} =~ /^\w*output_file=(\w+.+)"*/gm ) {
			   #						$file = $1;
			   #					}
			   #					if ( $directory || $file ) {
			   #						unless ($directory) {
			   #							my $dirName = $file;
			   #							$dirName =~ s/.txt//g;
			   #							$directory = $dirName . "_dir";
			   #						}
			   #						elsif ( !$file ) {
			   #							my $fileName = $directory;
			   #							$fileName =~ s/_dir//g;
			   #							$file = $fileName . ".txt";
			   #						}
			   #						if ( $directory && $file ) {
			   #							$filepath = "$directory/$file";
			   #							print $LOG "\n".$filepath."\n";
			   #						}
			   #					}
			   #				}
			   #			}
			   #				}

		   #				print STDERR "\nNumber:\t$number\nStart:\t$start\nEnd:\t$end\n";
		   #				print $LOG "\nNumber:\t$number\nStart:\t$start\nEnd:\t$end\n";

				my $len_nt = ( $end - $start ) + 1;
				my $sequence_nt;
				my $nt_seq = substr( $bases, $start - 1, $len_nt );
				$len_nt = length($nt_seq);
				my $file_ev = $locus_tag . ".fasta";
				open( AA, ">$html_dir/root/$aa_fasta_dir/$file_ev" );
				print FILE_NT ">$locus_tag\n";
				print AA "\nNucleotide sequence:\n\n";
				print AA ">$locus_tag\n";

				my @intervals = @{ $evidence->{intervals} };
				print $LOG "\nIntervals:	" . @intervals . "\n";
				my $strand = $intervals[0]->{strand};
				print $LOG "\nstrand:	" . $strand . "\n";
				if ( ( $strand eq '-' ) or ( ( $strand eq '-1' ) ) ) {

					#					print $LOG "Sequencia antes:\t".$nt_seq."\n";
					$nt_seq = formatSequence( reverseComplement($nt_seq) );

			#					print $LOG "\nNumber:\t$number\nStart:\t$start\nEnd:\t$end\n";
			#					print $LOG "\nSequencia depois:\t".$nt_seq."\n";
				}

				for ( my $i = 0 ; $i < $len_nt ; $i += 60 ) {
					$sequence_nt = substr( $nt_seq, $i, 60 );
					print FILE_NT "$sequence_nt\n";
					print AA "$sequence_nt\n";
				}
				my $seq_aa = $evidence->{protein_sequence};
				my $sequence_aa;
				my $len_aa = length($seq_aa);
				print FILE_AA ">$locus_tag\n";
				print AA "\nTranslated sequence:\n\n";
				print AA ">$locus_tag\n";
				for ( my $i = 0 ; $i < $len_aa ; $i += 60 ) {
					$sequence_aa = substr( $seq_aa, $i, 60 );
					print FILE_AA "$sequence_aa\n";
					print AA "$sequence_aa\n";
				}
			}

		}

		#		foreach my $subevidence (@subevidences) {
		#			push @evidences, $subevidence;
		#		}
	}

	foreach my $key ( keys %components ) {
		print $LOG "\nKey:\t$key\nValue:\t" . $components{$key} . "\n"
		  if defined $components{$key};
		push @filepathsComponents, $components{$key};
	}

	close(AA);
	close(FILE_AA);
	close(FILE_NT);

	#$html_dir/root/$aa_fasta_dir/$file_aa
`makeblastdb -dbtype prot -in $html_dir/root/$aa_fasta_dir/$file_aa -parse_seqids -title '$name' -out $html_dir/root/$aa_fasta_dir/$name -logfile $html_dir/root/$aa_fasta_dir/makeblastdb.log`;

	#$html_dir/root/$nt_fasta_dir/$file_nt
`makeblastdb -dbtype nucl -in $html_dir/root/$nt_fasta_dir/$file_nt -parse_seqids -title '$name' -out $html_dir/root/$nt_fasta_dir/$name -logfile $html_dir/root/$nt_fasta_dir/makeblastdb.log`;
`makeblastdb -dbtype nucl -in $html_dir/root/$fasta_dir/$name.fasta -parse_seqids -title '$name' -out $html_dir/root/$fasta_dir/$name -logfile $html_dir/root/$fasta_dir/makeblastdb.log`;
	`mkdir -p $services_dir/root/`;
	`mkdir -p $html_dir/root/$nt_fasta_dir/`;
	`cp -r $html_dir/root/$aa_fasta_dir/ $services_dir/root/`;
	`cp -r $html_dir/root/$nt_fasta_dir/ $services_dir/root/`;
	`cp -r $html_dir/root/$fasta_dir/ $services_dir/root/`;

#	if ( @{ $sequence_object->get_logs() } ) {
#		foreach my $log ( @{ $sequence_object->get_logs() } ) {
#			my $component = $log->{program};
#			my $seq_id = $sequence_object->{sequence_id};
#			print $LOG "Component ($seq_id - $log->{analysis_id}): " . $log->{program} . "\n";
#			if ( $component =~ /<program name=\"([\w\-\_]*\.pl)\"/gim ) {
#				push @components_name, $1;
#			}
#			else {
#				push @components_name, $component;
#			}
#
#			#    		foreach my $key(sort keys %$log)
#			#    		{
#			#    			$scriptSQL .= "\n--logs\t$key\t".$log->{$key}."\n";
#			#    		}
#		}
#	}

	#	if (scalar @report_go_dir > 0 ) {
	#		push @components_name, "report_go.pl";
	#	}
	#	if(scalar @report_eggnog_dir > 0) {
	#		push @components_name, "report_orthology.pl";
	#	}
	#	if(scalar @report_pathways_dir > 0) {
	#		push @components_name, "report_pathways.pl";
	#	}
	#	if (scalar @report_kegg_organism_dir > 0) {
	#		push @components_name, "report_kegg_organism.pl";
	#	}

 #    foreach my $key(sort keys %$sequence_object)
 #    {
 #    	$scriptSQL .= "\n--sequenceObject\t$key\t".$sequence_object->{$key}."\n";
 #    }

	$header =~ s/>//g;
	$header =~ m/(\S+)_(\d+)/;
	$prefix_name = $1;

	#	my $count;
	#	my $line_subev;
	###
	##preparar pra pegar outros valores alem dos reports
	###
	#	foreach my $component ( sort @components_name ) {
	#
	#	}

}

#my $help;
my $filepath = `pwd`;
chomp $filepath;
my $databaseFilepath =
  $filepath . "/" . $standard_dir . "/" . $html_dir . "/database.db";
`mkdir -p "$filepath"/"$standard_dir"/"$html_dir"`;

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
	print $LOG
"\nCatalyst not found, please install dependences:\ncpan DBIx::Class Catalyst::Devel Catalyst::Runtime Catalyst::View::TT Catalyst::View::JSON Catalyst::Model::DBIC::Schema DBIx::Class::Schema::Loader MooseX::NonMoose\n";
	exit;
}
chomp $pathCatalyst;

#give permission to execute catalyst.pl
#chmod( "755", $pathCatalyst );
`chmod 755 $pathCatalyst`;

print $LOG "\nCreating website...\n";
`$pathCatalyst $html_dir`;
print $LOG "\nCreating services...\n";
`$pathCatalyst $services_dir`;

my $lowCaseName = $html_dir;
$lowCaseName = lc $lowCaseName;

#give permission to execute files script
#chmod("111", "$nameProject/script/".$lowCaseName."_server.pl");
#chmod("111", "$nameProject/script/".$lowCaseName."_create.pl");
#create view
print $LOG "\nCreating view\n";
`./$html_dir/script/"$lowCaseName"_create.pl view TT TT`;
my $fileHandler;
open( $fileHandler, "<", "$html_dir/lib/$html_dir/View/TT.pm" );
my $contentToBeChanged =
"__PACKAGE__->config(\n\tTEMPLATE_EXTENSION\t=>\t'.tt',\n\tTIMER\t=>\t0,\n\tWRAPPER\t=>\t'$lowCaseName/_layout.tt',\n\tENCODING\t=>\t'utf-8',\n\trender_die\t=> 1,\n);";
my $data = do { local $/; <$fileHandler> };
$data =~ s/__\w+->config\(([\w\s=>''"".,\/]*)\s\);/$contentToBeChanged/igm;
close($fileHandler);
print $LOG "\nEditing view\n";
writeFile( "$html_dir/lib/$html_dir/View/TT.pm", $data );

#if database file exists, delete
if ( -e $databaseFilepath ) {
	unlink $databaseFilepath;
}

#add resources to the config file
open( $fileHandler, ">>", "$html_dir/website.conf" );
print $fileHandler "\npipeline_id "
  . $pipeline
  . "\ntarget_class_id "
  . $type_target_class_id
  . "\nuniquename "
  . $uniquename . "\n";
close($fileHandler);

#create the file sql to be used
print $LOG "\nCreating SQL file\tscript.sql\n";
writeFile( "script.sql", $scriptSQL );

#create file database
print $LOG "\nCreating database file\t$databaseFilepath\n";
`sqlite3 $databaseFilepath < script.sql`;

#create models project
print $LOG "\nCreating models\n";
`$html_dir/script/"$lowCaseName"_create.pl model Basic DBIC::Schema "$html_dir"::Basic create=static "dbi:SQLite:$databaseFilepath" on_connect_do="PRAGMA foreign_keys = ON;PRAGMA encoding='UTF-8'"`;

my %models = (
	"BaseResponse" => <<BASERESPONSE,
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Report_HTML_DB::Models::Services::BaseResponse',
    constructor => 'new',
);

1;
BASERESPONSE
	"PagedResponse" => <<PAGEDRESPONSE,
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Report_HTML_DB::Models::Services::PagedResponse',
    constructor => 'new',
);

1;	
PAGEDRESPONSE
	"Feature" => <<FEATURE,
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Report_HTML_DB::Models::Application::Feature',
    constructor => 'new',
);

1;
FEATURE

	"Subevidence" => <<SUBEVIDENCE,
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Report_HTML_DB::Models::Application::Subevidence',
    constructor => 'new',
);

1;
SUBEVIDENCE
	"TRFSearch" => <<TRFSEARCH,
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Report_HTML_DB::Models::Application::TRFSearch',
    constructor => 'new',
);

1;
TRFSEARCH
	"TRNASearch" => <<TRNASEARCH,
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Report_HTML_DB::Models::Application::TRNASearch',
    constructor => 'new',
);

1;

TRNASEARCH
	"SearchDBClient" => <<CLIENTS,
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config(
	class		=> 'Report_HTML_DB::Clients::SearchDBClient',
	constructor	=> 'new',
);

1;

CLIENTS

	"BlastClient" => <<CLIENTS,
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config(
	class		=> 'Report_HTML_DB::Clients::BlastClient',
	constructor	=> 'new',
);

1;

CLIENTS
);

foreach my $key ( keys %models ) {
	my $package_website = "package " . $html_dir . "::Model::" . $key . ";";
	my $package_services =
	  "package " . $services_dir . "::Model::" . $key . ";";
	my $content_website = $package_website . "\n" . $models{$key};
	writeFile( "$html_dir/lib/$html_dir/Model/" . $key . ".pm",
		$content_website );
	writeFile( "$services_dir/lib/$services_dir/Model/" . $key . ".pm",
		$package_services . "\n" . $models{$key} );

}

#`$nameProject/script/"$lowCaseName"_create.pl model Chado DBIC::Schema "$nameProject"::Chado create=static "dbi:Pg:dbname=$dbName;host=$dbHost" "$dbUser" "$dbPassword"`;

my $hadGlobal         = 0;
my $hadSearchDatabase = 0;
foreach my $component ( sort keys %components ) {
	if (   scalar @report_go_dir > 0
		|| scalar @report_eggnog_dir > 0
		|| scalar @report_pathways_dir > 0
		|| scalar @report_kegg_organism_dir > 0 )
	{
		$hadGlobal = 1;
	}
	if ( $component =~ /^annotation_/gi ) {
		$hadSearchDatabase = 1;
	}
}

#####
#
#	Add relationship to models
#
#####
my $packageDBI = $services_dir . "::Model::SearchDatabaseRepository";
my $DBI        = <<DBI;
package $packageDBI;

use strict;
use warnings;
use parent 'Catalyst::Model::DBI';

__PACKAGE__->config(
	dsn      => "dbi:Pg:dbname=$dbName;host=$dbHost",
	user     => "$dbUser",
	password => "$dbPassword",
	options  => {},
);

=head2

Method used to realize search based on parameters received by form of analyses of protein-coding genes

=cut

sub analyses_CDS {
	my ( \$self, \$hash ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$query = "SELECT motherfuckerquery.feature_id, COUNT(*) OVER() FROM "
	  . "((select distinct f.feature_id "
	  . "from feature f "
	  . "join feature_relationship r on (f.feature_id = r.object_id) "
	  . "join cvterm cr on (r.type_id = cr.cvterm_id) "
	  . "join featureprop ps on (r.subject_id = ps.feature_id) "
	  . "join cvterm cs on (ps.type_id = cs.cvterm_id) "
	  . "join featureprop pf on (f.feature_id = pf.feature_id) "
	  . "join cvterm cf on (pf.type_id = cf.cvterm_id) "
	  . "join featureloc l on (l.feature_id = f.feature_id) "
	  . "join featureprop pl on (l.srcfeature_id = pl.feature_id) "
	  . "join cvterm cp on (pl.type_id = cp.cvterm_id) "
	  . "join featureprop pd on (r.subject_id = pd.feature_id) "
	  . "join cvterm cd on (pd.type_id = cd.cvterm_id) "
	  . "where cr.name = 'based_on' and cf.name = 'tag' and pf.value='CDS' and cs.name = 'locus_tag' and cd.name = 'description' and cp.name = 'pipeline_id' and pl.value=?)";
	push \@args, \$hash->{pipeline};
	my \$connector = "1";

	my \$query_gene     = "";
	my \$query_GO       = "";
	my \$query_TCDB     = "";
	my \$query_Phobius  = "";
	my \$query_sigP     = "";
	my \$query_blast    = "";
	my \$query_RPS      = "";
	my \$query_KEGG     = "";
	my \$query_ORTH     = "";
	my \$query_interpro = "";

	if (   ( exists \$hash->{geneDesc} && \$hash->{geneDesc} )
		|| ( exists \$hash->{noDesc} && \$hash->{noDesc} ) )
	{
		my \$and = "";
		\$query_gene =
		    "(SELECT DISTINCT f.feature_id "
		  . "FROM feature f JOIN feature_relationship r ON (f.feature_id = r.object_id) "
		  . "JOIN cvterm cr ON (r.type_id = cr.cvterm_id) "
		  . "JOIN featureloc l ON (l.feature_id = f.feature_id) "
		  . "JOIN featureprop pl ON (l.srcfeature_id = pl.feature_id) "
		  . "JOIN cvterm cp ON (pl.type_id = cp.cvterm_id) "
		  . "JOIN featureprop pd ON (r.subject_id = pd.feature_id) "
		  . "JOIN cvterm cd ON (pd.type_id = cd.cvterm_id) "
		  . "WHERE cr.name = 'based_on' AND cd.name = 'description' AND cp.name = 'pipeline_id' AND pl.value=? AND ";
		push \@args, \$hash->{pipeline};
		\$connector = " INTERSECT " if \$connector;

		if ( exists \$hash->{geneDesc} && \$hash->{geneDesc} ) {
			\$query_gene .= generate_clause( "?", "", "", "lower(pd.value)" );
			push \@args, lc("\%".\$hash->{geneDesc} . "\%");
			\$and = " AND ";
		}
		if ( exists \$hash->{noDesc} && \$hash->{noDesc} ) {
			\$query_gene .=
			  generate_clause( "?", "NOT", \$and, "lower(pd.value)" );
			push \@args, "\%" . lc( \$hash->{noDesc} ) . "\%";
		}
		\$query_gene .= ")";
		\$query_gene = \$connector . \$query_gene;
		\$connector  = "1";
	}
	if (   ( exists \$hash->{noGO} && \$hash->{noGO} )
		|| ( exists \$hash->{goID}   && \$hash->{noGO} )
		|| ( exists \$hash->{goDesc} && \$hash->{noGO} ) )
	{
		\$query_GO =
		    "(SELECT DISTINCT r.object_id "
		  . "FROM feature_relationship r "
		  . "JOIN featureloc l ON (r.object_id = l.feature_id) "
		  . "JOIN featureprop p ON (p.feature_id = l.srcfeature_id) "
		  . "JOIN cvterm c ON (p.type_id = c.cvterm_id) "
		  . "JOIN feature_relationship pr ON (r.subject_id = pr.object_id) "
		  . "JOIN featureprop pd ON (pr.subject_id = pd.feature_id) "
		  . "JOIN cvterm cpd ON (pd.type_id = cpd.cvterm_id) "
		  . "WHERE c.name ='pipeline_id' AND p.value = ? ";

		push \@args, \$hash->{pipeline};

		\$connector = " INTERSECT " if \$connector;

		if ( exists \$hash->{noGO} && \$hash->{noGO} ) {
			\$connector = " EXCEPT " if \$connector;
			\$query_GO .= "AND cpd.name LIKE 'evidence_\%' ";
		}
		elsif ( exists \$hash->{goID} && \$hash->{goID} ) {
			\$query_GO .=
			  "AND cpd.name LIKE 'evidence_\%' AND lower(pd.value) LIKE ?)";
			push \@args, "\%" . lc( \$hash->{'goID'} ) . "\%";
		}
		elsif ( exists \$hash->{goDesc} && \$hash->{goDesc} ) {
			\$query_GO .=
			  "and cpd.name like 'evidence_\%' and "
			  . generate_clause( "?", "", "", "lower(pd.value)" ) . " )";
			push \@args, "\%" . lc( \$hash->{'goDesc'} ) . "\%";
		}
		\$query_GO  = \$connector . \$query_GO . ")";
		\$connector = "1";
	}
	if (   ( exists \$hash->{'noTC'} && \$hash->{'noTC'} )
		|| ( exists \$hash->{'tcdbID'}       && \$hash->{'tcdbID'} )
		|| ( exists \$hash->{'tcdbFam'}      && \$hash->{'tcdbFam'} )
		|| ( exists \$hash->{'tcdbSubclass'} && \$hash->{'tcdbSubclass'} )
		|| ( exists \$hash->{'tcdbClass'}    && \$hash->{'tcdbClass'} )
		|| ( exists \$hash->{'tcdbDesc'}     && \$hash->{'tcdbDesc'} ) )
	{
		\$query_TCDB =
		    "(SELECT DISTINCT r.object_id "
		  . "FROM feature_relationship r "
		  . "JOIN featureloc l ON (r.object_id = l.feature_id) "
		  . "JOIN featureprop p ON (p.feature_id = l.srcfeature_id) "
		  . "JOIN cvterm c ON (p.type_id = c.cvterm_id) "
		  . "JOIN feature_relationship pr ON (r.subject_id = pr.object_id) "
		  . "JOIN featureprop ppr ON (pr.subject_id = ppr.feature_id) "
		  . "JOIN featureprop pd ON (pr.subject_id = pd.feature_id) "
		  . "JOIN cvterm cpd ON (pd.type_id = cpd.cvterm_id) "
		  . "WHERE c.name ='pipeline_id' AND p.value = ? ";
		push \@args, \$hash->{pipeline};

		\$connector = " INTERSECT " if \$connector;

		if ( \$hash->{'noTC'} ) {
			\$connector = " EXCEPT " if \$connector;
			\$query_TCDB .= " AND cpd.name = 'TCDB_ID'";
		}
		elsif ( \$hash->{'tcdbID'} ) {
			\$query_TCDB .= "AND cpd.name = 'TCDB_ID' AND pd.value = ?";
			push \@args, \$hash->{'tcdbID'};
		}
		elsif ( \$hash->{'tcdbFam'} ) {
			\$query_TCDB .=
			  "AND cpd.name = 'TCDB_family' AND lower(pd.value) LIKE ?";
			push \@args, "\%" . lc( \$hash->{'tcdbFam'} ) . "\%";
		}
		elsif ( \$hash->{'tcdbSubclass'} ) {
			\$query_TCDB .=
			  "AND cpd.name = 'TCDB_subclass' AND lower(pd.value) = ?";
			push \@args, lc( \$hash->{'tcdbSubclass'} );
		}
		elsif ( \$hash->{'tcdbClass'} ) {
			\$query_TCDB .=
			  "AND cpd.name = 'TCDB_class' AND lower(pd.value) = ?";
			push \@args, lc( \$hash->{'tcdbClass'} );
		}
		elsif ( \$hash->{'tcdbDesc'} ) {
			\$query_TCDB .=
			  "and cpd.name = 'hit_description' and "
			  . generate_clause( "?", "", "", "lower(pd.value)" );
			push \@args, lc( \$hash->{'tcdbDesc'} );
		}
		\$query_TCDB = \$connector . \$query_TCDB . ")";
		\$connector  = "1";
	}
	if (   ( exists \$hash->{'noPhobius'} && \$hash->{'noPhobius'} )
		|| ( exists \$hash->{'TMdom'} && \$hash->{'TMdom'} )
		|| ( exists \$hash->{'sigP'}  && \$hash->{'sigP'} ) )
	{
		my \$select = "(SELECT DISTINCT r.object_id ";
		my \$join =
		    "FROM feature f "
		  . "JOIN feature_relationship r ON (r.subject_id = f.feature_id) "
		  . "JOIN feature fo ON (r.object_id = fo.feature_id) "
		  . "JOIN featureloc l ON (r.object_id = l.feature_id) "
		  . "JOIN featureprop p ON (p.feature_id = l.srcfeature_id) "
		  . "JOIN analysisfeature af ON (f.feature_id = af.feature_id) "
		  . "JOIN analysis a ON (a.analysis_id = af.analysis_id) "
		  . "JOIN cvterm c ON (p.type_id = c.cvterm_id) ";
		my \$conditional =
"WHERE a.program = 'annotation_phobius.pl' AND c.name ='pipeline_id' AND p.value=? ";
		push \@args, \$hash->{pipeline};

		\$connector = " INTERSECT " if \$connector;
		if ( \$hash->{noPhobius} ) {
			\$connector = " EXCEPT " if \$connector;
			\$query_Phobius = \$connector . \$select . \$join . \$conditional . ")";
		}
		elsif ( \$hash->{'TMdom'} ) {
			\$join .=
			    "JOIN feature_relationship pr ON (r.subject_id = pr.object_id) "
			  . "JOIN featureprop ppr ON (pr.subject_id = ppr.feature_id) "
			  . "JOIN cvterm cpr ON (ppr.type_id = cpr.cvterm_id) "
			  . "JOIN featureprop pp ON (pr.subject_id = pp.feature_id) "
			  . "JOIN cvterm cpp ON (pp.type_id = cpp.cvterm_id) ";
			\$conditional .=
" AND cpr.name = 'classification' AND ppr.value= 'TRANSMEM' AND cpp.name = 'predicted_TMHs' AND my_to_decimal(pp.value) ";

			if ( \$hash->{'tmQuant'} eq "exact" ) {
				\$conditional .= "= ? ";
			}
			elsif ( \$hash->{'tmQuant'} eq "orLess" ) {
				\$conditional .= "<= ? ";
			}
			elsif ( \$hash->{'tmQuant'} eq "orMore" ) {
				\$conditional .= ">= ? ";
			}
			push \@args, \$hash->{'TMdom'};
			\$query_Phobius = \$connector . \$select . \$join . \$conditional . ")";
			\$connector     = "1";
		}
		else {
			\$query_Phobius = "";
		}
		if ( \$hash->{'sigP'} ne "sigPwhatever" ) {
			if ( \$hash->{'sigP'} ne "sigPwhatever"
				&& !\$hash->{'noPhobius'} )
			{
				my \$sigPconn = "";
				if ( \$hash->{'sigP'} eq "sigPyes" ) {
					\$sigPconn = " INTERSECT " if \$connector;
				}
				elsif ( \$hash->{'sigP'} eq "sigPno" ) {
					\$sigPconn = " EXCEPT " if \$connector;
				}

				\$query_sigP .=
				  " \$sigPconn (SELECT DISTINCT r.object_id FROM feature f
                        JOIN feature_relationship r ON (r.subject_id = f.feature_id)
                        JOIN feature fo ON (r.object_id = fo.feature_id)
                        JOIN featureloc l ON (r.object_id = l.feature_id)
                        JOIN featureprop p ON (p.feature_id = l.srcfeature_id)
                        JOIN analysisfeature af ON (f.feature_id = af.feature_id)
                        JOIN analysis a ON (a.analysis_id = af.analysis_id)
                        JOIN cvterm c ON (p.type_id = c.cvterm_id)
                        JOIN feature_relationship pr ON (r.subject_id = pr.object_id)
                        JOIN featureprop ppr ON (pr.subject_id = ppr.feature_id)
                        JOIN cvterm cpr ON (ppr.type_id = cpr.cvterm_id)
                        JOIN featureprop pp ON (pr.subject_id = pp.feature_id)
                        JOIN cvterm cpp ON (pp.type_id = cpp.cvterm_id)
                        where a.program = 'annotation_phobius.pl' AND c.name = 'pipeline_id' AND p.value = ? AND cpr.name = 'classification' AND ppr.value = 'SIGNAL')";
				push \@args, \$hash->{pipeline};
			}
			\$connector = "1";
		}
	}
	if (   ( exists \$hash->{'noBlast'} && \$hash->{'noBlast'} )
		|| ( exists \$hash->{'blastID'}   && \$hash->{'blastID'} )
		|| ( exists \$hash->{'blastDesc'} && \$hash->{'blastDesc'} ) )
	{
		\$query_blast = "(SELECT DISTINCT r.object_id " . " FROM feature f
                JOIN feature_relationship r ON (r.subject_id = f.feature_id)
                JOIN feature fo ON (r.object_id = fo.feature_id)
                JOIN analysisfeature af ON (f.feature_id = af.feature_id)
                JOIN analysis a ON (a.analysis_id = af.analysis_id)
                JOIN featureloc l ON (r.object_id = l.feature_id)
                JOIN featureprop p ON (p.feature_id = srcfeature_id)
                JOIN cvterm c ON (p.type_id = c.cvterm_id)
                JOIN feature_relationship ra ON (ra.object_id = f.feature_id)
                JOIN cvterm cra ON (ra.type_id = cra.cvterm_id)
                JOIN featureprop pfo ON (ra.subject_id = pfo.feature_id)
                JOIN cvterm cpfo ON (cpfo.cvterm_id = pfo.type_id)
                JOIN featureprop pr ON (r.object_id = pr.feature_id)
                JOIN cvterm cpr ON (pr.type_id = cpr.cvterm_id) ";
		my \$conditional =
"WHERE a.program = 'annotation_blast.pl' AND c.name ='pipeline_id' AND p.value = ? AND cra.name = 'alignment' AND cpfo.name = 'subject_id'";
		push \@args, \$hash->{pipeline};
		\$connector = " INTERSECT " if \$connector;
		if ( \$hash->{'noBlast'} ) {
			\$connector = " EXCEPT " if \$connector;
		}
		elsif ( \$hash->{'blastID'} ) {
			\$conditional .= " AND lower(pfo.value) LIKE ?";
			push \@args, "\%" . lc( \$hash->{'blastID'} ) . "\%";
		}
		elsif ( \$hash->{'blastDesc'} ) {
			\$conditional .=
			  " AND " . generate_clause( "?", "", "", "lower(pfo.value)" );
			push \@args, \$hash->{'blastDesc'};
		}
		\$query_blast = \$connector . \$query_blast . \$conditional . ")";
		\$connector   = "1";
	}
	if (   ( exists \$hash->{'noRps'} && \$hash->{'noRps'} )
		|| ( exists \$hash->{'rpsID'}   && \$hash->{'rpsID'} )
		|| ( exists \$hash->{'rpsDesc'} && \$hash->{'rpsDesc'} ) )
	{
		\$query_RPS =
		    "(select distinct r.object_id "
		  . " from feature f "
		  . "join feature_relationship r on (r.subject_id = f.feature_id) "
		  . "join feature fo on (r.object_id = fo.feature_id) "
		  . "join analysisfeature af on (f.feature_id = af.feature_id) "
		  . "join analysis a on (a.analysis_id = af.analysis_id) "
		  . "join featureloc l on (r.object_id = l.feature_id) "
		  . "join featureprop p on (p.feature_id = srcfeature_id) "
		  . "join cvterm c on (p.type_id = c.cvterm_id) "
		  . "join feature_relationship ra on (ra.object_id = f.feature_id) "
		  . "join cvterm cra on (ra.type_id = cra.cvterm_id) "
		  . "join featureprop pfo on (ra.subject_id = pfo.feature_id) "
		  . "join cvterm cpfo on (cpfo.cvterm_id = pfo.type_id) "
		  . "join featureprop pr on (r.object_id = pr.feature_id) "
		  . "join cvterm cpr on (pr.type_id = cpr.cvterm_id) ";
		my \$conditional =
"where a.program = 'annotation_rpsblast.pl' and c.name ='pipeline_id' and p.value = ? and cra.name = 'alignment' and cpfo.name = 'subject_id' ";
		push \@args, \$hash->{pipeline};
		\$connector = " INTERSECT " if \$connector;

		if ( \$hash->{'noRps'} ) {
			\$connector = " EXCEPT " if \$connector;
		}
		elsif ( \$hash->{'rpsID'} ) {
			\$conditional .= " and lower(pfo.value) like ? ";
			push \@args, "\%" . lc( \$hash->{'rpsID'} ) . "\%";
		}
		elsif ( \$hash->{'rpsDesc'} ) {
			\$conditional .=
			  " and " . generate_clause( "?", "", "", "lower(pfo.value)" );
			push \@args, "\%" . lc( \$hash->{'rpsDesc'} ) . "\%";
		}
		\$query_RPS = \$connector . \$query_RPS . \$conditional . ")";
		\$connector = 1;
	}
	if (   \$hash->{'noKEGG'}
		|| \$hash->{'koID'}
		|| \$hash->{'keggPath'}
		|| \$hash->{'keggDesc'} )
	{
		\$query_KEGG =
		    "(select distinct r.object_id "
		  . "from feature_relationship r "
		  . "join featureloc l on (r.object_id = l.feature_id)"
		  . "join featureprop p on (p.feature_id = l.srcfeature_id)"
		  . "join cvterm c on (p.type_id = c.cvterm_id)"
		  . "join feature_relationship pr on (r.subject_id = pr.object_id)"
		  . "join featureprop ppr on (pr.subject_id = ppr.feature_id)"
		  . "join featureprop pd on (pr.subject_id = pd.feature_id)"
		  . "join cvterm cpd on (pd.type_id = cpd.cvterm_id) ";
		my \$conditional = " where c.name ='pipeline_id' and p.value = ? ";
		push \@args, \$hash->{pipeline};
		\$connector = " intersect " if \$connector;
		if ( \$hash->{'noKEGG'} ) {
			\$connector = " except " if \$connector;
			\$conditional .= " and cpd.name = 'orthologous_group_id'";
		}
		elsif ( \$hash->{'koID'} ) {
			\$conditional .=
" and cpd.name = 'orthologous_group_id' and lower(pd.value) LIKE ? ";
			push \@args, "\%" . lc( \$hash->{'koID'} ) . "\%";
		}
		elsif ( \$hash->{'keggPath'} ) {
			\$conditional .=
" and cpd.name = 'metabolic_pathway_id' and lower(pd.value) like ? ";
			push \@args, "\%" . lc( \$hash->{'keggPath'} ) . "\%";
		}
		elsif ( \$hash->{'keggDesc'} ) {
			\$query_KEGG .=
			    " join analysisfeature af on (r.subject_id = af.feature_id)"
			  . "join analysis a on (a.analysis_id = af.analysis_id) ";
			\$conditional .=
" and a.program = 'annotation_pathways.pl' and cpd.name = 'orthologous_group_description' and "
			  . generate_clause( "?", "", "", "pd.value" );
			push \@args, "\%" . lc( \$hash->{'keggDesc'} ) . "\%";
		}
		\$query_KEGG = \$connector . \$query_KEGG . \$conditional . ")";
		\$connector  = "1";
	}
	if (   ( exists \$hash->{'noOrth'} && \$hash->{'noOrth'} )
		|| ( exists \$hash->{'orthID'}   && \$hash->{'orthID'} )
		|| ( exists \$hash->{'orthDesc'} && \$hash->{'orthDesc'} ) )
	{
		\$query_ORTH =
		    "(select distinct r.object_id"
		  . " from feature_relationship r "
		  . "join featureloc l on (r.object_id = l.feature_id) "
		  . "join featureprop p on (p.feature_id = l.srcfeature_id) "
		  . "join cvterm c on (p.type_id = c.cvterm_id) "
		  . "join feature_relationship pr on (r.subject_id = pr.object_id) "
		  . "join featureprop ppr on (pr.subject_id = ppr.feature_id) "
		  . "join featureprop pd on (pr.subject_id = pd.feature_id) "
		  . "join cvterm cpd on (pd.type_id = cpd.cvterm_id) ";
		my \$conditional = "where c.name ='pipeline_id' and p.value = ? ";
		push \@args, \$hash->{pipeline};
		\$connector = " intersect " if \$connector;
		if ( \$hash->{'noOrth'} ) {
			\$connector = " except " if \$connector;
			\$conditional .= " and cpd.name = 'orthologous_group' ";
		}
		elsif ( \$hash->{'orthID'} ) {
			\$conditional =
			  "and cpd.name = 'orthologous_group' and lower(pd.value) like ? ";
			push \@args, "\%" . lc( \$hash->{'orthID'} ) . "\%";
		}
		elsif ( \$hash->{'orthDesc'} ) {
			\$query_ORTH .=
			    " join analysisfeature af on (r.subject_id = af.feature_id) "
			  . " join analysis a on (a.analysis_id = af.analysis_id) ";
			\$conditional .=
" and a.program = 'annotation_orthology.pl' and cpd.name = 'orthologous_group_description' and "
			  . generate_clause( "?", "", "", "lower(pd.value)" );
			push \@args, "\%" . \$hash->{'orthDesc'} . "\%";
		}
		\$query_ORTH = \$connector . \$query_ORTH . \$conditional . ")";
		\$connector  = "1";
	}
	if (   ( exists \$hash->{'noIP'} && \$hash->{'noIP'} )
		|| ( exists \$hash->{'interproID'}   && \$hash->{'interproID'} )
		|| ( exists \$hash->{'interproDesc'} && \$hash->{'interproDesc'} ) )
	{
		\$query_interpro =
		    "(select distinct r.object_id "
		  . " from feature f "
		  . "join feature_relationship r on (r.subject_id = f.feature_id) "
		  . "join featureloc l on (r.object_id = l.feature_id) "
		  . "join featureprop p on (p.feature_id = l.srcfeature_id) "
		  . "join cvterm c on (p.type_id = c.cvterm_id) "
		  . "join feature_relationship pr on (r.subject_id = pr.object_id) "
		  . "join featureprop ppr on (pr.subject_id = ppr.feature_id) "
		  . "join cvterm cpr on (ppr.type_id = cpr.cvterm_id) ";
		my \$conditional = "where c.name ='pipeline_id' and p.value = ? ";
		push \@args, \$hash->{pipeline};
		\$connector = " intersect " if \$connector;
		if ( \$hash->{'noIP'} ) {
			\$connector = " except " if \$connector;
			\$conditional .= "and cpr.name like 'interpro_id'";
		}
		elsif ( \$hash->{'interproID'} ) {
			\$conditional .=
			  "and cpr.name like 'interpro_id' and ppr.value LIKE ? ";
			push \@args, "\%" . \$hash->{'interproID'} . "\%";
		}
		elsif ( \$hash->{'interproDesc'} ) {
			\$conditional .=
			  "and cpr.name like 'description\%' and ppr.value like ? ";
			push \@args, "\%" . \$hash->{'interproDesc'} . "\%";
		}
		\$query_interpro = \$connector . \$query_interpro . \$conditional . ")";
		\$connector      = 1;
	}

	\$query =
	    \$query
	  . \$query_gene
	  . \$query_GO
	  . \$query_TCDB
	  . \$query_Phobius
	  . \$query_sigP
	  . \$query_blast
	  . \$query_RPS
	  . \$query_KEGG
	  . \$query_ORTH
	  . \$query_interpro
	  . " ) as motherfuckerquery GROUP BY motherfuckerquery.feature_id ORDER BY motherfuckerquery.feature_id ";
	  
	if (   exists \$hash->{pageSize}
		&& \$hash->{pageSize}
		&& exists \$hash->{offset}
		&& \$hash->{offset} )
	{
		\$query .= " LIMIT ? ";
		push \@args, \$hash->{pageSize};
		if ( \$hash->{offset} == 1 ) {
			\$query .= " OFFSET 0 ";
		}
		else {
			\$query .= " OFFSET ? ";
			push \@args, \$hash->{offset};
		}
	}

	my \$quantityParameters = () = \$query =~ /\\?/g;
	my \$counter = scalar \@args;
	if(\$counter > \$quantityParameters) {
		while(scalar \@args > \$quantityParameters) {
			delete \$args[\$counter-1];
			\$counter--;
		}
	}
	

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };
	my \%returnedHash = ();
	my \@list         = ();
	
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		push \@list, \$rows[\$i][0];
		\$returnedHash{total} = \$rows[\$i][1];
	}

	\$returnedHash{list} = \\\@list;

	return \\\%returnedHash;
}

=head2

Method used to generate clause for any query

=cut

sub generate_clause {
	my \$terms = shift;
	my \$not   = shift || "";
	my \$and   = shift || "";
	my \$field = shift;

	my \@terms  = split( /\\s+/, \$terms );
	my \$clause = " \$and (";
	my \$i      = 0;
	foreach my \$term (\@terms) {
		my \$com = "";
		\$com = " or " if \$i > 0;
		\$clause .= "\$com \$field \$not like \$term";
		\$i++;
	}
	\$clause .= ")";
	return \$clause;
}

=head2

Method used to return tRNA data from database

=cut

sub tRNA_search {
	my ( \$self, \$hash ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$query =
"select r.object_id AS id, fp.value AS sequence, pt.value AS amino_acid, pa.value AS codon, COUNT(*) OVER() AS total "
	  . "from feature_relationship r "
	  . "join cvterm c on (r.type_id = c.cvterm_id) "
	  . "join featureloc l on (r.subject_id = l.feature_id) "
	  . "join analysisfeature af on (af.feature_id = r.object_id) "
	  . "join analysis a on (a.analysis_id = af.analysis_id) "
	  . "join featureprop p on (p.feature_id = l.srcfeature_id) "
	  . "join cvterm cp on (p.type_id = cp.cvterm_id) "
	  . "join featureprop pt on (r.subject_id = pt.feature_id) "
	  . "join cvterm cpt on (pt.type_id = cpt.cvterm_id) "
	  . "join featureprop pa on (r.subject_id = pa.feature_id) "
	  . "join cvterm cpa on (pa.type_id = cpa.cvterm_id) "
	  . "join featureprop fp on (r.subject_id = fp.feature_id) "
	  . "join cvterm cfp on (fp.type_id = cfp.cvterm_id) "
	  . "where c.name='interval' and a.program = 'annotation_trna.pl' and cp.name='pipeline_id' and p.value=? and cpt.name='type' and cpa.name='anticodon' and cfp.name = 'sequence' ";
	push \@args, \$hash->{pipeline};
	my \$anticodon = "";

	if ( \$hash->{'tRNAaa'} ne "" ) {
		\$query .= "and pt.value = ?";
		push \@args, \$hash->{'tRNAaa'};
	}
	elsif ( \$hash->{'tRNAcd'} ne "" ) {
		\$anticodon = reverseComplement( \$hash->{'tRNAcd'} );
		\$query .= "and pa.value = ?";
		push \@args, \$anticodon;
	}

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };
	my \%returnedHash = ();
	my \@list         = ();
	use Report_HTML_DB::Models::Application::TRNASearch;
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		my \$result = Report_HTML_DB::Models::Application::TRNASearch->new(
			id         => \$rows[\$i][0],
			sequence   => \$rows[\$i][2],
			amino_acid => \$rows[\$i][1],
			codon      => \$rows[\$i][3],
		);
		\$returnedHash{total} = \$rows[\$i][4];
		push \@list, \$result;
	}
	\$returnedHash{"list"} = \\\@list;

	return \\\%returnedHash;
}

=head2

Method used to return tandem repeats data from database

=cut

sub trf_search {
	my ( \$self, \$hash ) = \@_;
	my \$dbh       = \$self->dbh;
	my \@args      = ();
	my \$connector = "";
	my \$select =
"select fl.uniquename AS contig, l.fstart AS start, l.fend AS end, pp.value AS length, pc.value AS copy_number, pur.value AS sequence ";
	my \$join = "from feature_relationship r
                 join featureloc l on (r.subject_id = l.feature_id)
                 join feature fl on (fl.feature_id = l.srcfeature_id)
                 join featureprop pp on (r.subject_id = pp.feature_id)
                 join cvterm cp on (pp.type_id = cp.cvterm_id)
                 join featureprop pc on (r.subject_id = pc.feature_id)
                 join cvterm cc on (pc.type_id = cc.cvterm_id)
                 join featureprop pur on (pur.feature_id = r.subject_id)
                 join cvterm cpur on (pur.type_id = cpur.cvterm_id)
                 join analysisfeature af on (r.object_id = af.feature_id)
                 join analysis a on (af.analysis_id = a.analysis_id)
                 join featureprop ps on (ps.feature_id = l.srcfeature_id)
                 join cvterm cps on (ps.type_id = cps.cvterm_id) ";
	my \$query =
"where a.program = 'annotation_trf.pl' and cp.name = 'period_size' and cc.name = 'copy_number' and cpur.name='sequence' and cps.name='pipeline_id' and ps.value=? ";
	push \@args, \$hash->{pipeline};

	if ( \$hash->{'TRFrepSeq'} !~ /^\\s*\$/ ) {
		\$hash->{'TRFrepSeq'} =~ s/\\s+//g;
		\$query .= "and lower(pur.value) ilike ? ";
		\$connector = ",";
		push \@args, lc("\%\$hash->{'TRFrepSeq'}\%");
	}

	if ( \$hash->{'TRFrepSize'} !~ /^\\s*\$/ ) {
		\$hash->{'TRFrepSize'} =~ s/\\s+//g;

		if ( \$hash->{'TRFsize'} eq "exact" ) {
			\$query .= "and pp.value = ? ";
			\$connector = ",";
		}
		elsif ( \$hash->{'TRFsize'} eq "orLess" ) {
			\$query .= "and my_to_decimal(pp.value) <= ? ";
			\$connector = ",";
		}
		elsif ( \$hash->{'TRFsize'} eq "orMore" ) {
			\$query .= "and my_to_decimal(pp.value) >= ? ";
			\$connector = ",";
		}
		push \@args, \$hash->{'TRFrepSize'};
	}

	if (   \$hash->{'TRFrepNumMin'} !~ /^\\s*\$/
		|| \$hash->{'TRFrepNumMax'} !~ /^\\s*\$/ )
	{
		my \$min = 0;
		my \$max = 0;

		\$hash->{'TRFrepNumMin'} =~ s/\\s+//g;
		if ( \$hash->{'TRFrepNumMin'} ) {
			\$min++;
		}

		\$hash->{'TRFrepNumMax'} =~ s/\\s+//g;
		if ( \$hash->{'TRFrepNumMax'} ) {
			\$max++;
		}

		if ( \$min && \$max ) {
			if ( \$hash->{'TRFrepNumMin'} == \$hash->{'TRFrepNumMax'} ) {
				\$query .= "and my_to_decimal(pc.value) = ? ";
				push \@args, \$hash->{'TRFrepNumMax'};
			}
			elsif ( \$hash->{'TRFrepNumMin'} < \$hash->{'TRFrepNumMax'} ) {
				\$query .=
"and my_to_decimal(pc.value) >= ? and my_to_decimal(pc.value) <= ? ";
				push \@args, \$hash->{'TRFrepNumMin'};
				push \@args, \$hash->{'TRFrepNumMax'};
			}
		}
		elsif (\$min) {
			\$query .= "and my_to_decimal(pc.value) >= ? ";
			push \@args, \$hash->{'TRFrepNumMin'};
		}
		elsif (\$max) {
			\$query .= "and my_to_decimal(pc.value) <= ? ";
			push \@args, \$hash->{'TRFrepNumMax'};
		}
	}

	\$query = \$select . \$join . \$query;

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };
	my \@list = ();

	use Report_HTML_DB::Models::Application::TRFSearch;
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		my \$result = Report_HTML_DB::Models::Application::TRFSearch->new(
			contig      => \$rows[\$i][0],
			start       => \$rows[\$i][2],
			end         => \$rows[\$i][1],
			'length'    => \$rows[\$i][3],
			copy_number => \$rows[\$i][4],
			sequence    => \$rows[\$i][5]
		);
		push \@list, \$result;
	}

	return \\\@list;
}

=head2

Method used to return non coding RNAs data from database

=cut

sub ncRNA_search {
	my ( \$self, \$hash ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$select =
"select distinct r.object_id AS id, fl.uniquename AS contig, l.fstart AS end, l.fend AS start, pp.value AS description";
	my \$join = " from feature_relationship r 
                join featureloc lc on (r.subject_id = lc.feature_id)
                join feature fl on (fl.feature_id = lc.srcfeature_id)
                join cvterm c on (r.type_id = c.cvterm_id)
                join featureloc l on (r.subject_id = l.feature_id)
                join analysisfeature af on (af.feature_id = r.object_id)
                join analysis a on (a.analysis_id = af.analysis_id)
                join featureprop p on (p.feature_id = l.srcfeature_id) 
                join cvterm cp on (p.type_id = cp.cvterm_id) 
                join featureprop pp on (pp.feature_id = r.subject_id) 
                join cvterm cpp on (pp.type_id = cpp.cvterm_id) ";
	my \$query =
"where c.name='interval' and a.program = 'annotation_infernal.pl' and cp.name='pipeline_id' and p.value=? and cpp.name='target_description' ";
	push \@args, \$hash->{pipeline};

	if ( \$hash->{'ncRNAtargetID'} !~ /^\\s*\$/ ) {
		\$hash->{'ncRNAtargetID'} =~ s/\\s+//g;
		\$select .= ", ppc.value AS Target_ID";
		\$join .=
"join featureprop ppc on (ppc.feature_id = r.subject_id) join cvterm cppc on (ppc.type_id = cppc.cvterm_id) ";
		\$query .=
		  "and cppc.name = 'target_identifier' and lower(ppc.value) LIKE ? ";
		push \@args, "\%" . lc( \$hash->{'ncRNAtargetID'} ) . "\%";
	}

	elsif ( \$hash->{'ncRNAevalue'} !~ /^\\s*\$/ ) {
		\$hash->{'ncRNAevalue'} =~ s/\\s+//g;
		\$select .= ", ppe.value AS evalue";
		\$join .=
"join featureprop ppe on (ppe.feature_id = r.subject_id) join cvterm cppe on (ppe.type_id = cppe.cvterm_id) ";
		if ( \$hash->{'ncRNAevM'} eq "exact" ) {
			\$query .=
			  "and cppe.name = 'evalue' and my_to_decimal(ppe.value) = ? ";
		}
		elsif ( \$hash->{'ncRNAevM'} eq "orLess" ) {
			\$query .=
			  "and cppe.name = 'evalue' and my_to_decimal(ppe.value) <= ? ";
		}
		elsif ( \$hash->{'ncRNAevM'} eq "orMore" ) {
			\$query .=
			  "and cppe.name = 'evalue' and my_to_decimal(ppe.value) >= ? ";
		}
		push \@args, \$hash->{'ncRNAevalue'};
	}
	elsif ( \$hash->{'ncRNAtargetName'} !~ /^\\s*\$/ ) {
		\$hash->{'ncRNAtargetName'} =~ s/^\\s+//;
		\$hash->{'ncRNAtargetName'} =~ s/\\s+\$//;
		\$select .= ", ppn.value AS Target_name";
		\$join .=
"join featureprop ppn on (ppn.feature_id = r.subject_id) join cvterm cppn on (ppn.type_id = cppn.cvterm_id) ";
		\$query .= "and cppn.name = 'target_name' and lower(ppn.value) ilike ? ";
		push \@args, lc( "\%" . \$hash->{'ncRNAtargetName'} . "\%" );
	}

	elsif ( \$hash->{'ncRNAtargetClass'} !~ /^\\s*\$/ ) {
		\$select .= ", ppc.value AS Target_class";
		\$join .=
"join featureprop ppc on (ppc.feature_id = r.subject_id) join cvterm cppc on (ppc.type_id = cppc.cvterm_id) ";
		\$query .= "and cppc.name = 'target_class' and ppc.value = ? ";
		push \@args, \$hash->{'ncRNAtargetClass'};
	}

	elsif ( \$hash->{'ncRNAtargetType'} !~ /^\\s*\$/ ) {
		\$hash->{'ncRNAtargetType'} =~ s/^\\s+//;
		\$hash->{'ncRNAtargetType'} =~ s/\\s+\$//;
		\$select .= ", ppt.value AS Target_type";
		\$join .=
"join featureprop ppt on (ppt.feature_id = r.subject_id) join cvterm cppt on (ppt.type_id = cppt.cvterm_id) ";
		\$query .= "and cppt.name = 'target_type' and lower(ppt.value) ilike ? ";
		push \@args, lc( "\%" . \$hash->{'ncRNAtargetType'} . "\%" );
	}
	elsif ( \$hash->{'ncRNAtargetDesc'} !~ /^\\s*\$/ ) {
		\$hash->{'ncRNAtargetDesc'} =~ s/^\\s+//;
		\$hash->{'ncRNAtargetDesc'} =~ s/\\s+\$//;
		\$query .= "and lower(pp.value) like ? ";
		push \@args, lc( "\%" . \$hash->{'ncRNAtargetDesc'} . "\%" );
	}

	\$query = \$select . \$join . \$query;

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };
	my \@list = ();

	use Report_HTML_DB::Models::Application::NcRNASearch;
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		my \$result = Report_HTML_DB::Models::Application::NcRNASearch->new(
			id           => \$rows[\$i][0],
			contig       => \$rows[\$i][1],
			start        => \$rows[\$i][3],
			end          => \$rows[\$i][2],
			description  => \$rows[\$i][4],
			target_ID    => \$rows[\$i][5] ? \$rows[\$i][5] !~ '' : '',
			evalue       => \$rows[\$i][5] ? \$rows[\$i][5] !~ '' : '',
			target_name  => \$rows[\$i][5] ? \$rows[\$i][5] !~ '' : '',
			target_class => \$rows[\$i][5] ? \$rows[\$i][5] !~ '' : '',
			target_type  => \$rows[\$i][5] ? \$rows[\$i][5] !~ '' : ''

		);
		push \@list, \$result;
	}

	return \\\@list;
}

=head2

Method used to return transcriptional terminator data from database

=cut

sub transcriptional_terminator_search {
	my ( \$self, \$hash ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$select =
"select fl.uniquename AS contig, l.fstart AS start, l.fend AS end, pp.value";
	if ( \$hash->{'TTconf'} !~ /^\\s*\$/ ) {
		\$select .= " AS confidence";
	}
	elsif ( \$hash->{'TThp'} !~ /^\\s*\$/ ) {
		\$select .= " AS hairpin_score";
	}
	elsif ( \$hash->{'TTtail'} !~ /^\\s*\$/ ) {
		\$select .= " AS tail_score";
	}
	my \$join = " from feature_relationship r
                 join featureloc lc on (r.subject_id = lc.feature_id)
                 join feature fl on (fl.feature_id = lc.srcfeature_id)
                 join cvterm c on (r.type_id = c.cvterm_id)
                 join featureloc l on (r.subject_id = l.feature_id)
                 join analysisfeature af on (af.feature_id = r.object_id)
                 join analysis a on (a.analysis_id = af.analysis_id)
                 join featureprop p on (p.feature_id = l.srcfeature_id)
                 join cvterm cp on (p.type_id = cp.cvterm_id)
                 join featureprop pp on (pp.feature_id = r.subject_id)
                 join cvterm cpp on (pp.type_id = cpp.cvterm_id) ";
	my \$query =
"where c.name='interval' and a.program = 'annotation_transterm.pl' and cp.name='pipeline_id' and p.value=? ";
	push \@args, \$hash->{pipeline};

	my \$search_field;
	my \$field;
	my \$modifier;

	if ( \$hash->{'TTconf'} !~ /^\\s*\$/ ) {
		\$search_field = \$hash->{'TTconf'} + 1;
		\$modifier     = \$hash->{'TTconfM'};
		\$field        = "confidence";
	}
	elsif ( \$hash->{'TThp'} !~ /^\\s*\$/ ) {
		\$search_field = \$hash->{'TThp'} + 1;
		\$modifier     = \$hash->{'TThpM'};
		\$field        = "hairpin";
	}
	elsif ( \$hash->{'TTtail'} !~ /^\\s*\$/ ) {
		\$search_field = \$hash->{'TTtail'} + 1;
		\$modifier     = \$hash->{'TTtailM'};
		\$field        = "tail";
	}

	\$search_field =~ s/\\s+//g;

	if ( \$modifier eq "exact" ) {
		\$query .= "and cpp.name = ? and my_to_decimal(pp.value) = ? ";
	}
	elsif ( \$modifier eq "orLess" ) {
		\$query .= "and cpp.name = ? and my_to_decimal(pp.value) <= ? ";
	}
	elsif ( \$modifier eq "orMore" ) {
		\$query .= "and cpp.name = ? and my_to_decimal(pp.value) >= ? ";
	}

	push \@args, \$field    if (\$field);
	push \@args, (\$search_field - 1) if (\$search_field);

	\$query = \$select . \$join . \$query;

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };

	my \@list    = ();
	my \@columns = \@{ \$sth->{NAME} };
	use Report_HTML_DB::Models::Application::TranscriptionalTerminator;
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		my \$result = Report_HTML_DB::Models::Application::TranscriptionalTerminator->new(
			contig => \$rows[\$i][0],
			start  => \$rows[\$i][1],
			end    => \$rows[\$i][2]
		);
		if ( \$columns[3] eq "confidence" ) {
			\$result->setConfidence( \$rows[\$i][3] );
		}
		elsif ( \$columns[3] eq "hairpin_score" ) {
			\$result->setHairpinScore( \$rows[\$i][3] );
		}
		elsif ( \$columns[3] eq "tail_score" ) {
			\$result->setTailScore( \$rows[\$i][3] );
		}
		push \@list, \$result;
	}

	return \\\@list;
}

=head2

Method used to return ribosomal binding sites data from database

=cut

#TODO: Criar modelo RBS
sub rbs_search {
	my ( \$self, \$hash ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$select =
"select fl.uniquename AS contig, l.fstart AS start, l.fend AS end, pp.value";

	if ( \$hash->{'RBSpattern'} !~ /^\\s*\$/ ) {
		\$select .= " AS site_pattern";
	}
	elsif ( \$hash->{'RBSnewcodon'} !~ /^\\s*\$/ ) {
		\$select .= " AS old_start";
	}
	else {
		\$select .= " AS position_shift";
	}
	my \$join = " from feature_relationship r
                join featureloc lc on (r.subject_id = lc.feature_id) 
                join feature fl on (fl.feature_id = lc.srcfeature_id) 
                join cvterm c on (r.type_id = c.cvterm_id)
                join featureloc l on (r.subject_id = l.feature_id)
                join analysisfeature af on (af.feature_id = r.object_id)
                join analysis a on (a.analysis_id = af.analysis_id)
                join featureprop p on (p.feature_id = l.srcfeature_id)
                join cvterm cp on (p.type_id = cp.cvterm_id)
                join featureprop pp on (pp.feature_id = r.subject_id)
                join cvterm cpp on (pp.type_id = cpp.cvterm_id)";
	my \$query =
"where c.name='interval' and a.program = 'annotation_rbsfinder.pl' and cp.name='pipeline_id' and p.value=? ";
	push \@args, \$hash->{pipeline};

	my \$newcodon = 0;

	if ( \$hash->{'RBSpattern'} !~ /^\\s*\$/ ) {
		\$hash->{'RBSpattern'} =~ s/\\s*//g;
		\$query .= "and cpp.name='RBS_pattern' and lower(pp.value) like ? ";
		push \@args, lc( "\%" . \$hash->{'RBSpattern'} . "\%" );
	}
	elsif ( \$hash->{'RBSshift'} ) {
		if ( \$hash->{'RBSshiftM'} eq "both" ) {
			\$query .= "and cpp.name='position_shift' and pp.value != '0'";
		}
		elsif ( \$hash->{'RBSshiftM'} eq "neg" ) {
			\$query .=
			  "and cpp.name='position_shift' and my_to_decimal(pp.value) < '0'";
		}
		elsif ( \$hash->{'RBSshiftM'} eq "pos" ) {
			\$query .=
			  "and cpp.name='position_shift' and my_to_decimal(pp.value) > '0'";
		}
	}
	elsif ( \$hash->{'RBSnewcodon'} ) {
		\$select .= ", pp2.value AS new_start";
		\$join .=
"join featureprop pp2 on (pp2.feature_id = r.subject_id) join cvterm cpp2 on (pp2.type_id = cpp2.cvterm_id)";
		\$query .=
"and cpp.name='old_start_codon' and cpp2.name='new_start_codon' and (pp.value != pp2.value)";
		\$newcodon++;
	}

	\$query = \$select . \$join . \$query;

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };
	my \@list = ();

	my \@columns = \@{ \$sth->{NAME} };
	use Report_HTML_DB::Models::Application::RBSSearch;
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		my \$result = Report_HTML_DB::Models::Application::RBSSearch->new(
			contig => \$rows[\$i][0],
			start  => \$rows[\$i][1],
			end    => \$rows[\$i][2]
		);
		if ( \$columns[3] eq "site_pattern" ) {
			\$result->setSitePattern( \$rows[\$i][3] );
		}
		elsif ( \$columns[3] eq "old_start" ) {
			\$result->setOldStart( \$rows[\$i][3] );
		}
		elsif ( \$columns[3] eq "position_shift" ) {
			\$result->setPositionShift( \$rows[\$i][3] );
		}

		if ( \$columns[4] eq "new_start" ) {
			\$result->setNewStart( \$rows[\$i][4] );
		}

		push \@list, \$result;
	}

	return \\\@list;
}

=head2

Method used to return horizontal transferences data from database

=cut

sub alienhunter_search {
	my ( \$self, \$hash ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$select =
"select r.object_id AS id, fl.uniquename AS contig, l.fstart AS start, l.fend AS end, pp.value ";

	if ( \$hash->{'AHlen'} !~ /^\\s*\$/ ) {
		\$select .= " AS length";
	}
	elsif ( \$hash->{'AHscore'} !~ /^\\s*\$/ ) {
		\$select .= " AS score";
	}
	elsif ( \$hash->{'AHthr'} !~ /^\\s*\$/ ) {
		\$select .= " AS threshold";
	}
	my \$join = " from feature_relationship r
                join featureloc lc on (r.subject_id = lc.feature_id) 
                join feature fl on (fl.feature_id = lc.srcfeature_id) 
                join cvterm c on (r.type_id = c.cvterm_id)
                join featureloc l on (r.subject_id = l.feature_id)
                join analysisfeature af on (af.feature_id = r.object_id)
                join analysis a on (a.analysis_id = af.analysis_id)
                join featureprop p on (p.feature_id = l.srcfeature_id)
                join cvterm cp on (p.type_id = cp.cvterm_id)
                join featureprop pp on (pp.feature_id = r.subject_id)
                join cvterm cpp on (pp.type_id = cpp.cvterm_id) ";
	my \$query =
"where c.name='interval' and a.program = 'annotation_alienhunter.pl' and cp.name='pipeline_id' and p.value=? ";
	push \@args, \$hash->{pipeline};

	my \$search_field;
	my \$field;
	my \$modifier;

	if ( \$hash->{'AHlen'} !~ /^\\s*\$/ ) {
		\$search_field = \$hash->{'AHlen'} + 1;
		\$modifier     = \$hash->{'AHlenM'};
		\$field        = "length";
	}
	elsif ( \$hash->{'AHscore'} !~ /^\\s*\$/ ) {
		\$search_field = \$hash->{'AHscore'} + 1;
		\$modifier     = \$hash->{'AHscM'};
		\$field        = "score";
	}
	elsif ( \$hash->{'AHthr'} !~ /^\\s*\$/ ) {
		\$search_field = \$hash->{'AHthr'} + 1;
		\$modifier     = \$hash->{'AHthrM'};
		\$field        = "threshold";
	}

	\$search_field =~ s/\\s+//g;

	if ( \$modifier eq "exact" ) {
		\$query .= "and cpp.name = ? and my_to_decimal(pp.value) = ? ";
	}
	elsif ( \$modifier eq "orLess" ) {
		\$query .= "and cpp.name = ? and my_to_decimal(pp.value) <= ? ";
	}
	elsif ( \$modifier eq "orMore" ) {
		\$query .= "and cpp.name = ? and my_to_decimal(pp.value) >= ? ";
	}

	push \@args, \$field        if \$field;
	push \@args, (\$search_field - 1) if \$search_field;

	\$query = \$select . \$join . \$query;

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };
	my \@list = ();

	my \@columns = \@{ \$sth->{NAME} };
	use Report_HTML_DB::Models::Application::AlienHunterSearch;
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		my \$result = Report_HTML_DB::Models::Application::AlienHunterSearch->new(
			id     => \$rows[\$i][0],
			contig => \$rows[\$i][1],
			start  => \$rows[\$i][2],
			end    => \$rows[\$i][3],
		);
		if ( \$columns[4] eq "length" ) {
			\$result->setLength( \$rows[\$i][4] );
		}
		elsif ( \$columns[4] eq "score" ) {
			\$result->setScore( \$rows[\$i][4] );
		}
		elsif ( \$columns[4] eq "threshold" ) {
			\$result->setThreshold( \$rows[\$i][4] );
		}

		push \@list, \$result;
	}

	return \\\@list;
}

=head2

Method used to return the reverse complement

=cut

sub reverseComplement {
	my (\$sequence) = \@_;
	my \$reverseComplement = reverse(\$sequence);
	\$reverseComplement =~ tr/ACGTacgt/TGCAtgca/;
	return \$reverseComplement;
}

=head2

Method used to realize search by feature

=cut

sub searchGene {
	my ( \$self, \$hash ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$query =
"SELECT me.feature_id AS feature_id, feature_relationship_props_subject_feature.value AS name, feature_relationship_props_subject_feature_2.value AS uniquename, "
	  . "featureloc_features_2.fstart AS fstart, featureloc_features_2.fend AS fend, featureprops_2.value AS type,  COUNT(*) OVER() AS total "
	  . "FROM feature me "
	  . "LEFT JOIN feature_relationship feature_relationship_objects_2 ON feature_relationship_objects_2.object_id = me.feature_id "
	  . "LEFT JOIN featureprop feature_relationship_props_subject_feature ON feature_relationship_props_subject_feature.feature_id = feature_relationship_objects_2.subject_id "
	  . "LEFT JOIN cvterm type ON type.cvterm_id = feature_relationship_props_subject_feature.type_id "
	  . "LEFT JOIN cvterm type_2 ON type_2.cvterm_id = feature_relationship_objects_2.type_id "
	  . "LEFT JOIN featureloc featureloc_features_2 ON featureloc_features_2.feature_id = me.feature_id "
	  . "LEFT JOIN featureprop featureloc_featureprop ON featureloc_featureprop.feature_id = featureloc_features_2.srcfeature_id "
	  . "LEFT JOIN cvterm type_3 ON type_3.cvterm_id = featureloc_featureprop.type_id "
	  . "LEFT JOIN feature_relationship feature_relationship_objects_4 ON feature_relationship_objects_4.object_id = me.feature_id "
	  . "LEFT JOIN featureprop feature_relationship_props_subject_feature_2 ON feature_relationship_props_subject_feature_2.feature_id = feature_relationship_objects_4.subject_id "
	  . "LEFT JOIN cvterm type_4 ON type_4.cvterm_id = feature_relationship_props_subject_feature_2.type_id "
	  . "LEFT JOIN featureprop featureprops_2 ON featureprops_2.feature_id = me.feature_id "
	  . "LEFT JOIN cvterm type_5 ON type_5.cvterm_id = featureprops_2.type_id ";
	my \$where =
"WHERE type.name = 'locus_tag' AND type_2.name = 'based_on' AND type_3.name = 'pipeline_id' AND type_4.name = 'description' AND type_5.name = 'tag' AND featureloc_featureprop.value = ? ";
	push \@args, \$hash->{pipeline};

	my \$connector = "";
	if ( exists \$hash->{featureId} && \$hash->{featureId} ) {
		if ( index( \$hash->{featureId}, " " ) != -1 ) {
			\$where .= " AND (";
			while ( \$hash->{featureId} =~ /(\\d+)+/g ) {
				\$connector = " OR " if \$connector;
				\$where .= \$connector . "me.feature_id = ? ";
				push \@args, \$1;
				\$connector = "1";
			}
			\$where .= ")";
		}
		else {

			\$where .= " AND me.feature_id = ? ";
			push \@args, \$hash->{featureId};
			\$connector = "1";
		}
	}

	if (   ( exists \$hash->{geneDescription} && \$hash->{geneDescription} )
		or ( exists \$hash->{noDescription} && \$hash->{noDescription} ) )
	{
		\$connector = " AND " if \$connector;
		\$where .= \$connector;
		my \@likesDescription   = ();
		my \@likesNoDescription = ();
		if ( \$hash->{geneDescription} ) {
			while ( \$hash->{geneDescription} =~ /(\\S+)/g ) {
				push \@likesDescription,
				  generate_clause( "?", "", "",
					"lower(feature_relationship_props_subject_feature_2.value)"
				  );
				push \@args, lc( "%" . \$1 . "%" );
			}
		}
		if ( \$hash->{noDescription} ) {
			while ( \$hash->{noDescription} =~ /(\\S+)/g ) {
				push \@likesNoDescription,
				  generate_clause( "?", "NOT", "",
					"lower(feature_relationship_props_subject_feature_2.value)"
				  );
				push \@args, lc( "%" . \$1 . "%" );
			}
		}

		if (    exists \$hash->{individually}
			and \$hash->{individually}
			and scalar(\@likesDescription) > 0 )
		{
			if ( scalar(\@likesNoDescription) > 0 ) {
				foreach my \$like (\@likesDescription) {
					\$where .= " AND " . \$like;
				}
				foreach my \$notLike (\@likesNoDescription) {
					\$where .= " AND " . \$notLike;
				}
			}
			else {
				foreach my \$like (\@likesDescription) {
					\$where .= " AND " . \$like;
				}
			}
		}
		elsif ( scalar(\@likesDescription) > 0 ) {
			my \$and = "";
			if ( scalar(\@likesNoDescription) > 0 ) {
				foreach my \$notLike (\@likesNoDescription) {
					\$where .= " AND " . \$notLike;
				}
				\$and = "1";
			}
			if (\$and) {
				\$and = " AND ";
			}
			else {
				\$and = " OR ";
			}
			\$where .= " AND (";
			my \$counter = 0;
			foreach my \$like (\@likesDescription) {
				if ( \$counter == 0 ) {
					\$where .= \$like;
					\$counter++;
				}
				else {
					\$where .= \$and . \$like;
				}
			}
			\$where .= " ) ";
		}
		elsif ( scalar(\@likesDescription) <= 0
			and scalar(\@likesNoDescription) > 0 )
		{
			foreach my \$like (\@likesNoDescription) {
				\$where .= " AND " . \$like;
			}
		}
	}

	if ( exists \$hash->{geneID} && \$hash->{geneID} ) {
		\$where .=
" AND lower(feature_relationship_props_subject_feature.value) LIKE ? ";
		push \@args, lc( "\%" . \$hash->{geneID} . "\%" );
	}
	
	\$where .= " ORDER BY feature_relationship_props_subject_feature.value ASC ";

	if (   exists \$hash->{pageSize}
		&& \$hash->{pageSize}
		&& exists \$hash->{offset}
		&& \$hash->{offset} )
	{
		\$where .= " LIMIT ? ";
		push \@args, \$hash->{pageSize};
		if ( \$hash->{offset} == 1 ) {
			\$where .= " OFFSET 0 ";
		}
		else {
			\$where .= " OFFSET ? ";
			push \@args, \$hash->{offset};
		}
	}
	
	\$query .= \$where;

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };
	my \%returnedHash = ();
	my \@list         = ();

	use Report_HTML_DB::Models::Application::Feature;
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		my \$feature = Report_HTML_DB::Models::Application::Feature->new(
			feature_id => \$rows[\$i][0],
			uniquename => \$rows[\$i][2],
			name       => \$rows[\$i][1],
			fstart     => \$rows[\$i][3],
			fend       => \$rows[\$i][4],
			type       => \$rows[\$i][5],
		);
		\$returnedHash{total} = \$rows[\$i][6];
		push \@list, \$feature;
	}

	\$returnedHash{list} = \\\@list;

return \\\%returnedHash;
}

=head2

Method used to realize search for basic content of any feature
=cut

sub geneBasics {
	my ( \$self, \$hash ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$query =
"SELECT srcfeature.feature_id AS feature_id, feature_relationship_props_subject_feature.value AS name, srcfeature.uniquename AS uniquename, featureloc_features_2.fstart AS fstart, featureloc_features_2.fend AS fend, featureprops_2.value AS value "
	  . "FROM feature me "
	  . "LEFT JOIN feature_relationship feature_relationship_objects_2 ON feature_relationship_objects_2.object_id = me.feature_id "
	  . "LEFT JOIN featureprop feature_relationship_props_subject_feature ON feature_relationship_props_subject_feature.feature_id = feature_relationship_objects_2.subject_id "
	  . "LEFT JOIN cvterm type ON type.cvterm_id = feature_relationship_props_subject_feature.type_id "
	  . "LEFT JOIN cvterm type_2 ON type_2.cvterm_id = feature_relationship_objects_2.type_id "
	  . "LEFT JOIN featureprop featureprops_2 ON featureprops_2.feature_id = me.feature_id "
	  . "LEFT JOIN cvterm type_3 ON type_3.cvterm_id = featureprops_2.type_id "
	  . "LEFT JOIN featureloc featureloc_features_2 ON featureloc_features_2.feature_id = me.feature_id "
	  . "LEFT JOIN feature srcfeature ON srcfeature.feature_id = featureloc_features_2.srcfeature_id "
	  . "LEFT JOIN featureprop featureloc_featureprop ON featureloc_featureprop.feature_id = featureloc_features_2.srcfeature_id "
	  . "LEFT JOIN cvterm type_4 ON type_4.cvterm_id = featureloc_featureprop.type_id "
	  . "LEFT JOIN feature_relationship feature_relationship_objects_4 ON feature_relationship_objects_4.object_id = me.feature_id "
	  . "LEFT JOIN featureprop feature_relationship_props_subject_feature_2 ON feature_relationship_props_subject_feature_2.feature_id = feature_relationship_objects_4.subject_id "
	  . "LEFT JOIN cvterm type_5 ON type_5.cvterm_id = feature_relationship_props_subject_feature_2.type_id "
	  . "WHERE ( ( featureloc_featureprop.value = ? AND me.feature_id = ? AND type.name = 'locus_tag' AND type_2.name = 'based_on' AND type_3.name = 'tag' AND type_4.name = 'pipeline_id' AND type_5.name = 'description' ) ) "
	  . "GROUP BY srcfeature.feature_id, feature_relationship_props_subject_feature.value, feature_relationship_props_subject_feature_2.value, featureloc_features_2.fstart, featureloc_features_2.fend, featureprops_2.value ";
	push \@args, \$hash->{pipeline};
	push \@args, \$hash->{feature_id};
	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };
	my \@list = ();

	use Report_HTML_DB::Models::Application::Feature;
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		my \$feature = Report_HTML_DB::Models::Application::Feature->new(
			feature_id => \$rows[\$i][0],
			name       => \$rows[\$i][1],
			uniquename => \$rows[\$i][2],
			fstart     => \$rows[\$i][3],
			fend       => \$rows[\$i][4],
			type       => \$rows[\$i][5]
		);
		push \@list, \$feature;
	}

	return \\\@list;
}

=head2

Method used to get gene by position

=cut

sub geneByPosition {
	my ( \$self, \$hash ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$query =
	    "SELECT me.feature_id AS feature_id "
	  . "FROM feature me "
	  . "LEFT JOIN feature_relationship feature_relationship_objects_2 ON feature_relationship_objects_2.object_id = me.feature_id "
	  . "LEFT JOIN featureprop feature_relationship_props_subject_feature ON feature_relationship_props_subject_feature.feature_id = feature_relationship_objects_2.subject_id "
	  . "LEFT JOIN cvterm type ON type.cvterm_id = feature_relationship_props_subject_feature.type_id "
	  . "LEFT JOIN cvterm type_2 ON type_2.cvterm_id = feature_relationship_objects_2.type_id "
	  . "LEFT JOIN featureprop featureprops_2 ON featureprops_2.feature_id = me.feature_id "
	  . "LEFT JOIN cvterm type_3 ON type_3.cvterm_id = featureprops_2.type_id "
	  . "LEFT JOIN featureloc featureloc_features_2 ON featureloc_features_2.feature_id = me.feature_id "
	  . "LEFT JOIN feature srcfeature ON srcfeature.feature_id = featureloc_features_2.srcfeature_id "
	  . "LEFT JOIN featureprop featureloc_featureprop ON featureloc_featureprop.feature_id = featureloc_features_2.srcfeature_id "
	  . "LEFT JOIN cvterm type_4 ON type_4.cvterm_id = featureloc_featureprop.type_id "
	  . "WHERE ( ( featureloc_featureprop.value = ? AND featureloc_features_2.fstart >= ? AND featureloc_features_2.fend <= ? AND type.name = 'locus_tag' AND type_2.name = 'based_on' AND type_3.name = 'tag' AND type_4.name = 'pipeline_id' ) ) "
	  . "GROUP BY me.feature_id, featureloc_features_2.fstart, featureloc_features_2.fend, featureprops_2.value, srcfeature.uniquename, srcfeature.feature_id "
	  . "ORDER BY MIN( feature_relationship_props_subject_feature.value )";
	push \@args, \$hash->{pipeline};
	push \@args, \$hash->{start};
	push \@args, \$hash->{end};
	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };
	my \@list = ();

	my \@columns = \@{ \$sth->{NAME} };
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		for ( my \$j = 0 ; \$j < scalar \@columns ; \$j++ ) {
			push \@list, \$rows[\$i][\$j];
		}
	}

	return \\\@list;
}

=head2

Method used to realize search for description of non coding RNA

=cut

sub ncRNA_description {
	my ( \$self, \$feature_id, \$pipeline ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$query =
"SELECT me.object_id AS object_id, feature_relationship_props_subject_feature_2.value AS value "
	  . "FROM feature_relationship me  "
	  . "JOIN cvterm type ON type.cvterm_id = me.type_id "
	  . "LEFT JOIN analysisfeature feature_relationship_analysis_feature_feature_object_2 ON feature_relationship_analysis_feature_feature_object_2.feature_id = me.object_id "
	  . "LEFT JOIN analysis analysis ON analysis.analysis_id = feature_relationship_analysis_feature_feature_object_2.analysis_id "
	  . "LEFT JOIN featureloc feature_relationship_featureloc_subject_feature_2 ON feature_relationship_featureloc_subject_feature_2.feature_id = me.subject_id "
	  . "LEFT JOIN featureprop featureloc_featureprop ON featureloc_featureprop.feature_id = feature_relationship_featureloc_subject_feature_2.srcfeature_id "
	  . "LEFT JOIN cvterm type_2 ON type_2.cvterm_id = featureloc_featureprop.type_id "
	  . "LEFT JOIN featureprop feature_relationship_props_subject_feature_2 ON feature_relationship_props_subject_feature_2.feature_id = me.subject_id "
	  . "LEFT JOIN cvterm type_3 ON type_3.cvterm_id = feature_relationship_props_subject_feature_2.type_id "
	  . "WHERE ( ( analysis.program = 'annotation_infernal.pl' AND featureloc_featureprop.value = ? AND me.object_id = ? AND type.name = 'interval' AND type_2.name = 'pipeline_id' AND type_3.name = 'target_description' ) ) "
	  . "GROUP BY me.object_id, feature_relationship_props_subject_feature_2.value "
	  . "ORDER BY feature_relationship_props_subject_feature_2.value ASC";
	push \@args, \$pipeline;
	push \@args, \$feature_id;
	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows    = \@{ \$sth->fetchall_arrayref() };
	my \%hash    = ();
	my \@columns = \@{ \$sth->{NAME} };

	for ( my \$i = 0 ; \$i < scalar \@columns ; \$i++ ) {
		\$hash{ \$columns[\$i] } = \$rows[0][\$i];
	}

	return \\\%hash;
}

=head2

Method used to realize search by subevidences

=cut

sub subevidences {
	my ( \$self, \$feature_id ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$query =
"SELECT subev_id, subev_type, subev_number, subev_start, subev_end, subev_strand, is_obsolete, program FROM get_subevidences(?) ORDER BY subev_id ASC";
	push \@args, \$feature_id;

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };

	my \%component_name = (
		'annotation_interpro.pl' => 'Domain search - InterProScan',
		'annotation_blast.pl'    => 'Similarity search - BLAST',
		'annotation_rpsblast.pl' => 'Similarity search - RPSBLAST',
		'annotation_phobius.pl' =>
		  'Transmembrane domains and signal peptide search - Phobius',
		'annotation_pathways.pl'  => 'Pathway classification - KEGG',
		'annotation_orthology.pl' => 'Orthology assignment - eggNOG',
		'annotation_tcdb.pl'      => 'Transporter classification - TCDB',
		'annotation_dgpi.pl'      => 'GPI anchor - DGPI',
		'annotation_predgpi.pl'	=> 'PreDGPI',
		'annotation_tmhmm.pl'     => 'TMHMM',
		'annotation_hmmer.pl'	=> 'HMMER',
	);

	my \@list = ();
	use Report_HTML_DB::Models::Application::Subevidence;
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		my \$subevidence = Report_HTML_DB::Models::Application::Subevidence->new(
			id                  => \$rows[\$i][0],
			type                => \$rows[\$i][1],
			number              => \$rows[\$i][2],
			start               => \$rows[\$i][3],
			end                 => \$rows[\$i][4],
			strand              => \$rows[\$i][5],
			is_obsolete         => \$rows[\$i][6],
			program             => \$rows[\$i][7],
			program_description => \$component_name{ \$rows[\$i][7] }
		);
		push \@list, \$subevidence;
	}

	return \\\@list;
}

=head2

Method used to realize search by interval evidence properties

=cut

sub intervalEvidenceProperties {
	my ( \$self, \$feature_id ) = \@_;
	my \$dbh = \$self->dbh;

	my \$query =
	  "SELECT key, key_value FROM get_interval_evidence_properties(?)";

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\$feature_id);
	my \@rows = \@{ \$sth->fetchall_arrayref() };

	my \@list = ();

	my \@listProperties = ();
	my \%property       = ();
	my \@columns        = \@{ \$sth->{NAME} };
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		my \%hash = ();
		for ( my \$j = 0 ; \$j < scalar \@columns ; \$j++ ) {
			\$hash{ \$columns[\$j] } = \$rows[\$i][\$j];
		}
		push \@list, \\\%hash;
	}

	for ( my \$i = 0 ; \$i < scalar \@list ; \$i++ ) {
		my \$hash = \$list[\$i];
		if ( !exists \$property{ \$hash->{key} } ) {
			if ( \$hash->{key} eq "anticodon" ) {
				\$property{ \$hash->{key} } = \$hash->{key_value};
				\$property{codon} = reverseComplement( \$hash->{key_value} );
			}
			else {
				\$property{ \$hash->{key} } = \$hash->{key_value};
			}
		}
		else {
			my \%tempHash = ();
			foreach my \$key ( keys \%property ) {
				if ( defined \$key && \$key ) {
					\$tempHash{\$key} = \$property{\$key};
				}
			}
			push \@listProperties, \\%tempHash;
			\%property = ();
			if ( \$hash->{key} eq "anticodon" ) {
				\$property{ \$hash->{key} } = \$hash->{key_value};
				\$property{codon} = reverseComplement( \$hash->{key_value} );
			}
			else {
				\$property{ \$hash->{key} } = \$hash->{key_value};
			}
		}
		if ( scalar \@listProperties == 0 ) {
			push \@listProperties, \\\%property;
		}
	}

	return \\\@listProperties;
}

=head2

Method used to realize search by similarity evidence properties

=cut

sub similarityEvidenceProperties {
	my ( \$self, \$feature_id ) = \@_;
	my \$dbh = \$self->dbh;

	my \$query =
	  "SELECT key, key_value FROM get_similarity_evidence_properties(?)";

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\$feature_id);
	my \@rows = \@{ \$sth->fetchall_arrayref() };

	my \@list    = ();
	my \@columns = \@{ \$sth->{NAME} };

	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {
		my \%hash = ();
		for ( my \$j = 0 ; \$j < scalar \@columns ; \$j++ ) {
			\$hash{ \$columns[\$j] } = \$rows[\$i][\$j];
		}
		push \@list, \\\%hash;
	}
	my \%returnedhash = ();
	for ( my \$i = 0 ; \$i < scalar \@list ; \$i++ ) {
		my \$result = \$list[\$i];
		if ( \$result->{key} eq "anticodon" ) {
			\$returnedhash{ \$result->{key} } = \$result->{key_value};
			\$returnedhash{codon} = reverseComplement( \$result->{key_value} );
		}
		else {
			\$returnedhash{ \$result->{key} } = \$result->{key_value};
		}
	}
	\$returnedhash{id} = \$feature_id;

	return \\\%returnedhash;

}

=head2

Method used to get identifier and description of similarity

=cut

sub getIdentifierAndDescriptionSimilarity {
	my (\$self, \$feature_id) = \@_;
	my \$dbh = \$self->dbh;

	my \$query =
	  "select p.value from feature_relationship r 
join feature q on (r.subject_id = q.feature_id)         
join featureprop p on (p.feature_id = r.subject_id)
join cvterm c on (p.type_id = c.cvterm_id)
join cvterm cr on (r.type_id = cr.cvterm_id)
join cvterm cq on (q.type_id = cq.cvterm_id)
where cr.name='alignment' 
and cq.name='subject_sequence' and c.name='subject_id' and r.object_id=? ";

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;

	\$sth->execute(\$feature_id);
	my \@rows = \@{ \$sth->fetchall_arrayref() };

	my \%hash = ();
	for ( my \$i = 0 ; \$i < scalar \@rows ; \$i++ ) {

		my \$response = \$rows[\$i][0];
		my \@values = ();
		if (\$response =~ /\\|/g) {
			if (\$response =~ /CDD/g) {
				\$response =~ /\\|\\w+\\|(\\d*)([\\w\\ ;.,]*)/g;
				while (\$response =~ /\\|\\w+\\|(\\d*)([\\w\\ ;.,]*)/g) {
					push \@values, \$1;
					push \@values, \$2;
				}
			}  else {
				while (\$response =~ /(?:\\w+)\\|(\\w+\\.*\\w*)\\|([\\w\\ \\:\\[\\]\\<\\>\\.\\-\\+\\*\\(\\)\\&\\%\\$\\#\\@\\!\\/]*)\$/g) {
					push \@values, \$1;
					push \@values, \$2;
				}
			} 
		} else {
			while (\$response =~ /(\\w+)([\\w\\s]*)/g) {
				push \@values, \$1;
				push \@values, \$2;
			}
		}
		\$hash{identifier} = \$values[0];
		\$hash{description} = \$values[1];

	}
	return \\\%hash;
}

=head2

Method used to get feature ID by uniquename

=cut

sub get_feature_id {
	my ( \$self, \$uniquename ) = \@_;
	my \$dbh = \$self->dbh;

	my \$query = "SELECT feature_id FROM feature WHERE uniquename = ? LIMIT 1";

	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\$uniquename);
	my \@rows = \@{ \$sth->fetchall_arrayref() };

	return \$rows[0][0];
}

=head2

Method used to get target class

=cut

sub get_target_class {
	my ( \$self, \$pipeline_id ) = \@_;
	my \$dbh  = \$self->dbh;
	my \@args = ();
	my \$query =
"select ppc.value as value 
	from feature_relationship r 
	join featureloc l on (r.subject_id = l.feature_id) 
	join featureprop p on (p.feature_id = l.srcfeature_id) 
	join cvterm cp on (p.type_id = cp.cvterm_id) 
	join featureprop ppc on (ppc.feature_id = r.subject_id) 
	join cvterm cppc on (ppc.type_id = cppc.cvterm_id) 
	WHERE cppc.name= 'target_class' and cp.name='pipeline_id' and p.value=?";
	push \@args, \$pipeline_id;
	my \$sth = \$dbh->prepare(\$query);
	print STDERR \$query;
	\$sth->execute(\@args);
	my \@rows = \@{ \$sth->fetchall_arrayref() };

	my \@list = ();

	my \@columns = \@{ \$sth->{NAME} };
	for ( my \$i = 0 ; \$i < scalar \@columns ; \$i++ ) {
		my \%hash = ();
		\$hash{ \$columns[\$i] } = \$rows[0][\$i];
		push \@list, \\\%hash;
	}

	return \@list;
}

=head1 NAME

$packageDBI - DBI Model Class

=head1 SYNOPSIS

See L<HTML_DIR>

=head1 DESCRIPTION

DBI Model Class.

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

DBI

writeFile( "$services_dir/lib/$services_dir/Model/SearchDatabaseRepository.pm",
	$DBI );
	
$packageDBI = $services_dir . "::Model::BlastRepository";
$DBI        = <<DBI;
package $packageDBI;
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config(
	class		=> 'Report_HTML_DB::Repositories::BlastRepository',
	constructor	=> 'new',
);

1;

DBI

writeFile( "$services_dir/lib/$services_dir/Model/BlastRepository.pm",
	$DBI );

#####
#
#	Add controllers
#
#####

#create controllers project
print $LOG "\nCreating controllers...\n";
my $lowCaseNameServices = $services_dir;
$lowCaseNameServices = lc $services_dir;
`$services_dir/script/"$lowCaseNameServices"_create.pl controller SearchDatabase`;

my $temporaryPackage = $html_dir . '::Controller::Site';
writeFile( "$html_dir/lib/$html_dir/Controller/Site.pm", <<CONTENTSite);
package $temporaryPackage;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

TESTE2::Controller::Site - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

=head2 getHTMLContent
Method used to get HTML content from file by filepath
=cut

sub getHTMLContent : Path("/GetHTMLContent") : CaptureArgs(1) :
  ActionClass('REST') { }

sub getHTMLContent_GET {
	my ( \$self, \$c, \$filepath ) = \@_;
	if ( !\$filepath and defined \$c->request->param("filepath") ) {
		\$filepath = \$c->request->param("filepath");
	}
	if(\$filepath =~ m/\\.\\.\\//) {
		\$self->status_bad_request(\$c, message => "Invalid filepath");
	}
	use File::Basename;
	open( my \$FILEHANDLER,
		"<", dirname(__FILE__) . "/../../../root/" . \$filepath );

	my \$content = do { local \$/; <\$FILEHANDLER> };
	close(\$FILEHANDLER);
	standardStatusOk( \$self, \$c, \$content );
}

=head2

Method used to return components used

=cut

sub getComponents : Path("/Components") : Args(0) :
  ActionClass('REST') { }

sub getComponents_GET {
	my ( \$self, \$c ) = \@_;

	my \$resultSet = \$c->model('Basic::Component')->search(
		{},
		{
			order_by => {
				-asc => [qw/ component /]
			},
		}
	);

	my \@list = ();
	while ( my \$result = \$resultSet->next ) {
		my \%hash = ();
		\$hash{id}        = \$result->id;
		\$hash{name}      = \$result->name;
		\$hash{component} = \$result->component;
		if ( \$result->filepath ne "" ) {
			\$hash{filepath} = \$result->filepath;
		}
		push \@list, \\%hash;
	}

	standardStatusOk( \$self, \$c, \\\@list );
}

=head2 searchContig

Method used to realize search by contigs, optional return a stretch or a reverse complement

=cut

sub searchContig : Path("/Contig") : CaptureArgs(4) :
  ActionClass('REST') { }

sub searchContig_GET {
	my ( \$self, \$c, \$contig, \$start, \$end, \$reverseComplement ) = \@_;
	if ( !\$contig and defined \$c->request->param("contig") ) {
		\$contig = \$c->request->param("contig");
	}
	if ( !\$start and defined \$c->request->param("contigStart") ) {
		\$start = \$c->request->param("contigStart");
	}
	if ( !\$end and defined \$c->request->param("contigEnd") ) {
		\$end = \$c->request->param("contigEnd");
	}
	if ( !\$reverseComplement
		and defined \$c->request->param("revCompContig") )
	{
		\$reverseComplement = \$c->request->param("revCompContig");
	}

	use File::Basename;
	my \$data     = "";
	my \$sequence = \$c->model('Basic::Sequence')->find(\$contig);

	open( my \$FILEHANDLER,
		"<", dirname(__FILE__) . "/../../../root/" . \$sequence->filepath );

	for my \$line (<\$FILEHANDLER>) {
		if ( !( \$line =~ /^>\\w+\\n\$/g ) ) {
			\$data .= \$line;
		}
	}
	close(\$FILEHANDLER);

	if ( \$start && \$end ) {
		\$start += -1;
		\$data = substr( \$data, \$start, ( \$end - \$start ) );
		\$c->stash->{start}     = \$start;
		\$c->stash->{end}       = \$end;
		\$c->stash->{hadLimits} = 1;
	}
	if ( defined \$reverseComplement ) {
		\$data = formatSequence( reverseComplement(\$data) );
		\$c->stash->{hadReverseComplement} = 1;
	}
	my \$result = "";
	for ( my \$i = 0 ; \$i < length(\$data) ; \$i += 60 ) {
		my \$line = substr( \$data, \$i, 60 );
		\$result .= "\$line<br />";
	}

	my \@list = ();
	my \%hash = ();
	\$hash{'geneID'} = \$sequence->id;
	\$hash{'gene'}   = \$sequence->name;
	\$hash{'contig'} = \$result;

	push \@list, \\%hash;
	standardStatusOk( \$self, \$c, \@list );
}

=head2 reverseComplement

Method used to return the reverse complement of a sequence

=cut

sub reverseComplement {
	my (\$sequence) = \@_;
	my \$reverseComplement = reverse(\$sequence);
	\$reverseComplement =~ tr/ACGTacgt/TGCAtgca/;
	return \$reverseComplement;
}

=head2 formatSequence

Method used to format sequence

=cut

sub formatSequence {
    my \$seq = shift;
    my \$block = shift || 80;
    \$seq =~ s/.{\$block}/\$&\\n/gs;
    chomp \$seq;
    return \$seq;
}

=head2
Standard return of status ok
=cut

sub standardStatusOk {
	my ( \$self, \$c, \$response, \$total, \$pageSize, \$offset ) = \@_;
	if (   ( defined \$total || \$total )
		&& ( defined \$pageSize || \$pageSize )
		&& ( defined \$offset   || \$offset ) )
	{
		my \$pagedResponse = \$c->model('PagedResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => \$c->stats->elapsed,
			response    => \$response,
			total       => \$total,
			pageSize    => \$pageSize,
			offset      => \$offset,
		);
		\$self->status_ok( \$c, entity => \$pagedResponse->pack(), );
	}
	else {
		my \$baseResponse = \$c->model('BaseResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => \$c->stats->elapsed,
			response    => \$response
		);
		\$self->status_ok( \$c, entity => \$baseResponse->pack(), );
	}
}

=encoding utf8

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
CONTENTSite
$temporaryPackage = $services_dir . '::Controller::Blast';
writeFile( "$services_dir/lib/$services_dir/Controller/Blast.pm" , <<CONTENT
package $temporaryPackage;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

services::Controller::Blast - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

=head2

Method used to realize search blast

=cut

sub search : Path("/Blast/search") : CaptureArgs(18) : ActionClass('REST') { }

sub search_POST {
	my ( \$self, \$c ) = \@_;

	open( my \$FILEHANDLER, "<", \$c->req->body );
	my \$formData = do { local \$/; <\$FILEHANDLER> };
	close(\$FILEHANDLER);
	use JSON;
	my \%hash = \%{ decode_json(\$formData) };

	foreach my \$key ( keys \%hash ) {
		if (\$key) {
			chomp( \$hash{\$key} ) if \$key ne "SEQUENCE";
		}
	}

	use File::Temp ();
	my \$fh    = File::Temp->new();
	my \$fname = \$fh->filename;
	open( \$FILEHANDLER, ">", \$fname );
	my \@fuckingSequence = split( /\\\\n/, \$hash{SEQUENCE} );
	\$hash{SEQUENCE} = join( "\\n", \@fuckingSequence );
	print \$FILEHANDLER \$hash{SEQUENCE};
	close(\$FILEHANDLER);

	\$hash{DATALIB} = "saida_db/services/root/seq/Bacteria"
	  if ( \$hash{DATALIB} eq "PMN_genome_1" );
	\$hash{DATALIB} = "saida_db/services/root/orfs_nt/Bacteria"
	  if ( \$hash{DATALIB} eq "PMN_genes_1" );
	\$hash{DATALIB} = "saida_db/services/root/orfs_aa/Bacteria"
	  if ( \$hash{DATALIB} eq "PMN_prot_1" );
	my \$content = "";
	if ( exists \$hash{PROGRAM} ) {
		if (   \$hash{PROGRAM} eq "blastn"
			|| \$hash{PROGRAM} eq "blastp"
			|| \$hash{PROGRAM} eq "blastx"
			|| \$hash{PROGRAM} eq "tblastn"
			|| \$hash{PROGRAM} eq "tblastx" )
		{
			my \@response = \@{
				\$c->model('BlastRepository')->executeBlastSearch(
					\$hash{PROGRAM},            \$hash{DATALIB},
					\$fname,                    \$hash{QUERY_FROM},
					\$hash{QUERY_TO},           \$hash{FILTER},
					\$hash{EXPECT},             \$hash{MAT_PARAM},
					\$hash{UNGAPPED_ALIGNMENT}, \$hash{GENETIC_CODE},
					\$hash{DB_GENETIC_CODE},    \$hash{OOF_ALIGN},
					\$hash{OTHER_ADVANCED},     \$hash{OVERVIEW},
					\$hash{ALIGNMENT_VIEW},     \$hash{DESCRIPTIONS},
					\$hash{ALIGNMENTS},         \$hash{COLOR_SCHEMA}
				)
			};
			\$content = join( "", \@response );
		}
		else {
			\$content = "PROGRAM NOT IN THE LIST";
		}
	}
	else {
		\$content = "NO PROGRAM DEFINED";
	}

	return standardStatusOk( \$self, \$c, \$content );
}

sub fancy : Path("/Blast/fancy") : CaptureArgs(3) : ActionClass('REST') { }

sub fancy_POST {
	my ( \$self, \$c ) = \@_;
	open( my \$FILEHANDLER, "<", \$c->req->body );
	my \$formData = do { local \$/; <\$FILEHANDLER> };
	close(\$FILEHANDLER);
	use JSON;
	my \%hash = \%{ decode_json(\$formData) };

	use File::Temp ();
	my \$fh    = File::Temp->new();
	my \$fname = \$fh->filename;
	open( \$FILEHANDLER, ">", \$fname );
	print \$FILEHANDLER \$hash{blast};
	close(\$FILEHANDLER);
	use File::Temp qw/ :mktemp  /;
	my \$tmpdir_name = mkdtemp("/tmp/XXXXXX");
	\%hash = ();
	if (\$c->model('BlastRepository')->fancyBlast(\$fname, \$tmpdir_name)) {
		my \@files = ();
		opendir(my \$DIR, \$tmpdir_name);
		\@files = grep(!/^\\./, readdir(\$DIR));
		closedir(\$DIR);
		use MIME::Base64;
		for(my \$i = 0; \$i < scalar \@files; \$i++) 
		{
			open(\$FILEHANDLER, "<", \$tmpdir_name . "/" . \$files[\$i]);
			my \$content = do { local \$/; <\$FILEHANDLER> };
			if(\$files[\$i] =~ /\\.html/g) {
				\$hash{html} = \$content;
			}
			elsif(\$files[\$i] =~ /\\.png/g) {
				\$hash{image} = MIME::Base64::encode_base64(\$content);
			}
			close(\$FILEHANDLER);
		}
	}
	use File::Path;
	rmtree(\$tmpdir_name);
	return standardStatusOk(\$self, \$c, \\\%hash);
}

=head2

Method used to make a default return of every ok request using BaseResponse model

=cut

sub standardStatusOk {
	my ( \$self, \$c, \$response, \$total, \$pageSize, \$offset ) = \@_;
	if (   ( defined \$total || \$total )
		&& ( defined \$pageSize || \$pageSize )
		&& ( defined \$offset   || \$offset ) )
	{
		my \$pagedResponse = \$c->model('PagedResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => \$c->stats->elapsed,
			response    => \$response,
			total       => \$total,
			pageSize    => \$pageSize,
			offset      => \$offset,
		);
		\$self->status_ok( \$c, entity => \$pagedResponse->pack(), );
	}
	else {
		my \$baseResponse = \$c->model('BaseResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => \$c->stats->elapsed,
			response    => \$response
		);
		\$self->status_ok( \$c, entity => \$baseResponse->pack(), );
	}
}

=encoding utf8

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

CONTENT
);

$temporaryPackage = $services_dir . '::Controller::SearchDatabase';
writeFile( "$services_dir/lib/$services_dir/Controller/SearchDatabase.pm",
	<<CONTENT);
package $temporaryPackage;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

services::Controller::SearchDatabase - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

=head2

Method used to get feature id

=cut

sub getFeatureID : Path("/SearchDatabase/GetFeatureID") : CaptureArgs(1) :
  ActionClass('REST') { }

sub getFeatureID_GET {
	my (\$self, \$c, \$uniquename) = \@_;
	if ( !\$uniquename and defined \$c->request->param("uniquename") ) {
		\$uniquename = \$c->request->param("uniquename");
	}
	return standardStatusOk( \$self, \$c,
		\$c->model('SearchDatabaseRepository')->get_feature_id(\$uniquename));
}

=head2 searchGene

Method used to search on database genes

=cut

sub searchGene : Path("/SearchDatabase/Gene") : CaptureArgs(6) :
  ActionClass('REST') { }

sub searchGene_GET {
	my ( \$self, 	\$c, 	\$pipeline, 	\$geneID, 
		\$geneDescription, 	\$noDescription, \$individually,	\$featureId,
		\$pageSize,        \$offset )
	  = \@_;

	if ( !\$pipeline and defined \$c->request->param("pipeline") ) {
		\$pipeline = \$c->request->param("pipeline");
	}
	if ( !\$geneID and defined \$c->request->param("geneID") ) {
		\$geneID = \$c->request->param("geneID");
	}
	if ( !\$geneDescription and defined \$c->request->param("geneDesc") ) {
		\$geneDescription = \$c->request->param("geneDesc");
	}
	if ( !\$noDescription and defined \$c->request->param("noDesc") ) {
		\$noDescription = \$c->request->param("noDesc");
	}
	if ( !\$individually and defined \$c->request->param("individually") ) {
		\$individually = \$c->request->param("individually");
	}
	if ( !\$featureId and defined \$c->request->param("featureId") ) {
		\$featureId = \$c->request->param("featureId");
	}
	if ( !\$pageSize and defined \$c->request->param("pageSize") ) {
		\$pageSize = \$c->request->param("pageSize");
	}
	if ( !\$offset and defined \$c->request->param("offset") ) {
		\$offset = \$c->request->param("offset");
	}

	my \@list = ();
	my \%hash = ();
	\$hash{pipeline}        = \$pipeline;
	\$hash{featureId}       = \$featureId;
	\$hash{geneID}          = \$geneID;
	\$hash{geneDescription} = \$geneDescription;
	\$hash{noDescription}   = \$noDescription;
	\$hash{individually}    = \$individually;
	\$hash{pageSize}        = \$pageSize;
	\$hash{offset}          = \$offset;

	my \$result     = \$c->model('SearchDatabaseRepository')->searchGene( \\\%hash );
	my \@resultList = \@{ \$result->{list} };

	for ( my \$i = 0 ; \$i < scalar \@resultList ; \$i++ ) {
		push \@list, \$resultList[\$i]->pack();
	}

	standardStatusOk( \$self, \$c, \\\@list, \$result->{total}, \$pageSize, \$offset );
}

=head2 encodingCorrection

Method used to correct encoding strings come from SQLite

=cut

sub encodingCorrection {
	my (\@texts) = \@_;

	use utf8;
	use Encode qw( decode encode );
	foreach my \$text (\@texts) {
		foreach my \$key ( keys \%\$text ) {
			if ( \$text->{\$key} != 1 ) {
				my \$string = decode( 'utf-8', \$text->{\$key}{value} );
				\$string = encode( 'iso-8859-1', \$string );
				\$text->{\$key}{value} = \$string;
			}
		}
	}
	return \@texts;
}

=head2 getGeneBasics
Method used to return basic data of genes from database: the beginning position from sequence, final position from the sequence, type, name
return a list of hash containing the basic data

=cut

sub getGeneBasics : Path("/SearchDatabase/GetGeneBasics") : CaptureArgs(2) :
  ActionClass('REST') { }

sub getGeneBasics_GET {
	my ( \$self, \$c, \$id, \$pipeline ) = \@_;

	#verify if the id exist and set
	if ( !\$id and defined \$c->request->param("id") ) {
		\$id = \$c->request->param("id");
	}
	if ( !\$pipeline and defined \$c->request->param("pipeline") ) {
		\$pipeline = \$c->request->param("pipeline");
	}
	
	my \%hash = ();
	\$hash{pipeline}   = \$pipeline;
	\$hash{feature_id} = \$id;

	my \@resultList = \@{ \$c->model('SearchDatabaseRepository')->geneBasics( \\\%hash ) };
	my \@list       = ();
	for ( my \$i = 0 ; \$i < scalar \@resultList ; \$i++ ) {
		push \@list, \$resultList[\$i]->pack();
	}

	standardStatusOk( \$self, \$c, \\\@list );
}

=head2 getSubsequence

Method used to get subsequence stretch of gene, returning the sequence, had to return in a json!

=cut

sub getSubsequence : Path("/SearchDatabase/GetSubsequence") : CaptureArgs(6) :
  ActionClass('REST') { }

sub getSubsequence_GET {
	my ( \$self, \$c, \$type, \$contig, \$sequenceName, \$start, \$end, \$pipeline ) = \@_;
	if ( !\$contig and defined \$c->request->param("contig") ) {
		\$contig = \$c->request->param("contig");
	}
	if ( !\$type and defined \$c->request->param("type") ) {
		\$type = \$c->request->param("type");
	}
	if ( !\$pipeline and defined \$c->request->param("pipeline") ) {
		\$pipeline = \$c->request->param("pipeline");
	}
	if ( !\$sequenceName and defined \$c->request->param("sequenceName") ) {
		\$sequenceName = \$c->request->param("sequenceName");
	}
	if ( !\$start and defined \$c->request->param("start") ) {
		\$start = \$c->request->param("start");
	}
	if ( !\$end and defined \$c->request->param("end") ) {
		\$end = \$c->request->param("end");
	}

	my \$content = "";
	use File::Basename;

	if ( \$type ne "CDS" ) {
		open(
			my \$FILEHANDLER,
			"<",
			dirname(__FILE__)
			  . "/../../../root/seq/"
			  . \$sequenceName
			  . ".fasta"
		);
		for my \$line (<\$FILEHANDLER>) {
			if ( !( \$line =~ /^>\\w+\\n\$/g ) ) {
				\$content .= \$line;
			}
		}

		close(\$FILEHANDLER);

		if ( \$start && \$end ) {
			\$content = substr( \$content, \$start, ( \$end - ( \$start + 1 ) ) );
		}
		my \$result = "";
		for ( my \$i = 0 ; \$i < length(\$content) ; \$i += 60 ) {
			my \$line = substr( \$content, \$i, 60 );
			\$result .= "\$line<br />";
		}
		\$content = \$result;
	}
	else {
		open(
			my \$FILEHANDLER,
			"<",
			dirname(__FILE__) . "/../../../root/orfs_aa/" . \$contig . ".fasta"
		);

		for my \$line (<\$FILEHANDLER>) {
			if ( !( \$line =~ /^>\\w+\\n\$/g ) ) {
				\$content .= \$line;
			}
		}
		close(\$FILEHANDLER);
		\$content =~ s/\\n/<br \\/>/g;
	}
	standardStatusOk( \$self, \$c, { "sequence" => \$content } );
}

=head2 ncRNA_desc  

Method used to return nc rna description

=cut

sub ncRNA_desc : Path("/SearchDatabase/ncRNA_desc") : CaptureArgs(2) :
  ActionClass('REST') { }

sub ncRNA_desc_GET {
	my ( \$self, \$c, \$feature, \$pipeline ) = \@_;
	if ( !\$feature and defined \$c->request->param("feature") ) {
		\$feature = \$c->request->param("feature");
	}
	if ( !\$pipeline and defined \$c->request->param("pipeline") ) {
		\$pipeline = \$c->request->param("pipeline");
	}
	standardStatusOk( \$self, \$c,
		\$c->model('SearchDatabaseRepository')->ncRNA_description( \$feature, \$pipeline ) );

}

=head2

Method used to return subevidences based on feature id

=cut

sub subEvidences : Path("/SearchDatabase/subEvidences") : CaptureArgs(2) :
  ActionClass('REST') { }

sub subEvidences_GET {
	my ( \$self, \$c, \$feature, \$pipeline ) = \@_;
	if ( !\$feature and defined \$c->request->param("feature") ) {
		\$feature = \$c->request->param("feature");
	}
	if ( !\$pipeline and defined \$c->request->param("pipeline") ) {
		\$pipeline = \$c->request->param("pipeline");
	}
	my \@list       = ();
	my \@resultList = \@{ \$c->model('SearchDatabaseRepository')->subevidences(\$feature) };
	for ( my \$i = 0 ; \$i < scalar \@resultList ; \$i++ ) {
		push \@list, \$resultList[\$i]->pack();
	}
	standardStatusOk( \$self, \$c, \\\@list );
}

=head2

Method used to return properties of evidences that the type is interval and basic data of everything isn't CDS

=cut

sub getIntervalEvidenceProperties :
  Path("/SearchDatabase/getIntervalEvidenceProperties") : CaptureArgs(3) :
  ActionClass('REST') { }

sub getIntervalEvidenceProperties_GET {
	my ( \$self, \$c, \$feature, \$typeFeature, \$pipeline ) = \@_;
	if ( !\$feature and defined \$c->request->param("feature") ) {
		\$feature = \$c->request->param("feature");
	}
	if ( !\$typeFeature and defined \$c->request->param("typeFeature") ) {
		\$typeFeature = \$c->request->param("typeFeature");
	}
	if ( !\$pipeline and defined \$c->request->param("pipeline") ) {
		\$pipeline = \$c->request->param("pipeline");
	}

	my \%hash = ();
	\$hash{properties} = \$c->model('SearchDatabaseRepository')->intervalEvidenceProperties(\$feature);
	if ( exists \$hash{intron} ) {
		if ( \$hash{intron} eq 'yes' ) {
			\$hash{coordinatesGene} = \$hash{intron_start} - \$hash{intron_end};
			\$hash{coordinatesGenome} =
			  \$hash{intron_start_seq} - \$hash{intron_end_seq};
		}
	}
	if ( \$typeFeature eq 'annotation_pathways' ) {
		my \@pathways        = ();
		my \@ids             = ();
		my \@descriptions    = ();
		my \@classifications = ();
		for ( my \$i = 0 ; \$i < scalar \@{ \$hash{properties} } ; \$i++ ) {
			while ( \$hash{properties}[\$i]->{metabolic_pathway_classification} =~
				/([\\w\\s]+)/g )
			{
				push \@classifications, \$1;
			}
			while ( \$hash{properties}[\$i]->{metabolic_pathway_description} =~
				/([\\w\\s]+)/g )
			{
				push \@descriptions, \$1;
			}
			while (
				\$hash{properties}[\$i]->{metabolic_pathway_id} =~ /([\\w\\s]+)/g )
			{
				push \@ids, \$1;
			}
			for ( my \$j = 0 ; \$j < scalar \@ids ; \$j++ ) {
				my \%pathway = ();
				\$pathway{id}            = \$ids[\$j];
				\$pathway{description}   = \$descriptions[\$j];
				\$pathway{classfication} = \$classifications[\$j];
				push \@pathways, \\\%pathway;
			}
		}

		\$hash{pathways} = \\\@pathways;
		\$hash{id}       = \$feature;
	}
	elsif ( \$typeFeature eq 'annotation_orthology' ) {
		my \@orthologous_groups = ();
		my \@groups             = ();
		my \@descriptions       = ();
		my \@classifications    = ();
		for ( my \$i = 0 ; \$i < scalar \@{ \$hash{properties} } ; \$i++ ) {
			while ( \$hash{properties}[\$i]->{orthologous_group} =~
				/([\\w\\s.\\-(),]+)/g )
			{
				push \@groups, \$1;
			}
			while ( \$hash{properties}[\$i]->{orthologous_group_description} =~
				/([\\w\\s.\\-(),]+)/g )
			{
				push \@descriptions, \$1;
			}
			while ( \$hash{properties}[\$i]->{orthologous_group_classification} =~
				/([\\w\\s.\\-(),]+)/g )
			{
				push \@classifications, \$1;
			}
			for ( my \$j = 0 ; \$j < scalar \@groups ; \$j++ ) {
				my \%group = ();
				\$group{group}          = \$groups[\$j];
				\$group{description}    = \$descriptions[\$j];
				\$group{classification} = \$classifications[\$j];
				push \@orthologous_groups, \\\%group;
			}
		}
		\$hash{orthologous_groups} = \\\@orthologous_groups;
		\$hash{id}                 = \$feature;
	}
	if ( !( exists \$hash{id} ) ) {
		\$hash{id} = \$feature;
	}

	standardStatusOk( \$self, \$c, \\\%hash );
}

=head2

Method used to return properties of evidence typed like similarity

=cut

sub getSimilarityEvidenceProperties :
  Path("/SearchDatabase/getSimilarityEvidenceProperties") : CaptureArgs(1) :
  ActionClass('REST') { }

sub getSimilarityEvidenceProperties_GET {
	my ( \$self, \$c, \$feature ) = \@_;
	if ( !\$feature and defined \$c->request->param("feature") ) {
		\$feature = \$c->request->param("feature");
	}

	standardStatusOk( \$self, \$c,
		\$c->model('SearchDatabaseRepository')->similarityEvidenceProperties(\$feature) );
}

sub getIdentifierAndDescriptionSimilarity :
  Path("/SearchDatabase/getIdentifierAndDescriptionSimilarity") : CaptureArgs(1) :
  ActionClass('REST') { }
  
sub getIdentifierAndDescriptionSimilarity_GET {
	my ( \$self, \$c, \$feature_id ) = \@_;
	if ( !\$feature_id and defined \$c->request->param("feature_id") ) {
		\$feature_id = \$c->request->param("feature_id");
	}
	standardStatusOk( \$self, \$c,
		\$c->model('SearchDatabaseRepository')->getIdentifierAndDescriptionSimilarity(\$feature_id) );
}  

=head2 reverseComplement

Method used to return the reverse complement of a sequence

=cut

sub reverseComplement {
	my (\$sequence) = \@_;
	my \$reverseComplement = reverse(\$sequence);
	\$reverseComplement =~ tr/ACGTacgt/TGCAtgca/;
	return \$reverseComplement;
}

=head2 formatSequence

Method used to format sequence

=cut

sub formatSequence {
    my \$seq = shift;
    my \$block = shift || 80;
    \$seq =~ s/.{\$block}/\$&\\n/gs;
    chomp \$seq;
    return \$seq;
}

=head2 analysesCDS

Method used to make search of analyses of protein-coding genes

=cut

sub analysesCDS : Path("/SearchDatabase/analysesCDS") : CaptureArgs(32) :
  ActionClass('REST') { }

sub analysesCDS_GET {
	my ( \$self, \$c ) = \@_;

	my \%hash = ();
	my \@list = ();

	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}
	my \$result = \$c->model('SearchDatabaseRepository')->analyses_CDS( \\\%hash );
	foreach my \$value ( \@{ \$result->{list} } ) {
		push \@list, \$value;
	}
	standardStatusOk( \$self, \$c, \\\@list, \$result->{total}, \$hash{pageSize},
		\$hash{offset} );
}

=head2

Method used to realize search of tRNA

=cut

sub trnaSearch : Path("/SearchDatabase/trnaSearch") : CaptureArgs(5) :
  ActionClass('REST') { }

sub trnaSearch_GET {
	my ( \$self, \$c ) = \@_;

	my \%hash = ();
	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}
	my \@list       = ();
	my \$result     = \$c->model('SearchDatabaseRepository')->tRNA_search( \\\%hash );
	my \@resultList = \@{ \$result->{list} };

	for ( my \$i = 0 ; \$i < scalar \@resultList ; \$i++ ) {
		push \@list, \$resultList[\$i]->pack();
	}

	standardStatusOk( \$self, \$c, \\\@list, \$result->{total}, \$hash{pageSize},
		\$hash{offset} );
}

=head2

Method used to get data of tandem repeats

=cut

sub tandemRepeatsSearch : Path("/SearchDatabase/tandemRepeatsSearch") :
  CaptureArgs(6) : ActionClass('REST') { }

sub tandemRepeatsSearch_GET {
	my ( \$self, \$c ) = \@_;

	my \%hash = ();
	my \@list = ();

	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}

	my \@resultList = \@{ \$c->model('SearchDatabaseRepository')->trf_search( \\\%hash ) };
	for ( my \$i = 0 ; \$i < scalar \@resultList ; \$i++ ) {
		push \@list, \$resultList[\$i]->pack();
	}

	standardStatusOk( \$self, \$c, \\\@list );
}

=head2

Method used to get data of non coding RNAs

=cut

sub ncRNASearch : Path("/SearchDatabase/ncRNASearch") : CaptureArgs(8) :
  ActionClass('REST') { }

sub ncRNASearch_GET {
	my ( \$self, \$c ) = \@_;

	my \%hash = ();
	my \@list = ();

	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}

	my \@resultList = \@{ \$c->model('SearchDatabaseRepository')->ncRNA_search( \\\%hash ) };

	for ( my \$i = 0 ; \$i < scalar \@resultList ; \$i++ ) {
		push \@list, \$resultList[\$i]->pack();
	}

	standardStatusOk( \$self, \$c, \\\@list );
}

=head2

Method used to get data of transcriptional terminators

=cut

sub transcriptionalTerminatorSearch :
  Path("/SearchDatabase/transcriptionalTerminatorSearch") : CaptureArgs(7) :
  ActionClass('REST') { }

sub transcriptionalTerminatorSearch_GET {
	my ( \$self, \$c ) = \@_;

	my \%hash = ();
	my \@list = ();

	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}

	my \@resultList =
	  \@{ \$c->model('SearchDatabaseRepository')->transcriptional_terminator_search( \\\%hash ) };

	for ( my \$i = 0 ; \$i < scalar \@resultList ; \$i++ ) {
		my \%hash = (
			contig => \$resultList[\$i]->getContig,
			start  => \$resultList[\$i]->getStart,
			end    => \$resultList[\$i]->getEnd,
		);

		\$hash{confidence} = \$resultList[\$i]->getConfidence
		  if \$resultList[\$i]->getConfidence;
		\$hash{hairpin_score} = \$resultList[\$i]->getHairpinScore
		  if \$resultList[\$i]->getHairpinScore;
		\$hash{tail_score} = \$resultList[\$i]->getTailScore
		  if \$resultList[\$i]->getTailScore;
		push \@list, \\\%hash;
	}

	standardStatusOk( \$self, \$c, \\\@list );
}

=head2

Method used to get data of ribosomal binding sites

=cut

sub rbsSearch : Path("/SearchDatabase/rbsSearch") : CaptureArgs(5) :
  ActionClass('REST') {
}

sub rbsSearch_GET {
	my ( \$self, \$c ) = \@_;

	my \%hash = ();
	my \@list = ();

	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}

	my \@resultList = \@{ \$c->model('SearchDatabaseRepository')->rbs_search( \\\%hash ) };

	for ( my \$i = 0 ; \$i < scalar \@resultList ; \$i++ ) {
		my \%hash = (
			contig => \$resultList[\$i]->getContig,
			start  => \$resultList[\$i]->getStart,
			end    => \$resultList[\$i]->getEnd,
		);

		\$hash{site_pattern} = \$resultList[\$i]->getSitePattern
		  if \$resultList[\$i]->getSitePattern;
		\$hash{old_start} = \$resultList[\$i]->getOldStart
		  if \$resultList[\$i]->getOldStart;
		\$hash{position_shift} = \$resultList[\$i]->getPositionShift
		  if \$resultList[\$i]->getPositionShift;
		\$hash{new_start} = \$resultList[\$i]->getNewStart
		  if \$resultList[\$i]->getNewStart;

		push \@list, \\\%hash;
	}

	standardStatusOk( \$self, \$c, \\\@list );
}

=head2

Method used to get data of horizontal gene transfers

=cut

sub alienhunterSearch : Path("/SearchDatabase/alienhunterSearch") :
  CaptureArgs(7) : ActionClass('REST') { }

sub alienhunterSearch_GET {
	my ( \$self, \$c ) = \@_;

	my \%hash = ();
	my \@list = ();

	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}

	my \@resultList = \@{ \$c->model('SearchDatabaseRepository')->alienhunter_search( \\\%hash ) };

	for ( my \$i = 0 ; \$i < scalar \@resultList ; \$i++ ) {
		my \%hash = (
			id     => \$resultList[\$i]->getID,
			contig => \$resultList[\$i]->getContig,
			start  => \$resultList[\$i]->getStart,
			end    => \$resultList[\$i]->getEnd,
		);

		\$hash{length} = \$resultList[\$i]->getLength
		  if \$resultList[\$i]->getLength;
		\$hash{score} = \$resultList[\$i]->getScore
		  if \$resultList[\$i]->getScore;
		\$hash{threshold} = \$resultList[\$i]->getThreshold
		  if \$resultList[\$i]->getThreshold;

		push \@list, \\\%hash;
	}

	standardStatusOk( \$self, \$c, \\\@list );
}

=head2

Method used to get feature by position

=cut

sub geneByPosition : Path("/SearchDatabase/geneByPosition") :
  CaptureArgs(3) : ActionClass('REST') { }

sub geneByPosition_GET {
	my ( \$self, \$c, \$start, \$end, \$pipeline_id ) = \@_;
	if ( !\$start and defined \$c->request->param("start") ) {
		\$start = \$c->request->param("start");
	}
	if ( !\$end and defined \$c->request->param("end") ) {
		\$end = \$c->request->param("end");
	}
	if ( !\$pipeline_id and defined \$c->request->param("pipeline_id") ) {
		\$pipeline_id = \$c->request->param("pipeline_id");
	}
	my \@list = ();

	my \%hash = ();
	\$hash{pipeline} = \$pipeline_id;
	\$hash{start}    = \$start;
	\$hash{end}      = \$end;
	my \@ids = \@{ \$c->model('SearchDatabaseRepository')->geneByPosition( \\\%hash ) };
	my \$featureId = join( " ", \@ids );
	\%hash            = ();
	\$hash{pipeline}  = \$pipeline_id;
	\$hash{featureId} = \$featureId;
	
	my \@resultList = \@{ \$c->model('SearchDatabaseRepository')->searchGene( \\\%hash ) };
	for ( my \$i = 0 ; \$i < scalar \@resultList ; \$i++ ) {
		push \@list, \$resultList[\$i]->pack();
	}

	standardStatusOk( \$self, \$c, \\\@list );
}

sub targetClass : Path("/SearchDatabase/targetClass") : CaptureArgs(1) : ActionClass('REST') { }

sub targetClass_GET {
	my(\$self, \$c, \$pipeline_id) = \@_;
	if ( !\$pipeline_id and defined \$c->request->param("pipeline_id") ) {
		\$pipeline_id = \$c->request->param("pipeline_id");
	}
	standardStatusOk(\$self, \$c, \$c->model('SearchDatabaseRepository')->get_target_class(\$pipeline_id));
}

=head2

Method used to make a default return of every ok request using BaseResponse model

=cut

sub standardStatusOk {
	my ( \$self, \$c, \$response, \$total, \$pageSize, \$offset ) = \@_;
	if (   ( defined \$total || \$total )
		&& ( defined \$pageSize || \$pageSize )
		&& ( defined \$offset   || \$offset ) )
	{
		my \$pagedResponse = \$c->model('PagedResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => \$c->stats->elapsed,
			response    => \$response,
			total       => \$total,
			pageSize    => \$pageSize,
			offset      => \$offset,
		);
		\$self->status_ok( \$c, entity => \$pagedResponse->pack(), );
	}
	else {
		my \$baseResponse = \$c->model('BaseResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => \$c->stats->elapsed,
			response    => \$response
		);
		\$self->status_ok( \$c, entity => \$baseResponse->pack(), );
	}
}

=encoding utf8

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
CONTENT
$temporaryPackage = $html_dir . '::Controller::SearchDatabase';
my $searchDBContent = <<SEARCHDBCONTENT;
package $temporaryPackage;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

$temporaryPackage - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

sub gene : Path("/SearchDatabase/GetGene") : CaptureArgs(7) :
  ActionClass('REST') { }

sub gene_GET {
	my ( 
		\$self,            \$c,             \$pipeline,     \$geneID,
		\$geneDescription, \$noDescription, \$individually, \$featureId,
		\$pageSize,        \$offset )
	  = \@_;
	if ( !\$geneID and defined \$c->request->param("geneID") ) {
		\$geneID = \$c->request->param("geneID");
	}
	if ( !\$geneDescription and defined \$c->request->param("geneDesc") ) {
		\$geneDescription = \$c->request->param("geneDesc");
	}
	if ( !\$noDescription and defined \$c->request->param("noDesc") ) {
		\$noDescription = \$c->request->param("noDesc");
	}
	if ( !\$individually and defined \$c->request->param("individually") ) {
		\$individually = \$c->request->param("individually");
	}
	if ( !\$featureId and defined \$c->request->param("featureId") ) {
		\$featureId = \$c->request->param("featureId");
	}
	if ( !\$pageSize and defined \$c->request->param("pageSize") ) {
		\$pageSize = \$c->request->param("pageSize");
	}
	if ( !\$offset and defined \$c->request->param("offset") ) {
		\$offset = \$c->request->param("offset");
	}
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	my \$pagedResponse = \$searchDBClient->getGene( \$c->config->{pipeline_id},
		\$geneID, \$geneDescription,
		\$noDescription, \$individually, \$featureId, \$pageSize, \$offset );
	standardStatusOk(
		\$self, \$c, \$pagedResponse->{response}, \$pagedResponse->{"total"},
		\$pageSize, \$offset

	);
}

sub gene_basics : Path("/SearchDatabase/GetGeneBasics") : CaptureArgs(1) :
  ActionClass('REST') { }

sub gene_basics_GET {
	my ( \$self, \$c, \$id ) = \@_;
	if ( !\$id and defined \$c->request->param("id") ) {
		\$id = \$c->request->param("id");
	}
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	standardStatusOk(
		\$self, \$c,
		\$searchDBClient->getGeneBasics(
			\$id, \$c->config->{pipeline_id}
		)->{response}
	);
}

sub subsequence : Path("/SearchDatabase/GetSubsequence") : CaptureArgs(5) :
  ActionClass('REST') { }
  
sub subsequence_GET {
	my ( \$self, \$c, \$type, \$contig, \$sequenceName, \$start, \$end ) = \@_;
	if ( !\$contig and defined \$c->request->param("contig") ) {
		\$contig = \$c->request->param("contig");
	}
	if ( !\$type and defined \$c->request->param("type") ) {
		\$type = \$c->request->param("type");
	}
	if ( !\$sequenceName and defined \$c->request->param("sequenceName") ) {
		\$sequenceName = \$c->request->param("sequenceName");
	}
	if ( !\$start and defined \$c->request->param("start") ) {
		\$start = \$c->request->param("start");
	}
	if ( !\$end and defined \$c->request->param("end") ) {
		\$end = \$c->request->param("end");
	}
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	standardStatusOk(
		\$self, \$c,
		\$searchDBClient->getSubsequence(
			\$type, \$contig, \$sequenceName, \$start, \$end, \$c->config->{pipeline_id}
		)->{response}
	);
}

sub ncRNA_desc : Path("/SearchDatabase/ncRNA_desc") : CaptureArgs(1) :
  ActionClass('REST') { }
  
sub ncRNA_desc_GET {
	my ( \$self, \$c, \$feature ) = \@_;
	if ( !\$feature and defined \$c->request->param("feature") ) {
		\$feature = \$c->request->param("feature");
	}
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	standardStatusOk(
		\$self, \$c,
		\$searchDBClient->getncRNA_desc(
			\$feature, \$c->config->{pipeline_id}
		)->{response}
	); 
}

sub subEvidences : Path("/SearchDatabase/SubEvidences") : CaptureArgs(1) :
  ActionClass('REST') { }

sub subEvidences_GET {
	my ( \$self, \$c, \$feature) = \@_;
	if ( !\$feature and defined \$c->request->param("feature") ) {
		\$feature = \$c->request->param("feature");
	}
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	standardStatusOk(
		\$self, \$c,
		\$searchDBClient->getSubevidences(
			\$feature, \$c->config->{pipeline_id}
		)->{response}
	);
}

sub analysesCDS : Path("/SearchDatabase/analysesCDS") : CaptureArgs(31) :
  ActionClass('REST') { }

sub analysesCDS_GET {
	my ( \$self, \$c) = \@_;
	my \%hash = ();
	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}
	\$hash{pipeline} = \$c->config->{pipeline_id};
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	my \$pagedResponse = \$searchDBClient->getAnalysesCDS( \\\%hash );
	standardStatusOk(
		\$self, \$c,
		\$pagedResponse->{response},
		\$pagedResponse->{total},
		\$hash{pageSize}, \$hash{offset}
	);
}

sub trnaSearch : Path("/SearchDatabase/trnaSearch") : CaptureArgs(4) :
  ActionClass('REST') { }

sub trnaSearch_GET {
	my ( \$self, \$c ) = \@_;

	my \%hash = ();
	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}
	\$hash{pipeline} = \$c->config->{pipeline_id};
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	my \$response = \$searchDBClient->getTRNA( \\\%hash );
	standardStatusOk(
		\$self, \$c, \$response->{response}, \$response->{total}, \$hash{pageSize},
		\$hash{offset}
	);
}

sub tandemRepeatsSearch : Path("/SearchDatabase/tandemRepeatsSearch") :
  CaptureArgs(5) : ActionClass('REST') { }

sub tandemRepeatsSearch_GET {
	my ( \$self, \$c ) = \@_;

	my \%hash = ();
	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}
	\$hash{pipeline} = \$c->config->{pipeline_id};
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	standardStatusOk(
		\$self, \$c,
		\$searchDBClient->getTandemRepeats(
			\\\%hash
		)->{response}
	);
}

sub ncRNASearch : Path("/SearchDatabase/ncRNASearch") : CaptureArgs(7) :
  ActionClass('REST') { }

sub ncRNASearch_GET {
	my ( \$self, \$c ) = \@_;
	my \%hash = ();
	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}
	\$hash{pipeline} = \$c->config->{pipeline_id};
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	standardStatusOk(
		\$self, \$c,
		\$searchDBClient->getncRNA(
			\\\%hash
		)->{response}
	);
}

sub transcriptionalTerminatorSearch :
  Path("/SearchDatabase/transcriptionalTerminatorSearch") : CaptureArgs(6) :
  ActionClass('REST') { }

sub transcriptionalTerminatorSearch_GET {
	my ( \$self, \$c ) = \@_;
	my \%hash = ();
	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}
	\$hash{pipeline} = \$c->config->{pipeline_id};
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	standardStatusOk(
		\$self, \$c,
		\$searchDBClient->getTranscriptionalTerminator(
			\\\%hash
		)->{response}
	);
}

sub rbsSearch : Path("/SearchDatabase/rbsSearch") : CaptureArgs(4) :
  ActionClass('REST') {
}

sub rbsSearch_GET {
	my ( \$self, \$c ) = \@_;
	my \%hash = ();
	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}
	\$hash{pipeline} = \$c->config->{pipeline_id};
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	standardStatusOk(
		\$self, \$c,
		\$searchDBClient->getRBSSearch(
			\\\%hash
		)->{response}
	);
}

sub alienhunterSearch : Path("/SearchDatabase/alienhunterSearch") :
  CaptureArgs(6) : ActionClass('REST') { }

sub alienhunterSearch_GET {
	my ( \$self, \$c ) = \@_;
	my \%hash = ();
	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}
	\$hash{pipeline} = \$c->config->{pipeline_id};
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	standardStatusOk(
		\$self, \$c,
		\$searchDBClient->getAlienHunter(
			\\\%hash
		)->{response}
	);
}

sub geneByPosition : Path("/SearchDatabase/geneByPosition") :
  CaptureArgs(3) : ActionClass('REST') { }

sub geneByPosition_GET {
	my ( \$self, \$c, \$start, \$end ) = \@_;
	if ( !\$start and defined \$c->request->param("start") ) {
		\$start = \$c->request->param("start");
	}
	if ( !\$end and defined \$c->request->param("end") ) {
		\$end = \$c->request->param("end");
	}
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	standardStatusOk(
		\$self, \$c,
		\$searchDBClient->getGeneByPosition(
			\$start, \$end, \$c->config->{pipeline_id}
		)->{response}
	);
}

sub getSimilarityEvidenceProperties :
  Path("/SearchDatabase/getSimilarityEvidenceProperties") : CaptureArgs(1) :
  ActionClass('REST') { }

sub getSimilarityEvidenceProperties_GET {
	my ( \$self, \$c, \$feature ) = \@_;
	if ( !\$feature and defined \$c->request->param("feature") ) {
		\$feature = \$c->request->param("feature");
	}
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	
	my \%hash = \%{\$searchDBClient->getSimilarityEvidenceProperties(\$feature)->{response}};
	my \%returnedHash = \%{\$searchDBClient->getIdentifierAndDescriptionSimilarity(\$feature)->{response}};
	foreach my \$key (keys \%returnedHash) {
		\$hash{\$key} = \$returnedHash{\$key};
	}
	standardStatusOk( \$self, \$c, \\\%hash );
}

sub getIntervalEvidenceProperties :
  Path("/SearchDatabase/getIntervalEvidenceProperties") : CaptureArgs(3) :
  ActionClass('REST') { }

sub getIntervalEvidenceProperties_GET {
	my ( \$self, \$c, \$feature, \$typeFeature, \$pipeline ) = \@_;
	if ( !\$feature and defined \$c->request->param("feature") ) {
		\$feature = \$c->request->param("feature");
	}
	if ( !\$typeFeature and defined \$c->request->param("typeFeature") ) {
		\$typeFeature = \$c->request->param("typeFeature");
	}
	if ( !\$pipeline and defined \$c->request->param("pipeline") ) {
		\$pipeline = \$c->request->param("pipeline");
	}
	my \$searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	standardStatusOk( \$self, \$c,
		\$searchDBClient->getIntervalEvidenceProperties(\$feature, \$typeFeature, \$pipeline)->{response} );
}

=head2
Standard return of status ok
=cut

sub standardStatusOk {
	my ( \$self, \$c, \$response, \$total, \$pageSize, \$offset ) = \@_;
	if (   ( defined \$total || \$total )
		&& ( defined \$pageSize || \$pageSize )
		&& ( defined \$offset   || \$offset ) )
	{
		my \$pagedResponse = \$c->model('PagedResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => \$c->stats->elapsed,
			response    => \$response,
			total       => \$total,
			pageSize    => \$pageSize,
			offset      => \$offset,
		);
		\$self->status_ok( \$c, entity => \$pagedResponse->pack(), );
	}
	else {
		my \$baseResponse = \$c->model('BaseResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => \$c->stats->elapsed,
			response    => \$response
		);
		\$self->status_ok( \$c, entity => \$baseResponse->pack(), );
	}
}

=encoding utf8

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

SEARCHDBCONTENT
writeFile( "$html_dir/lib/$html_dir/Controller/SearchDatabase.pm",
	$searchDBContent );
	
$temporaryPackage = $html_dir . '::Controller::Blast';
my $blastContent = <<BLAST;
package website::Controller::Blast;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

website::Controller::SearchDatabase - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

sub search : Path("/Blast/search") : CaptureArgs(7) : ActionClass('REST') { }

sub search_POST {
	my (
		\$self,                \$c,                  \$blast,
		\$database,            \$fastaSequence,      \$from,
		\$to,                  \$filter,             \$expect,
		\$matrix,              \$ungappedAlignment,  \$geneticCode,
		\$databaseGeneticCode, \$frameShiftPenality, \$otherAdvanced,
		\$graphicalOverview,   \$alignmentView,      \$descriptions,
		\$alignments,          \$colorSchema,        \$fastaFile
	) = \@_;
	if ( !\$blast and defined \$c->request->param("PROGRAM") ) {
		\$blast = \$c->request->param("PROGRAM");
	}
	if ( !\$database and defined \$c->request->param("DATALIB") ) {
		\$database = \$c->request->param("DATALIB");
	}
	if ( !\$fastaSequence and defined \$c->request->param("SEQUENCE") ) {
		\$fastaSequence = \$c->request->param("SEQUENCE");
	}
	if ( !\$fastaFile and defined \$c->request->param("SEQFILE") ) {
		\$fastaFile = \$c->request->param("SEQFILE");
	}
	if ( !\$from and defined \$c->request->param("QUERY_FROM") ) {
		\$from = \$c->request->param("QUERY_FROM");
	}
	if ( !\$to and defined \$c->request->param("QUERY_TO") ) {
		\$to = \$c->request->param("QUERY_TO");
	}
	if ( !\$filter and defined \$c->request->param("FILTER") ) {
		\$filter = \$c->request->param("FILTER");
	}
	if ( !\$expect and defined \$c->request->param("EXPECT") ) {
		\$expect = \$c->request->param("EXPECT");
	}
	if ( !\$matrix and defined \$c->request->param("MAT_PARAM") ) {
		\$matrix = \$c->request->param("MAT_PARAM");
	}
	if ( !\$ungappedAlignment
		and defined \$c->request->param("UNGAPPED_ALIGNMENT") )
	{
		\$ungappedAlignment = \$c->request->param("UNGAPPED_ALIGNMENT");
	}
	if ( !\$geneticCode and defined \$c->request->param("GENETIC_CODE") ) {
		\$geneticCode = \$c->request->param("GENETIC_CODE");
	}
	if ( !\$databaseGeneticCode
		and defined \$c->request->param("DB_GENETIC_CODE") )
	{
		\$databaseGeneticCode = \$c->request->param("DB_GENETIC_CODE");
	}
	if ( !\$frameShiftPenality
		and defined \$c->request->param("OOF_ALIGN") )
	{
		\$frameShiftPenality = \$c->request->param("OOF_ALIGN");
	}
	if ( !\$otherAdvanced and defined \$c->request->param("OTHER_ADVANCED") ) {
		\$otherAdvanced = \$c->request->param("OTHER_ADVANCED");
	}
	if ( !\$graphicalOverview
		and defined \$c->request->param("OVERVIEW") )
	{
		\$graphicalOverview = \$c->request->param("OVERVIEW");
	}
	if ( !\$alignmentView and defined \$c->request->param("ALIGNMENT_VIEW") ) {
		\$alignmentView = \$c->request->param("ALIGNMENT_VIEW");
	}
	if ( !\$descriptions and defined \$c->request->param("DESCRIPTIONS") ) {
		\$descriptions = \$c->request->param("DESCRIPTIONS");
	}
	if ( !\$alignments and defined \$c->request->param("ALIGNMENTS") ) {
		\$alignments = \$c->request->param("ALIGNMENTS");
	}
	if ( !\$colorSchema and defined \$c->request->param("COLOR_SCHEMA") ) {
		\$colorSchema = \$c->request->param("COLOR_SCHEMA");
	}

	my \%hash = ();

	foreach my \$key ( keys \%{ \$c->request->params } ) {
		if ( \$key && \$key ne "0" ) {
			\$hash{\$key} = \$c->request->params->{\$key};
		}
	}
	
	unless ( exists \$hash{SEQUENCE} ) {
		\$hash{SEQUENCE} = \$hash{SEQFILE};
		delete \$hash{SEQFILE};
	}
	my \$content = "";
	my \@fuckingSequence = split(/\\s+/, \$hash{SEQUENCE});
	 \$hash{SEQUENCE} = join('\\n', \@fuckingSequence);
	print "\\n".\$hash{SEQUENCE}."\\n";

	my \$blastClient =
	  Report_HTML_DB::Clients::BlastClient->new(
		rest_endpoint => \$c->config->{rest_endpoint} );
	my \$baseResponse = \$blastClient->search( \\\%hash );
	\%hash = ();
	\$baseResponse = \$blastClient->fancy( \$baseResponse->{response} );
	my \$returnedHash = \$baseResponse->{response};
	use MIME::Base64;
	foreach my \$key (keys \%\$returnedHash) {
		if(\$key =~ /\.html/ ) {
			\$hash{\$key} = MIME::Base64::decode_base64(\$returnedHash->{\$key});
		} else {
			\$hash{\$key} = \$returnedHash->{\$key};
		}
	}
	
	standardStatusOk(\$self, \$c, \\\%hash);
}

=head2
Standard return of status ok
=cut

sub standardStatusOk {
	my ( \$self, \$c, \$response, \$total, \$pageSize, \$offset ) = \@_;
	if (   ( defined \$total || \$total )
		&& ( defined \$pageSize || \$pageSize )
		&& ( defined \$offset   || \$offset ) )
	{
		my \$pagedResponse = \$c->model('PagedResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => \$c->stats->elapsed,
			response    => \$response,
			total       => \$total,
			pageSize    => \$pageSize,
			offset      => \$offset,
		);
		\$self->status_ok( \$c, entity => \$pagedResponse->pack(), );
	}
	else {
		my \$baseResponse = \$c->model('BaseResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => \$c->stats->elapsed,
			response    => \$response
		);
		\$self->status_ok( \$c, entity => \$baseResponse->pack(), );
	}
}

=encoding utf8

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

BLAST

writeFile( "$html_dir/lib/$html_dir/Controller/Blast.pm",
	$blastContent );

$temporaryPackage = $html_dir . '::Controller::Root';
my $rootContent = <<ROOT;
package $temporaryPackage;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

$temporaryPackage - Root Controller for $html_dir

=head1 DESCRIPTION

Root where will have the main pages

=head1 METHODS

=cut 
my \$feature_id;
ROOT

#my @controllers = (
#	"Home", "Blast", "Downloads", "Help", "About"
#);
if ($hadGlobal) {
	$rootContent .= <<ROOT;

=head2 globalAnalyses

Global analyses page

=cut

sub globalAnalyses :Path("GlobalAnalyses") :Args(0) {
	my ( \$self, \$c ) = \@_;
	\$c->stash->{titlePage} = 'Global Analyses';
	\$c->stash(currentPage => 'global-analyses');
	\$c->stash(texts => [encodingCorrection (\$c->model('Basic::Text')->search({
		-or => [
			tag => {'like', 'header%'},
			tag => 'menu',
			tag => 'footer',
			tag => {'like', 'global-analyses%'}
		]
	}))]);
	
	\$c->stash(template => '$lowCaseName/global-analyses/index.tt');
	\$c->stash(components => [\$c->model('Basic::Component')->all]);
	\$c->stash->{hadGlobal} = 1;
	\$c->stash->{hadSearchDatabase} = {{valorSearchSubtituir}};
	

}

ROOT

	#	push @controllers, "GlobalAnalyses";
}
if ($hadSearchDatabase) {
	$rootContent .= <<ROOT;
	
=head2 searchDatabase

Search database page (/SearchDatabase)

=cut
sub searchDatabase :Path("SearchDatabase") :Args(0) {
	my ( \$self, \$c ) = \@_;
	\$c->stash->{titlePage} = 'Search Database';
	\$c->stash(currentPage => 'search-database');
	\$c->stash(texts => [encodingCorrection (\$c->model('Basic::Text')->search({
				-or => [
					tag => {'like', 'header%'},
					tag => 'menu',
					tag => 'footer',
					tag => {'like', 'search-database%'}
				]
	}))]);
	my \$searchDBClient = Report_HTML_DB::Clients::SearchDBClient->new(rest_endpoint => \$c->config->{rest_endpoint});
	\$feature_id = \$searchDBClient->getFeatureID(\$c->config->{uniquename})->getResponse();
	\$c->stash(
		targetClass => \$searchDBClient->getTargetClass(\$c->config->{pipeline_id})->getResponse()  
	);
	
	\$c->stash(
		sequences => [
			\$c->model('Basic::Sequence')->all
		]
	);
	
	\$c->stash(template => '$lowCaseName/search-database/index.tt');
	\$c->stash(components => [\$c->model('Basic::Component')->all]);
	\$c->stash->{hadGlobal} = {{valorGlobalSubstituir}};
	\$c->stash->{hadSearchDatabase} = 1;

}

ROOT

	#	push @controllers, "SearchDatabase";
}

$rootContent .= <<ROOT;

=head2 about

About page (/About)

=cut

sub about : Path("About") : Args(0) {
	my ( \$self, \$c ) = \@_;
	\$c->stash->{titlePage} = 'About';
	\$c->stash( currentPage => 'about' );
	\$c->stash(
		texts => [
			encodingCorrection(
				\$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header\%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'about\%' }
						]
					}
				)
			)
		]
	);
	\$c->stash( template => '$lowCaseName/about/index.tt' );
	\$c->stash->{hadGlobal}         = {{valorGlobalSubstituir}};
	\$c->stash->{hadSearchDatabase} = {{valorSearchSubtituir}};

}

=head2 blast

The blast page (/Blast)

=cut

sub blast : Path("Blast") : Args(0) {
	my ( \$self, \$c ) = \@_;
	\$c->stash->{titlePage} = 'Blast';
	\$c->stash( currentPage => 'blast' );
	\$c->stash(
		texts => [
			encodingCorrection(
				\$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header\%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'blast\%' }
						]
					}
				)
			)
		]
	);
	
	\$c->stash( template => '$lowCaseName/blast/index.tt' );
	\$c->stash->{hadGlobal}         = {{valorGlobalSubstituir}};
	\$c->stash->{hadSearchDatabase} = {{valorSearchSubtituir}};

}

=head2 downloads

The download page (/Downloads)

=cut

sub downloads : Path("Downloads") : Args(0) {
	my ( \$self, \$c ) = \@_;
	\$c->stash->{titlePage} = 'Downloads';
	\$c->stash( currentPage => 'downloads' );
	\$c->stash(
		texts => [
			encodingCorrection(
				\$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header\%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'downloads\%' }
						]
					}
				)
			)
		]
	);
	
	\$c->stash( template => '$lowCaseName/downloads/index.tt' );
	\$c->stash->{hadGlobal}         = {{valorGlobalSubstituir}};
	\$c->stash->{hadSearchDatabase} = {{valorSearchSubtituir}};

}

=head2 encodingCorrection

Method used to correct encoding strings come from SQLite

=cut

sub encodingCorrection {
	my (\@texts) = \@_;

	use utf8;
	use Encode qw( decode encode );
	foreach my \$text (\@texts) {
		foreach my \$key ( keys \%\$text ) {
			if ( \$text->{\$key} != 1 ) {
				my \$string = decode( 'utf-8', \$text->{\$key}{value} );
				\$string = encode( 'iso-8859-1', \$string );
				\$text->{\$key}{value} = \$string;
			}
		}
	}
	return \@texts;
}

=head2

Method used to get feature id

=cut

#sub get_feature_id {
#	my (\$c) = \@_;
#	return \$c->model('SearchDatabaseRepository')->get_feature_id(\$c->config->{uniquename});
#}

=head2 help

The help page (/Help)

=cut

sub help : Path("Help") : Args(0) {
	my ( \$self, \$c ) = \@_;
	\$c->stash->{titlePage} = 'Help';
	\$c->stash( currentPage => 'help' );
	\$c->stash(
		texts => [
			encodingCorrection(
				\$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header\%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'help\%' }
						]
					}
				)
			)
		]
	);
	#if ( !defined \$feature_id ) {
	#	\$feature_id = get_feature_id(\$c);
	#}
	#\$c->stash( teste    => \$feature_id );
	\$c->stash( template => '$lowCaseName/help/index.tt' );
	\$c->stash->{hadGlobal}         = {{valorGlobalSubstituir}};
	\$c->stash->{hadSearchDatabase} = {{valorSearchSubtituir}};

}

=head2 index

The root page (/)

=cut

sub index : Path : Args(0) {
	my ( \$self, \$c ) = \@_;
	\$c->stash->{titlePage} = 'Home';
	\$c->stash( currentPage => 'home' );
	\$c->stash(
		texts => [
			encodingCorrection(
				\$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header\%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'home\%' }
						]
					}
				)
			)
		]
	);
	#if ( !defined \$feature_id ) {
	#	\$feature_id = get_feature_id(\$c);
	#}
	\$c->stash( template => '$lowCaseName/home/index.tt' );
	\$c->stash->{hadGlobal}         = {{valorGlobalSubstituir}};
	\$c->stash->{hadSearchDatabase} = {{valorSearchSubtituir}};

}

sub downloadFile : Path("DownloadFile") : CaptureArgs(1) {
	my ( \$self, \$c, \$type ) = \@_;
	if ( !\$type and defined \$c->request->param("type") ) {
		\$type = \$c->request->param("type");
	}
	my \$filepath = (
		\$c->model('Basic::File')->search(
			{
				tag => "\$type"
			},
			{
				columns => qw/filepath/,
				rows    => 1
			}
		)->single->get_column(qw/filepath/)
	);

	open( my \$FILEHANDLER, "<", \$filepath );
	binmode \$FILEHANDLER;
	my \$file;

	local \$/ = \\10240;
	while (<\$FILEHANDLER>) {
		\$file .= \$_;
	}
	\$c->response->body(\$file);
	\$c->response->headers->content_type('application/x-download');
	my \$filename = "";
	if(\$filepath =~ /\\/([\\w\\s\\-_]+\\.[\\w\\s\\-_]+)/g) {
		\$filename = \$1;
	}
	\$c->response->body(\$file);
	\$c->response->header('Content-Disposition' => 'attachment; filename='.\$filename);
	close \$FILEHANDLER;
}

sub reports : Path("reports") : CaptureArgs(3) {
	my ( \$self, \$c, \$type, \$file, \$file2 ) = \@_;
	my \$filepath = "\$type/\$file";
	\$filepath .= "/\$file2" if \$file2;
	
	\$self->status_bad_request( \$c, message => "Invalid request" )
	  if ( \$filepath =~ m/\\.\\.\\// );
	
	use File::Basename;
	open( my \$FILEHANDLER,
		"<", dirname(__FILE__) . "/../../../root/" . \$filepath );
	my \$content = "";
	while ( my \$line = <\$FILEHANDLER> ) {
		\$line =~ s/href="/href="\\/reports\\/\$type\\//
		  if ( \$line =~ /href="/ && \$line !~ /href="http\\:\\/\\// );
		\$content .= \$line . "\\n";
	}
	close(\$FILEHANDLER);
	\$content =~ s/src="/src="\\/\$type\\//igm;
	\$content =~ s/HREF="/HREF="\\/\$type\\//g;
	\$c->response->body(\$content);
}

=head2 default


Standard 404 error page

=cut

sub default : Path {
	my ( \$self, \$c ) = \@_;
	\$c->response->body('Page not found');
	\$c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') { }

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;


ROOT

if ( $rootContent =~ /\{\{valorGlobalSubstituir\}\}/g && $hadGlobal ) {
	$rootContent =~ s/\{\{valorGlobalSubstituir\}\}/1/g;
}
else {
	$rootContent =~ s/\{\{valorGlobalSubstituir\}\}/0/g;
}

if ( $rootContent =~ /\{\{valorSearchSubtituir\}\}/g && $hadSearchDatabase ) {
	$rootContent =~ s/\{\{valorSearchSubtituir\}\}/1/g;
}
else {
	$rootContent =~ s/\{\{valorSearchSubtituir\}\}/0/g;
}

foreach my $filepathComponent (@filepathsComponents) {
	if ($filepathComponent) {
		print $LOG "\nFilepath component:\t" . $filepathComponent . "\n";
		if ( $filepathComponent =~ /([\.\/\w]+)\//g ) {
			print $LOG "\nDir:\t" . $1 . "\n";
			`mkdir -p $standard_dir/$html_dir/root/`
			  if !-e "$standard_dir/$html_dir/root/";
			if ( $1 ne '_dir' ) {
				my $directory = $1;
				if ( $1 !~ m/report/g ) {
`ln -s $filepath/$standard_dir/$directory $standard_dir/$html_dir/root/` if !-e "$standard_dir/$html_dir/root/$directory";
				}
				else {
					`ln -s $directory $standard_dir/$html_dir/root/` if !-e "$standard_dir/$html_dir/root/$directory";
				}
			}
		}
	}
}

#Descompacta assets
print $LOG "Copying files assets\n";
`tar -zxf assets.tar.gz`;
`mkdir -p $html_dir/root/` if ( !-e "$html_dir/root/" );
`cp -r assets $html_dir/root/`;
`rm -Rf assets`;

if ($banner) {
	`cp $banner $html_dir/root/assets/img/logo.png`;
}

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
                                <a data-toggle="collapse" data-parent="#accordion" href="#about_[% counter %]" class="collapsed">[% text.value %]</a>
                            </h4>
                        </div>
                        <div id="about_[% counter %]" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="notice-board">
                                    [% counterTexts = 0 %]
                                    [% FOREACH content IN texts %]
                                        [% IF content.tag.search("about_" _ counter _"-"_ counterTexts) %]
                                            [% IF content.tag == "about_" _ counter _"-"_ counterTexts _"-title" %]
                                                <h1 id="[% content.details %]" class="page-head-line">[% content.value %]</h1>
                                            [% END %]
                                            [% IF content.tag == "about_" _ counter _"-"_ counterTexts _"-paragraph" %]
                                                <p>[% content.value %]</p>
                                            [% END %]
                                            [% IF content.tag.search("about_" _ counter _"-"_ counterTexts _"-list-") %]
                                                <ul>
                                                    [% FOREACH item IN texts %]
                                                        [% IF item.tag.search("about_" _ counter _"-"_ counterTexts _"-list-") %]
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
        <form id="formBlast">
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
                        <textarea class="form-control" name="SEQUENCE" id="SEQUENCE" rows="6" cols="60"></textarea>
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
    <div id="containerBlast" class="container">	
    	<div class="row">
    		<div class="col-md-12">
    			<input type="button" id="back" value="Back" class="btn btn-danger btn-lg" />
    		</div>
    	</div>
        [% INCLUDE 'website/blast/_forms.tt' %]
    </div>
</div>
<script type="text/javascript" src="/assets/js/fileHandler.js"></script>
<script type="text/javascript" src="/assets/js/site-client.js"></script>
<script type="text/javascript" src="/assets/js/blast.js"></script>
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
                                    [% IF text.tag.search('downloads-genes-links-') %]
                                        <li>[% text.value %]</li>
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
                                    [% IF text.tag.search('downloads-other-sequences-links-') %]
                                        <li>[% text.value %]</li>
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
				[% IF component.component.match("report_go") %]
					[% go_mapping = 1 %]
				[% END %]
				[% IF component.component.match("report_eggnog") %]
					[% orthology = 1 %]
				[% END %]
				[% IF component.component.match("report_pathways") %]
					[% pathways = 1 %]
				[% END %]
				[% IF component.component.match("report_kegg_organism") %]
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
	                                    <label>[% text.value %]</label>
	                                [% END %]
	                            [% END %]
	                        </div>
	                        <div class="form-group">
	                            [% FOREACH text IN texts %]
	                                [% IF text.tag == 'global-analyses-table-ontologies' %]
	                                    <label>[% text.value %]</label>
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
	                                    <label>[% text.value %]</label>
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
	                                    <label>[% text.value %]</label>
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
	                                    <label>[% text.value %]</label>
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
<script type="text/javascript" src="/assets/js/site-client.js"></script>
<script type="text/javascript" src="/assets/js/search-database.js"></script>
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
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default" id="searchPanel">
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
                		[% IF component.component.match('annotation_rbsfinder.pl') %]
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
                                         <form id="formGeneIdentifier">
                                             <div class="form-group">
                                                 [% FOREACH text IN texts %]
                                                     [% IF text.tag.search('search-database-gene-ids-descriptions-gene-id') %]
                                                         <label>[% text.value %]</label>
                                                     [% END %]
                                                 [% END %]
                                                 <input class="form-control" type="text" name="geneID">
                                             </div>
                                             <input class="btn btn-primary btn-sm" type="submit" value="Search">  
                                             <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="this.form.reset();">
                                         </form>
                                     </div>
                                     [% IF blast %]
                                      <div id="geneDescription" class="tab-pane fade">
                                          <h4></h4>
                                          <form id="formGeneDescription">
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
                                              <div class="form-group">
                                              	[% FOREACH text IN texts %]
                                                      [% IF text.tag.search('search-database-gene-ids-descriptions-gene-match-all') %]
                                                      	<div class="checkbox">
                                                          	<label><input type="checkbox" name="individually">[% text.value %]</label>
                                                          </div>
                                                      [% END %]
                                                  [% END %]
                                              </div>
                                              <input class="btn btn-primary btn-sm" type="submit" name="geneIDbutton" value="Search"> 
                                              <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="this.form.reset();">
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
                                 <form id="formAnalysesProteinCodingGenes">
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
                                     	[% values = [];%]
                                         [% FOREACH text IN texts %]
                                             [% IF text.tag.search('search-database-analyses-protein-code-tab') AND !(values.grep(text.value).size) %]
                                             	[% values.push(text.value); %]
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
                                                              [% LAST %]
                                                          [% END %]
                                                      [% END %]
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  [% FOREACH text IN texts %]
                                                      [% IF text.tag.search('search-database-analyses-protein-code-search-by-sequence') %]
                                                          <label>[% text.value %]</label>
                                                          [% LAST %]
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
                                                              [% LAST %]
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
                                                  <input class="form-control" type="number" name="TMdom">
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
                                                              [% LAST %]
                                                          [% END %]
                                                      [% END %]
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  [% FOREACH text IN texts %]
                                                      [% IF text.tag.search('search-database-analyses-protein-code-search-by-sequence') %]
                                                          <label>[% text.value %]</label>
                                                          [% LAST %]
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
                                                              [% LAST %]
                                                          [% END %]
                                                      [% END %]
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  [% FOREACH text IN texts %]
                                                      [% IF text.tag.search('search-database-analyses-protein-code-search-by-sequence') %]
                                                          <label>[% text.value %]</label>
                                                          [% LAST %]
                                                      [% END %]
                                                  [% END %]
                                                  <input class="form-control" type="text" name="rpsID">
                                              </div>
                                              <div class="form-group">
                                                  [% FOREACH text IN texts %]
                                                      [% IF text.tag.search('search-database-analyses-protein-code-search-by-description') %]
                                                          <label>[% text.value %]</label>
                                                          [% LAST %]
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
                                                              [% LAST %]
                                                          [% END %]
                                                      [% END %]
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  [% FOREACH text IN texts %]
                                                      [% IF text.tag.search('search-database-analyses-protein-code-by-orthology-identifier-kegg') %]
                                                          <label>[% text.value %]</label>
                                                          [% LAST %]
                                                      [% END %]
                                                  [% END %]
                                                  <input class="form-control" type="text" name="koID">
                                              </div>
                                              <div class="form-group">
                                                  [% FOREACH text IN texts %]
                                                      [% IF text.tag == 'search-database-analyses-protein-code-by-kegg-pathway' %]
                                                          <label>[% text.value %]</label>
                                                          [% LAST %]
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
                                                          [% LAST %]
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
                                                              [% LAST %]
                                                          [% END %]
                                                      [% END %]
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  [% FOREACH text IN texts %]
                                                      [% IF text.tag.search('search-database-analyses-protein-code-eggNOG') %]
                                                          <label>[% text.value %]</label>
                                                          [% LAST %]
                                                      [% END %]
                                                  [% END %]
                                                  <input class="form-control" type="text" name="orthID">
                                              </div>
                                              <div class="form-group">
                                                  [% FOREACH text IN texts %]
                                                      [% IF text.tag.search('search-database-analyses-protein-code-search-by-description') %]
                                                          <label>[% text.value %]</label>
                                                          [% LAST %]
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
                                                              [% LAST %]
                                                          [% END %]
                                                      [% END %]
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  [% FOREACH text IN texts %]
                                                      [% IF text.tag.search('search-database-analyses-protein-code-interpro') %]
                                                          <label>[% text.value %]</label>
                                                          [% LAST %]
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
                                     <input class="btn btn-default btn-sm" type="button" name="clear" value="Clear Form" onclick="this.form.reset();">
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
				<form id="formSearchContig">
					<div class="form-group">
						[% FOREACH text IN texts %]
							[% IF text.tag == 'search-database-dna-based-analyses-only-contig-title' %]
								<label>[% text.value %]</label>
							[% END %]
						[% END %]
						<select class="form-control"  name="contig" required="required">
							<option value=""></option>
							[% FOREACH sequence IN sequences %]
								<option value="[% sequence.id %]">[% sequence.name %]</option>
							[% END %]
						</select>
					</div>
					<div class="form-group">
						[% FOREACH text IN texts %]
							[% IF text.tag == 'search-database-dna-based-analyses-from-base' %]
								<label>[% text.value %]</label>
							[% END %]
						[% END %]
						<input class="form-control" type="number" min="1" name="contigStart">
					</div>
					<div class="form-group">
						[% FOREACH text IN texts %]
							[% IF text.tag == 'search-database-dna-based-analyses-to' %]
								<label>[% text.value %]</label>
							[% END %]
						[% END %]
						<input class="form-control" type="number" min="1" name="contigEnd">
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
					<input class="btn btn-primary btn-sm" type="submit" value="Search"> 
					<input class="btn btn-default btn-sm" type="button" value="Clear Form" onclick="this.form.reset();">
				</form>
			</div>
			[% IF trna %]
			
				<div id="trna" class="tab-pane fade">
					<form id="trna-form">
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
						<input class="btn btn-primary btn-sm" type="submit"  value="Search"> 
						<input class="btn btn-default btn-sm" type="button" value="Clear Form" onclick="this.form.reset();">
					</form>
				</div>
			
			[% END %]
			[% IF trf OR mreps OR string %]
			<div id="tandemRepeats" class="tab-pane fade">
				<form id="tandemRepeats-form">
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
						<input class="form-control" type="number" name="TRFrepSize">
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
						<input class="form-control" type="number" step="any" min="0" name="TRFrepNumMin">
						[% FOREACH text IN texts %]
						[% IF text.tag == 'search-database-dna-based-analyses-occours-between-and' %]
						<label>[% text.value %]</label>
						[% END %]
						[% END %]
						<input class="form-control" type="number" step="any" name="TRFrepNumMax">
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
					<input class="btn btn-primary btn-sm" type="submit"  value="Search"> 
					<input class="btn btn-default btn-sm" type="button"  value="Clear Form" onclick="this.form.reset();">
				</form>
			</div>
			[% END %]
			[% IF infernal %]
			<div id="otherNonCodingRNAs" class="tab-pane fade">
				<form id="otherNonCodingRNAs-form">
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
						<input class="form-control" type="number" step="any" name="ncRNAevalue">
						[% FOREACH text IN texts %]
						[% IF text.tag.search('search-database-analyses-protein-code-number-transmembrane-domain-quantity') %]
						<div class="radio">
							<label><input type="radio" name="ncRNAevM" [% text.details %]>[% text.value %]</label>
						</div>
						[% END %]
						[% END %]
					</div>
					<div class="form-group">
						[% FOREACH text IN texts %]
						[% IF text.tag == 'search-database-dna-based-analyses-or-by-target-name' %]
						<label>[% text.value %]</label>
						[% END %]
						[% END %]
						<input class="form-control" type="text" name="ncRNAtargetName">
					</div>
					[% IF targetClass.size > 0 %]
					<div class="form-group">
						[% FOREACH text IN texts %]
						[% IF text.tag == 'search-database-dna-based-analyses-or-by-target-class' %]
						<label>[% text.value %]</label>
						[% END %]
						[% END %]
						<select class="form-control"  name="ncRNAtargetClass">
							<option value=""></option>
							[% FOREACH text IN targetClass %]
							<option value="[% text.value %]">[% text.value %]</option>
							[% END %]
						</select>
					</div>
					[% END %]
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
					<input class="btn btn-primary btn-sm" type="submit"  value="Search"> 
					<input class="btn btn-default btn-sm" type="button"  value="Clear Form" onclick="this.form.reset();">
				</form>
			</div>
			[% END %]
			[% IF rbs %]
			<div id="ribosomalBindingSites" class="tab-pane fade">
				<form id="ribosomalBindingSites-form">
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
					<input class="btn btn-primary btn-sm" type="submit"  value="Search"> 
					<input class="btn btn-default btn-sm" type="button"  value="Clear Form" onclick="this.form.reset();">
				</form>
			</div>
			[% END %]
			[% IF transterm %]
			<div id="transcriptionalTerminators" class="tab-pane fade">
				<form id="transcriptionalTerminators-form">
					<div class="form-group">
						[% FOREACH text IN texts %]
						[% IF text.tag == 'search-database-dna-based-analyses-transcriptional-terminators-confidence-score' %]
						<label>[% text.value %]</label>
						[% END %]
						[% END %]
						<input class="form-control" type="number" step="any" name="TTconf">
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
						<input class="form-control" type="number" step="any" name="TThp">
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
						<input class="form-control" type="number" step="any" name="TTtail">
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
					<input class="btn btn-primary btn-sm" type="submit"  value="Search"> 
					<input class="btn btn-default btn-sm" type="button"  value="Clear Form" onclick="this.form.reset();">
				</form>
			</div>
			[% END %]
			[% IF alienhunter %]
			<div id="horizontalGeneTransfers" class="tab-pane fade">
				<form id="horizontalGeneTransfers-form">
					<div class="form-group">
						[% FOREACH text IN texts %]
						[% IF text.tag == 'search-database-dna-based-analyses-predicted-alienhunter' %]
						<label>[% text.value %]</label>
						[% END %]
						[% END %]
						<input class="form-control" type="number" steṕ="any" name="AHlen">
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
						<input class="form-control" type="number" steṕ="any" name="AHscore">
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
						<input class="form-control" type="number" steṕ="any" name="AHthr">
						[% FOREACH text IN texts %]
						[% IF text.tag.search('search-database-analyses-protein-code-number-transmembrane-domain-quantity') %]
						<div class="radio">
							<label><input type="radio" name="AHthrM" [% text.details %]>[% text.value %]</label>
						</div>
						[% END %]
						[% END %]
					</div>
					<input class="btn btn-primary btn-sm" type="submit" value="Search"> 
					<input class="btn btn-default btn-sm" type="button"  value="Clear Form" onclick="this.form.reset();">
				</form>
			</div>
			[% END %]
			</div>
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
<!-- CONTENT-WRAPPER SECTION END-->

CONTENTSEARCHDATABASE
		,
		"index.tt" => <<CONTENTINDEXSEARCHDATABASE
<!DOCTYPE html>
<div class="content-wrapper">
    <div class="container">
    	<div class="row">
    		<div class="col-md-12">
    			<input type="button" id="back" value="Back" class="btn btn-danger btn-lg" />
    		</div>
    	</div>
        [% INCLUDE 'website/search-database/_forms.tt' %]
        <section class="pagination-section">
	    	<div class="row">
	    		<div class="col-sm-2">
	    			<input type="button" id="begin" value="<<" class="btn btn-info btn-lg" />
	    		</div>
	    		<div class="col-sm-2">
	    			<input type="button" id="less" value="<" class="btn btn-info btn-lg" />
	    		</div>
	    		<form id="skipPagination">
		    		<div class="col-sm-2">
		    			<div class="row">
		    				<div class="col-md-6">
		    					<input type="number" id="numberPage" value="1" min="1" class="form-control" />
		    				</div>
		    				<div class="col-md-6"> 
		    					<p>pages of <span id="totalNumberPages" /></p>	
		    				</div>
		    			</div>
		    		</div>
		    		<div class="col-sm-2">
		    			<input type="submit" id="goPage" value="Go" class="btn btn-info btn-lg" />
		    		</div>
		    	</form>
	    		<div class="col-sm-2">
	    			<input type="button" id="more" value=">" class="btn btn-info btn-lg" />
	    		</div>
	    		<div class="col-sm-2">
	    			<input type="button" id="last" value=">>" class="btn btn-info btn-lg" />
	    		</div>
	    	</div>
    	</section>
    </div>
</div>
<script>
    \$("#parentCollapseOne").click(function ()
    {
        \$("#parentCollapseOne").removeClass("panel-default");
        \$("#parentCollapseTwo").removeClass("panel-primary");
        \$("#parentCollapseThree").removeClass("panel-primary");
        \$("#parentCollapseOne").addClass("panel-primary");
        \$("#parentCollapseTwo").addClass("panel-default");
        \$("#parentCollapseThree").addClass("panel-default");
    });
    \$("#parentCollapseTwo").click(function ()
    {
        \$("#parentCollapseTwo").removeClass("panel-default");
        \$("#parentCollapseOne").removeClass("panel-primary");
        \$("#parentCollapseThree").removeClass("panel-primary");
        \$("#parentCollapseTwo").addClass("panel-primary");
        \$("#parentCollapseOne").addClass("panel-default");
        \$("#parentCollapseThree").addClass("panel-default");
    });
    \$("#parentCollapseThree").click(function ()
    {
        \$("#parentCollapseThree").removeClass("panel-default");
        \$("#parentCollapseTwo").removeClass("panel-primary");
        \$("#parentCollapseOne").removeClass("panel-primary");
        \$("#parentCollapseThree").addClass("panel-primary");
        \$("#parentCollapseOne").addClass("panel-default");
        \$("#parentCollapseTwo").addClass("panel-default");
    });
</script>

<script type="text/javascript" src="/assets/js/site-client.js"></script>
<script type="text/javascript" src="/assets/js/search-database.js"></script>

CONTENTINDEXSEARCHDATABASE
		,
		"contigs.tt" => <<CONTENT
<!DOCTYPE html>
<div class="panel panel-default result">
	<div class="panel-heading">
		<div class="panel-title">
			<a id="title-panel" class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#[% sequence.id %]">Contig search results - Retrieved sequence(
			[% IF hadLimits %]
				from [% start %] to [% end %] of 
			[% END %]
			[% sequence.name %]
			[% IF hadReverseComplement %]
				, reverse complemented
			[% END %]
			)</a>
		</div>
	</div>
	<div id="[% sequence.id %]" class="panel-collapse collapse">
		<div class="panel-body">
			<div class="sequence">
				[% contig %]
			</div>
		</div>
	</div>
</div>
CONTENT
		,
		"dgpiBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		<p>Cleavage site:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.cleavage_site %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Score:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.score %]</p>
	</div>
</div>
CONTENT
		,
		"evidences.tt" => <<CONTENT
<!DOCTYPE html>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">
			<a id="anchor-evidence-[% result.componentName %]-[% result.id %]" data-toggle="collapse" data-parent="#accordion" href="#evidence-[% result.componentName %]-[% result.id %]">[% result.descriptionComponent %]</a>
		</div>
	</div>
	<div id="evidence-[% result.componentName %]-[% result.id %]" class="panel-body collapse">
	</div>
</div>
CONTENT
		,
		"hmmerBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		<p>Sequence name:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.seq_name %]</p>
	</div>
</div>
<div class="row">
        <div class="col-md-3">
                <p>Score:</p>
        </div>
        <div class="col-md-9">
                <p>[% result.score %]</p>
        </div>
</div>
<div class="row">
        <div class="col-md-3">
                <p>Exon number:</p>
        </div>
        <div class="col-md-9">
                <p>[% result.exon_number %]</p>
        </div>
</div>
<div class="row">
        <div class="col-md-3">
                <p>Length:</p>
        </div>
        <div class="col-md-9">
                <p>[% result.length %]</p>
        </div>
</div>
<div class="row">
        <div class="col-md-3">
                <p>Genetic code:</p>
        </div>
        <div class="col-md-9">
                <p>[% result.genetic_code %]</p>
        </div>
</div>
CONTENT
		,
		"gene.tt" => <<CONTENT
<!DOCTYPE html>
<div class="panel panel-default result">
	<div class="panel-heading">
		<div class="panel-title">
			<a id="result-panel-title-[% result.feature_id %]" data-toggle="collapse" data-parent="#accordion" href="#[% result.feature_id %]">[% result.name %] - [% result.uniquename %]</a>
		</div>
	</div>
	<div id="[% result.feature_id %]" class="panel-body collapse">
	</div>
</div>
CONTENT
		,
		"geneBasics.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		<p>Gene type:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.type %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Located in:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.uniquename %] (from position [% result.fstart %] to [% result.fend %])</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Gene length:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.length %]</p>
	</div>
</div>
CONTENT
		,
		"interproBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">
			<a data-toggle="collapse" data-parent="#accordion" href="#[% result.componentName %]-[% result.feature_id %]-[% result.counter %]">[% result.counter %]</a>
		</div>
	</div>
	<div id="[% result.componentName %]-[% result.feature_id %]-[% result.counter %]" class="panel-body collapsed">
		<div class="row">
			<div class="col-md-3">
				<p>InterPro identifier:</p>
			</div>
			<div class="col-md-9">
				<p><a href="http://www.ebi.ac.uk/interpro/entry/[% result.interpro_id %]">[% result.interpro_id %]</a></p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<p>InterPro description:</p>
			</div>
			<div class="col-md-9">
				<p>[% result.description_interpro %]</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<p>Database identifier and database:</p>
			</div>
			<div class="col-md-9">
				<p><a href="http://www.ebi.ac.uk/interpro/search?q=[% result.DB_id %]">[% result.DB_id %]</a> ([% result.DB_name %])</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<p>Database match description:</p>
			</div>
			<div class="col-md-9">
				<p>[% result.description %]</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<p>GO process:</p>
			</div>
			<div class="col-md-9">
				<p>[% result.evidence_process %]</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<p>GO function:</p>
			</div>
			<div class="col-md-9">
				<p>[% result.evidence_function %]</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<p>GO component:</p>
			</div>
			<div class="col-md-9">
				<p>[% result.evidence_component %]</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<p>Match score:</p>
			</div>
			<div class="col-md-9">
				<p>[% result.score %]</p>
			</div>
		</div>
	</div>
</div>
CONTENT
		,
		"orthologies.tt" => <<CONTENT
<tr>
	<td><a href="http://eggnog.embl.de/version_3.0/cgi/search.py?search_term_0=[% result.orthologous_group %]">[% result.orthologous_group %]</a> - [% result.orthologous_group_description %]</td>
</tr>
CONTENT
		,
		"orthologyBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		Match identifier:
	</div>
	<div class="col-md-9">
		[% result.orthologous_hit %]
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<div class="table-responsive">
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>Orthologous group:</th>
					</tr>
				</thead>
				<tbody id="orthology-[% result.id %]">
					
				</tbody>
			</table>
		</div>
	</div>
</div>
CONTENT
		,
		"pathways.tt" => <<CONTENT
<tr>
	<td><a href="http://www.genome.jp/dbget-bin/www_bget?[% result.metabolic_pathway_id %]">[% result.metabolic_pathway_id %]</a> - [% result.metabolic_pathway_description %]</td>
</tr>
CONTENT
		,
		"pathwaysBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		Orthologous group:
	</div>
	<div class="col-md-9">
		<a href="http://www.genome.jp/dbget-bin/www_bget?[% result.orthologous_group_id %]">[% result.orthologous_group_id %]</a> - [% result.orthologous_group_description %]
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<div class="table-responsive">
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>Pathways:</th>
					</tr>
				</thead>
				<tbody id="pathways-[% result.orthologous_group_id %]">
					
				</tbody>
			</table>
		</div>
	</div>
</div>
CONTENT
		,
		"predgpiBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		<p>Result:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.result %]</p>
	</div>
</div>
CONTENT
		,
		"properties.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		[% result.key %]
	</div>
	<div class="col-md-9">
		[% result.value %]
	</div>
</div>
CONTENT
		,
		"rnaPredictionBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		<p>Molecule type:</p>
	</div
	<div class="col-md-9">
		<p>[% result.molecule_type %]</p>
	</div
</div>
<div class="row">
	<div class="col-md-3">
		<p>Prediction score:</p>
	</div
	<div class="col-md-9">
		<p>[% result.score %]</p>
	</div
</div>
CONTENT
		,
		"rnaScanBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		<p>Product description:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.target_description %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Prediction score:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.score %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>E-value of match:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.evalue %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Identifier of match:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.target_identifier %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Target name:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.target_name %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Target type:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.target_type %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Bias:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.bias %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Truncated:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.truncated %]</p>
	</div>
</div>
CONTENT
		,
		"rRNAPredictionBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		<p>Molecule type:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.molecule_type %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Prediction score:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.score %]</p>
	</div>
</div>
CONTENT
		,
		"sequence.tt" => <<CONTENT
<!DOCTYPE html>
<div class="panel panel-default sequences">
	<div class="panel-heading">
		<div class="panel-title">
			<a data-toggle="collapse" data-parent="#accordion" href="#sequence-[% result.feature_id %]">Sequence</a>
		</div>
	</div>
	<div id="sequence-[% result.feature_id %]" class="panel-body collapse sequence">
		[% result.sequence %]
	</div>
</div>
CONTENT
		,
		"similarityBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		<p>E-value of match</p>
	</div>
	<div class="col-md-9">
		<p>[% result.evalue %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Percent identity</p>
	</div>
	<div class="col-md-9">
		<p>[% result.percent_id %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Percent similarity</p>
	</div>
	<div class="col-md-9">
		<p>[% result.similarity %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Alignment score</p>
	</div>
	<div class="col-md-9">
		<p>[% result.score %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Alignment length</p>
	</div>
	<div class="col-md-9">
		<p>[% result.block_size %]</p>
	</div>
</div>
CONTENT
		,
		"subEvidences.tt" => <<CONTENT
<!DOCTYPE html>
<div class="panel panel-default">
	<div class="panel-heading">
		<div class="panel-title">
			<a data-toggle="collapse" data-parent="#accordion" href="#subevidence-[% result.feature_id %]">[% result.feature_id %]</a>
		</div>
	</div>
	<div id="subevidence-[% result.feature_id %]" class="panel-body collapse">
	</div>
</div>
CONTENT
		,
		"tcdbBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		<p>Transporter classification:</p>
	</div>
	<div class="col-md-9">
		<p><a href="http://tcdb.org/search/result.php?tc=[% result.TCDB_ID %]">[% result.hit_description %]</a></p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Class:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.TCDB_class %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Subclass:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.TCDB_subclass %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Family:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.TCDB_family %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Match identifier:</p>
	</div>
	<div class="col-md-9">
		<p><a href="http://www.uniprot.org/uniprot/[% result.hit_name %]">[% result.hit_name %]</a></p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>E-value of match:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.evalue %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Percent identity:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.percent_id %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Percent similarity:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.similarity %]</p>
	</div>
</div>
CONTENT
		,
		"tmhmmBasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		Predicted TMHs
	</div>
	<div class="col-md-9">
		[% result.predicted_TMHs %]
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		Direction
	</div>
	<div class="col-md-9">
		[% result.direction %]
	</div>
</div>
CONTENT
		,
		"tRNABasicResult.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		<p>Gene name:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.type %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Amino acid:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.aminoacid %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Anticodon:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.anticodon %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Codon:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.codon %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Prediction score:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.score %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Is pseudogene:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.pseudogene %]</p>
	</div>
</div>
CONTENT
		,
		"tRNABasicResultHasIntron.tt" => <<CONTENT
<!DOCTYPE html>
<div class="row">
	<div class="col-md-3">
		<p>Intron predicted:</p>
	</div>
	<div class="col-md-9">
		<p>[% result.intron %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Coordinates (gene):</p>
	</div>
	<div class="col-md-9">
		<p>[% result.coordinatesGene %]</p>
	</div>
</div>
<div class="row">
	<div class="col-md-3">
		<p>Coordinates (genome):</p>
	</div>
	<div class="col-md-9">
		<p>[% result.coordinatesGenome %]</p>
	</div>
</div>
CONTENT
		,
		"result.tt" => <<CONTENT
<!DOCTYPE html>
<div class="content-wrapper">
    <div class="container">
    	[% SWITCH type_search %]
    		[% CASE 0 %]
		    	[% FOREACH result IN searchResult %]
					<div class="panel panel-default">
						<div class="panel-heading">
							<div class="panel-title">
								<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#[% result.feature_id %]">[% result.name %] - [% result.uniquename %]</a>
							</div>
						</div>
						<div id="[% result.feature_id %]" class="panel-collapse collapse">
							<div class="panel-body">
							</div>
						</div>
					</div>
		    	[% END %]
	    	[% CASE 1 %]
	    		[% IF contig %]
		    		<div class="panel panel-default">
						<div class="panel-heading">
							<div class="panel-title">
								<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#[% sequence.id %]">Contig search results - Retrieved sequence(
								[% IF hadLimits %]
									from [% start %] to [% end %] of 
								[% END %]
								[% sequence.name %]
								[% IF hadReverseComplement %]
									, reverse complemented
								[% END %]
								)</a>
							</div>
						</div>
						<div id="[% sequence.id %]" class="panel-collapse collapse">
							<div class="panel-body">
								<div class="sequence">
									[% contig %]
								</div>
							</div>
						</div>
					</div>
				[% ELSE %]
					<div class="alert alert-danger">
						[% FOREACH text IN texts %]
							[% IF text.tag == 'result-warning-contigs' %]
								[% text.value %]
							[% END %]
						[% END %]
					</div>
				[% END %]
	    [% END %]
    </div>
</div>

CONTENT
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
<link href="/assets/css/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="/assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="/assets/css/style.css" rel="stylesheet" />
<!-- PACE loader CSS -->
<link href="/assets/css/pace-theme-fill-left.css" rel="stylesheet" />
<!-- PACE loader js -->
<script src="/assets/js/pace.min.js"></script>
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
                        
                        [% text.value %]
                        &nbsp;&nbsp;
                        
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
            <a class="navbar-brand" href="[% c.uri_for('/') %]">

                <img src="/assets/img/logo.png" />
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
			                        	<li><a  href="[% c.uri_for('/SearchDatabase') %]">Search database</a></li>
			                        [% ELSIF hadGlobal && text.value.match("global analyses") %]
			                        	<li><a	href="[% c.uri_for('/GlobalAnalyses') %]">Global analyses</a></li>
			                        [% ELSIF !text.value.match("global analyses") && !text.value.match("search database")%]
			                        	<li><a href="[% c.uri_for(text.details) %]">[% text.value %]</a></li>
			                        [% END %]
                                [% END %]
                            [% END %]
                        [% END %]
                        <!--<li><a  class="menu-top-active" href="[% c.uri_for('/') %]">Home</a></li>
                       	<li><a	href="[% c.uri_for('/Blast') %]">BLAST</a></li>
                        <li><a	href="[% c.uri_for('/Downloads') %]">Downloads</a></li>
                        <li><a	href="[% c.uri_for('/Help') %]">Help</a></li>
                        <li><a	href="[% c.uri_for('/About') %]">About</a></li>-->
                    </ul>
                </div>
            </div>

        </div>
    </div>
</section>

MENU
	}
);

unless ($hadGlobal) {
	delete $contentHTML{"global-analyses"};
}
unless ($hadSearchDatabase) {
	delete $contentHTML{"search-database"};
}

#writeFile("log-report-html-db.log", $scriptSQL);

print $LOG "\nCreating html views\n";
foreach my $directory ( keys %contentHTML ) {
	if ( !( -e "$html_dir/root/$lowCaseName/$directory" ) ) {
		print $LOG "\nCriando diretorio $directory\n";
		`mkdir -p "$html_dir/root/$lowCaseName/$directory"`;
	}
	foreach my $file ( keys %{ $contentHTML{$directory} } ) {
		print $LOG "\nCriando arquivo $file\n";
		writeFile( "$html_dir/root/$lowCaseName/$directory/$file",
			$contentHTML{$directory}{$file} );
	}
}

#Create file wrapper
print $LOG "\nCreating wrapper\n";
my $wrapper = <<WRAPPER;
﻿<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        [% INCLUDE '$lowCaseName/shared/_head.tt' %]
        <!-- import _head from Views/Shared -->
    </head>
    <body>
        <!-- CORE JQUERY SCRIPTS -->
        <script src="/assets/js/jquery-1.11.1.js"></script>
        <!-- BOOTSTRAP SCRIPTS  -->
        <script src="/assets/js/bootstrap.js"></script>
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
writeFile( "$html_dir/root/$lowCaseName/_layout.tt", $wrapper );

print $LOG "\nEditing root file\n";
writeFile( "$html_dir/lib/$html_dir/Controller/Root.pm", $rootContent );

#inicialize server project
#`./$nameProject/script/"$lowCaseName"_server.pl -r`;
print $LOG "Done\nTurn on the server with this command:\n./$html_dir/script/"
  . $lowCaseName
  . "_server.pl -r\n"
  . "http://localhost:3000\n";
close($LOG);

`cp -r $html_dir "$standard_dir"/`;
`cp -r $services_dir "$standard_dir"/`;
`rm -rf $html_dir`;
`rm -rf $services_dir`;
exit;

###
#   Method used to write files
#   @param $filepath => path with the file to be write or edit
#   @param $content => content to be insert
#
sub writeFile {
	my ( $filepath, $content ) = @_;
	open( my $FILEHANDLER, ">:encoding(UTF-8)", $filepath )
	  or die "Error opening file";

	#	binmode($FILEHANDLER, ":utf8");
	print $FILEHANDLER $content;
	close($FILEHANDLER);
}

###
#	Method used to read HTML file with the texts to be used on site
#	@param $file => path of the JSON file to be read
#	return data in SQL
#
sub readJSON {
	my ($file) = @_;
	open( my $FILEHANDLER, "<", $file );
	my $content = do { local $/; <$FILEHANDLER> };
	my $sql = "";
	while ( $content =~
/^\t"([\w\-\_]*)"\s*:\s*"([\w\s<>\/@.\-:;?+(),'=&ããàâáéêíóõú#|]*)"/gm
	  )
	{
		my $tag   = $1;
		my $value = $2;
		if ( $tag =~ /^files-/ ) {
			$tag =~ s/files-//g;
			$sql .= <<SQL;
			INSERT INTO FILES(tag, filepath) VALUES ("$tag", "$value");
SQL

		}
		else {
			$sql .= <<SQL;
			INSERT INTO TEXTS(tag, value) VALUES ("$tag", "$value");
SQL
		}
	}
	close($FILEHANDLER);
	return $sql;
}

=head2
Method used to get content of TCDB file
@param tcdb_file => filepath
return sql to be used
=cut

sub readTCDBFile {
	my ($tcdb_file) = @_;
	open( my $FILEHANDLER, "<", $tcdb_file );
	my $sql = "";
	while ( my $line = <$FILEHANDLER> ) {
		if ( $line =~ /^(\d\t[\w\/\s\-]*)[^\n]\v/gm ) {
			$sql .= <<SQL;
			INSERT INTO TEXTS(tag, value) VALUES ("search-database-analyses-protein-code-search-by-transporter-class-option", "$1");
SQL
		}
		elsif ( $line =~ /(\d\.[\w.\s#&,:;\/\-+()'\[\]]*)/ ) {
			$sql .= <<SQL;
			INSERT INTO TEXTS(tag, value) VALUES ("search-database-analyses-protein-code-search-by-transporter-subclass-option", "$1");
SQL
		}
	}
	close($FILEHANDLER);
	return $sql;
}

=head2
Method used to get code number of the product
@param subject_id
return list with code number and product
=cut

sub get_code_number_product {
	my $subject_id = shift;
	my $code_number;
	my $product;

	if ( $subject_id =~ m/\S+\|(\S+)\|(.*)/ ) {
		$code_number = $1;
		$product     = $2;
	}
	elsif ( $subject_id =~ m/(\S+)_(\S+) (.*)/ ) {
		$code_number = $2;
		$product     = $3;
	}
	elsif ( $subject_id =~ m/(\S+)/ ) {
		$code_number = $1;

		if ( $code_number =~ m/(\S+)\_\[(\S+)\_\[/ ) {
			$code_number = $1;
			$product     = "similar to " . $code_number;
		}
	}

	$product =~ s/^ //g;
	$product =~ s/ $//g;

	return ( $code_number, $product );
}

=head2 reverseComplement

Method used to return the reverse complement of a sequence

=cut

sub reverseComplement {
	my ($sequence) = @_;
	my $reverseComplement = reverse($sequence);
	$reverseComplement =~ tr/ACGTacgt/TGCAtgca/;
	return $reverseComplement;
}

=head2 formatSequence

Method used to format sequence

=cut

sub formatSequence {
	my $seq = shift;
	my $block = shift || 80;
	$seq =~ s/.{$block}/$&\n/gs;
	chomp $seq;
	return $seq;
}

=head2 verify_element

Method used to verify if element exists in list reference

=cut

sub verify_element {
	my $element = shift;
	my $vector  = shift;
	my @array   = @{$vector};
	my %params  = map { $_ => 1 } @array;

	if ( exists( $params{$element} ) ) {
		return 1;
	}

	return 0;

}
