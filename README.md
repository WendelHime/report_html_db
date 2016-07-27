# report_html_db
Projeto de iniciação científica, componente utilizado para gerar site(com conteúdo dinâmico) baseado nos resultados de componentes utilizados anteriormente

Para instalar dependencias:

sudo apt-get install sqlite3

cpan DBIx::Class Catalyst::Devel Catalyst::Runtime Catalyst::View::TT Catalyst::View::JSON Catalyst::Model::DBIC::Schema  DBIx::Class::Schema::Loader MooseX::NonMoose

Para rodar:

./report_html_db.pl -name Test

Inicialize o servidor:

./Test/script/test_server.pl -r
  
Acesse o site:

http://127.0.0.1:3000


TODO:
-
- 	Não esta rodando! 
-	Pegar dados das sequencias, gerar
-	Gerar tabela SEQUENCES(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, header VARCHAR(10000), bases VARCHAR(10000), name VARCHAR(2000));
-	Gerar tabela CONCLUSIONS(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, idSequence INT, locusTag VARCHAR(10000), FOREIGN KEY idSequence REFERENCES SEQUENCES(id));
-	Gerar tabela EVIDENCES(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, idConclusion INT, idEvidence INT, name VARCHAR(2000), number INT, start INT, end INT, proteinSequence VARCHAR(10000), FOREIGN KEY idConclusion REFERENCES CONCLUSIONS(id), FOREIGN KEY idEvidence REFERENCES EVIDENCES(id));
-	Gerar tabela ALIGNMENTS(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, idEvidence INT, subjectId VARCHAR(200), typeDB VARCHAR(200), accession VARCHAR(200), hmmerResult VARCHAR(200), FOREIGN KEY idEvidence REFERENCES EVIDENCES(id));
-	Gerar tabela INTERVALS(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, idEvidence INT, value VARCHAR(2000), FOREIGN KEY idEvidence REFERENCES EVIDENCES(id));
-	Gerar tabela TAGS(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, idInterval INT, tag VARCHAR(2000), value VARCHAR(10000), FOREIGN KEY idInterval REFERENCES INTERVALS(id));
-	Gerar tabela TYPES(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, idEvidence INT, value VARCHAR(2000), FOREIGN KEY idEvidence REFERENCES EVIDENCES(id));
-	Gerar tabela COMPONENTS(id INT PRIMARY KEY AUTOINCREMENT NOT NULL, tag VARCHAR(2000), name VARCHAR(2000)); -- tag pode ser um comp_ev ou comp_dna
-	Gerar tabela BLAST(id INT PRIMARY KEY AUTOINCREMENT NOT NULL, database VARCHAR(2000), directory VARCHAR(2000));
	