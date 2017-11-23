# report\_html\_db
Projeto de iniciação científica, componente utilizado para gerar site(com conteúdo dinâmico) baseado nos resultados de componentes utilizados anteriormente

Para instalar dependencias:

sudo apt-get install sqlite3

cpan DBIx::Class Catalyst::Devel Catalyst::Runtime Catalyst::View::TT Catalyst::View::JSON Catalyst::Model::DBIC::Schema  DBIx::Class::Schema::Loader MooseX::NonMoose Helper::ResultSet::SetOperations

Para rodar:

bigou\_m.pl -c html\_db.cnf -d database\_name -u username\_database -p password -h address -o output\_dir

Inicialize a aplicação de serviço:

./output\_dir/Organism-Service/script/organism\_service\_server.pl -r &

Adicione o caminho do serviço na configuração do Organism-Website:
echo "\nrest\_endpoint http://127.0.0.1:3000\npipeline\_id 4528" >> ./output\_dir/Organism-Website/organism\_website.conf

./output\_dir/Organism-Website/script/organism\_website\_server.pl -r -p 8080 &
  
Acesse o site:

http://127.0.0.1:8080



