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
-	Criar pagina de erro geral
-	Usar o controller SearchDatabase, basear searchPMNseq.cgi e outros do photorhabdus luminescens
-	Ler a partir da linha 887 report_html.pl
-	Criar arquivos com o nome do ID da sequencia, como por exemplo html_dir/orfs_aa/Bact_01.fasta onde possui sequencia de nucleotídeos + sequencia traduzida
-	Criar função que receba o gene ID se tipo for proteina codificante então retorna o tipo do gene, descrição, local e tamanho;
-	Se for do tipo tRNA retorna o tipo, local, tamanho, nome, amino acido, anticodon, codon, score de predição e se é um pseudogene
-	Criar função que leia arquivo de sequencia se baseando no gene id e retorna o conteúdo como função assíncrona 
-	

http://www.catalystframework.org/calendar/2009/22
http://www.catalystframework.org/calendar/2009/19
http://www.catalystframework.org/calendar/2006/9
http://search.cpan.org/~jjnapiork/Catalyst-Action-REST-1.20/lib/Catalyst/Action/REST.pm
http://search.cpan.org/~jjnapiork/Catalyst-Action-REST-1.20/lib/Catalyst/Controller/REST.pm


-	Ler arquivo da sequencia completa e depois realizar pesquisa pelos contigs usando substring

-	bigou.pl -c html_db.cnf -d "chadodb" -u "chadouser" -p "" -h "127.0.0.1"
