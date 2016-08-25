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
-	Criar arquivo base de textos que serão definidos, esta sendo utilizado o arquivo example.html - criado
-	Fazer leitura do arquivo example.html, pegar as tags marcadas com div class e id, e pegar o conteúdo delas
-	Usar essa expressão regular caso estiver certo o exemplo: /div class="(\w+)" id="(\w+)">([\s\S]*)*<\/div>/g