# report\_html\_db
Projeto de iniciação científica, componente utilizado para gerar site(com conteúdo dinâmico) baseado nos resultados de componentes utilizados anteriormente

Para instalar dependencias:

sudo apt-get install sqlite3

cpan DBIx::Class Catalyst::Devel Catalyst::Runtime Catalyst::View::TT Catalyst::View::JSON Catalyst::Model::DBIC::Schema  DBIx::Class::Schema::Loader MooseX::NonMoose Helper::ResultSet::SetOperations

Para rodar:

bigou_m.pl -c html_db.cnf -d database_name -u username_database -p password -h address -o output_dir

Inicialize o servidor:

./Test/script/test_server.pl -r
  
Acesse o site:

http://127.0.0.1:3000

O que esta sendo feito agora:
-
-	Criar clients em perl para uso do caminho da aplicação de serviços no arquivo de configuração - Done
-	Precisamos atualizar o conteudo HTML que sera escrito pelo script - Done
-	Apontar os clients js para o website - Done
-	Colocar Interpro description e id no nome do painel - Done
-	Atualizar Repository(linhas 858, 861, 864, 868, 1064, 1067, 1070), action.js - Done
-	Testar todas as pesquisas - Done
-	Função do repositorio recebe parametro de page_size(limite em quantidade) e offset(compensação antes de pegar o limite) - Done
-	Service preenche e retorna PagedResponse passando a resposta do repositorio + os parametros page size, offset e total(quantidade de retornados) - Done
-	Service.Client envia parametros page_size e offset, retorna paged response - Done
-	Aplicação envia parametros de page_size e offset ao client, retorna paged response - Done
-	JS recebe paged response, precisa de uma variavel global ou criação de input hidden contendo offset += 10 e pageSize = 10 - Done
-	Global analyses - Done
-	report_html_db.pl deve executar makeblastdb nos arquivos do Services - Done
-	Criar controller no Services para blast - Done
-	Criar função blast no Services - Done
-	Criar BlastRepository.pm - Done
-	Validar parametros no services
-	Criar BlastClient.pm - Done
-	Criar BlastController no Website para receber requisição para usar BlastClient - Done
-	Criar arquivos js para requisitar Blast - Done
-	search BLAST deve retornar conteúdo no formato padrão
-	Criar função para executar fancy_blast.pl que vai receber o conteudo do arquivo, 
a função irá criar um arquivo temporário e aaaaarmazenar o conteúdo BLAST nele, 
vai criar um diretório temporário com UNLINK => 0, executar fancy_blast.pl conteudoblast.txt /tmp no_code;
edita HTML para substituir img href para algum MD5 que será o nome renomeado do arquivo .png
-	Criar função para receber MD5 com o nome do arquivo PNG da pasta /tmp/ e retornar conteúdo para ser baixado


TODO:
-
-	Criar o resto dos modelos que serão utilizados pelo repositorio
-	Criar pagina de erro geral
-	Modificar Repository.pm atual para SearchDatabaseRepository.pm
-	Modificar action.js para search-database.js
-	Adicionar fileHandler.js para o assets.tar.gz
