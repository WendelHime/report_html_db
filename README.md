# report_html_db
Projeto de iniciação científica, componente utilizado para gerar site(com conteúdo dinâmico) baseado nos resultados de componentes utilizados anteriormente

Para instalar dependencias:

sudo apt-get install sqlite3

cpan DBIx::Class Catalyst::Devel Catalyst::Runtime Catalyst::View::TT Catalyst::View::JSON Catalyst::Model::DBIC::Schema  DBIx::Class::Schema::Loader MooseX::NonMoose Helper::ResultSet::SetOperations

Para rodar:

./report_html_db.pl -name Test

Inicialize o servidor:

./Test/script/test_server.pl -r
  
Acesse o site:

http://127.0.0.1:3000


TODO:
-
-	Renomear DBI para Reporitory

-	Criar modelos
-	Testar implementação do BaseResponse.pm -> done

-	Repositório retornar modelo
-	Separar SearchDatabase que atualmente é o serviço
-	Aceitar parametro para o caminho do services para ser implementado nos clients

-	Padronizar retorno do serviço para usar o BaseResponse -> done
-	Criar clients -> done


-	Recriar SearchDatabase para entrar em contato com o client para fazer requisições
-	Atualizar report_html_db.pl
-	Criar pagina de erro geral
-	bigou.pl -c html_db.cnf -d "chadodb" -u "chadouser" -p "" -h "127.0.0.1"
