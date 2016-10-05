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
-	Estudar banco de dados chado e entender a organização das evidências/conclusões
-	Criar controllers para realizar pesquisas do Search database
-	Planejar como vai funcionar as views do resultados da pesquisa do search database (ver exemplos do slide)
-	Usar o controller SearchDatabase, basear searchPMNseq.cgi e outros do photorhabdus luminescens

http://www.catalystframework.org/calendar/2009/22
http://www.catalystframework.org/calendar/2009/19
http://www.catalystframework.org/calendar/2006/9
http://search.cpan.org/~jjnapiork/Catalyst-Action-REST-1.20/lib/Catalyst/Action/REST.pm
http://search.cpan.org/~jjnapiork/Catalyst-Action-REST-1.20/lib/Catalyst/Controller/REST.pm


-	Ler arquivo da sequencia completa e depois realizar pesquisa pelos contigs usando substring

-	bigou.pl -c html_db.cnf -d "chadodb" -u "chadouser" -p "" -h "127.0.0.1"
