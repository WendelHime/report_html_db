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

INSERT INTO TEXTS(tag, value, details) VALUES("header-email", "Email:", ""),
									("header-email-value", "wendelhime@gmail.com", ""),
									("header-support", "Support:", ""),
									("header-support-value", "+55 (13) 99192-9997", ""),
									("menu", "home", "/home"),
									("menu", "blast", "/blast"),
									("menu", "search database", "/searchdatabase"),
									("menu", "global analyses", "/globalanalyses"),
									("menu", "downloads", "/downloads"),
									("menu", "help", "/help"),
									("menu", "about", "/about"),
									("footer", "&copy; 2015 YourCompany | By : Wendel Hime", "/#"),
									("panel-home", "Information", ""),
									("panel-home-value", "The <i>Photorhabdus luminescens</i> MN7 genome database (<b>PhotoBase</b>) is an integrated resource of genome sequencing and annotation data of the entomopathogenic enterobacterium <i>Photorhabdus luminescens</i> MN7. In addition to sequencing data, <b>PhotoBase</b> provides an organized catalog of functionally annotated predicted protein-coding and RNA genes, in addition to several DNA-based analysis results. The <b>PhotoBase</b> is maintained by the Coccidia Molecular Biology Research Group and the Nematode Molecular Biology Lab at the Institute of Biomedical Sciences, University of São Paulo, Brazil.", ""),
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
									("blast-format-title", "Enter sequence below in <a href="http://puma.icb.usp.br/blast/docs/fasta.html">FASTA</a> format", ""),
									("blast-sequence-file-title", "Or load it from disk ", ""),
									("blast-subsequence-title", "Set subsequence ", ""),
									("blast-subsequence-value", "From:", "QUERY_FROM"),
									("blast-subsequence-value", "To:", "QUERY_TO"),
									("blast-search-options-title", "Search options", ""),
									("blast-search-options-sequence-title", "The query sequence is <a href="http://puma.icb.usp.br/blast/docs/filtered.html">filtered</a> for low complexity regions by default.", ""),
									("blast-search-options-filter-title", "Filter:", "http://puma.icb.usp.br/blast/docs/newoptions.html#filter"),
									("blast-search-options-filter-options", "Low complexity", "L"),
									("blast-search-options-filter-options", "Mask for lookup table only", "m");
