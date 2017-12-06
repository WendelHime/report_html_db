# report\_html\_db
Projeto de iniciação científica, componente utilizado para gerar site(com conteúdo dinâmico) baseado nos resultados de componentes utilizados anteriormente<br /><br /> 

Para instalar dependencias:<br /><br /> 

`sudo apt-get install sqlite3`<br /><br /> 

`cpan DBIx::Class Catalyst::Devel Catalyst::Runtime Catalyst::View::TT Catalyst::View::JSON Catalyst::Model::DBIC::Schema  DBIx::Class::Schema::Loader MooseX::NonMoose Helper::ResultSet::SetOperations`<br /><br /> 

Para rodar:<br /><br /> 

`bigou\_m.pl -c html\_db.cnf -d database\_name -u username\_database -p password -h address -o output\_dir`<br /><br /> 

Inicialize a aplicação de serviço:<br /><br />

`./output\_dir/Organism-Service/script/organism\_service\_\_server.pl -r &`

Adicione o caminho do serviço na configuração do Organism-Website:<br /><br />
`echo "\nrest\_endpoint http://127.0.0.1:3000\npipeline\_id 4528" >> ./output\_dir/Organism-Website/organism\_website.conf`<br /><br /> 

`./output\_dir/Organism-Website/script/organism\_website\_\_server.pl -r -p 8080 &`<br /><br /> 
  
Acesse o site:<br /><br /> 

http://127.0.0.1:8080



