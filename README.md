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
-	Estudar banco de dados chado e entender a organização das evidências/conclusões
-	Corrigir exceção na geração do site:	
Could not find a proper name for relationship 'pub_2' in source
'PhenotypeComparisonCvterm' for columns 'pub_id'. Supply a value in
'inflect_singular' for 'pub_2' or 'rel_name_map' for
'pub_2' to name this relationship.
Could not find a proper name for relationship 'phenotype_comparison_cvterm_pubs_2s' in source
'Pub' for columns 'pub_id'. Supply a value in
'inflect_plural' for 'phenotype_comparison_cvterm_pubs_2' or 'rel_name_map' for
'phenotype_comparison_cvterm_pubs_2s' to name this relationship.
Dumping manual schema for html_dir::Chado to directory /home/wendelhlc/git/report_html_db/report_html_db/html_dir/script/../lib ...
	