# report\_html\_db
Projeto de iniciação científica, componente utilizado para gerar site(com conteúdo dinâmico) baseado nos resultados de componentes utilizados anteriormente

Para instalar dependencias:

sudo apt-get install sqlite3

cpan DBIx::Class Catalyst::Devel Catalyst::Runtime Catalyst::View::TT Catalyst::View::JSON Catalyst::Model::DBIC::Schema  DBIx::Class::Schema::Loader MooseX::NonMoose Helper::ResultSet::SetOperations

Para rodar:

bigou\_m.pl -c html\_db.cnf -d database\_name -u username\_database -p password -h address -o output_dir

Inicialize o servidor:

./Test/script/test\_server.pl -r
  
Acesse o site:

http://127.0.0.1:3000

O que esta sendo feito agora:
-


TODO:
-
-	Criar pagina de erro geral


-	Alienhunter, Terminator: 3 colunas(dos resultados) e link para sequência
-	tRNA: Bug exibindo tudo quando não existe
-	tRNA: Adicionar link do arquivo
-	Analyses of protein - coding genes: não esta mostrando erro caso não encontra nada
-	Arquivos das análises de DNA
-	Transporter: Não mostra se esta vazio
-	Alinhar sequencia de nucleotídeos
-	Busca por identificador do orthology não esta funcionando


-	Global analyses:
-	Go mapping: expansible tree
-	KEGG pathways: link errado


-	Downloads:
-	Protein-coding genes para CDS
-	All-genes: colocar reverso complementar 
-	All-genes: colocar todos os genes(e não somente CDS)
-	Arquivos para download em fasta

Done:
-
-	Criar clients em perl para uso do caminho da aplicação de serviços no arquivo de configuração
-	Precisamos atualizar o conteudo HTML que sera escrito pelo script
-	Apontar os clients js para o website-	Colocar Interpro description e id no nome do painel
-	Atualizar Repository(linhas 858, 861, 864, 868, 1064, 1067, 1070), action.js
-	Testar todas as pesquisa
-	Função do repositorio recebe parametro de page\_size(limite em quantidade) e offset(compensação antes de pegar o limite)
-	Service preenche e retorna PagedResponse passando a resposta do repositorio + os parametros page size, offset e total(quantidade de retornados)
-	Service.Client envia parametros page\_size e offset, retorna paged response
-	Aplicação envia parametros de page\_size e offset ao client, retorna paged response
-	JS recebe paged response, precisa de uma variavel global ou criação de input hidden contendo offset += 10 e pageSize = 10
-	Global analyses
-	report\_html\_db.pl deve executar makeblastdb nos arquivos do Services
-	Criar controller no Services para blast
-	Criar função blast no Services
-	Criar BlastRepository.pm
-	Criar BlastClient.pm
-	Criar BlastController no Website para recebe
-	Conversar com professor J sobre os componentes que não tem resultados (se devem ser exibidos mesmo que não tenha nenhuma informação)r requisição para usar BlastClient
-	Criar arquivos js para requisitar Blast
-	search BLAST deve retornar conteúdo no formato padrão
-	Criar função para executar fancy\_blast.pl que vai receber o conteudo do arquivo, a função irá criar um arquivo temporário e armazenar o conteúdo BLAST nele, salvar o conteudo do fancy\_blast em diretorio temporario e retornar conteúdo arquivo .html e arquivo .png; O arquivo .png deve ser retornado em base64
-	Adicionar acesso ao repositorio e services a função de pegar o identificador e descrição de buscas de similaridade
-	Criar função verify\_element se baseando na função do report\_html.pl - Done
-	Separar componentes (condicionais) das evidencias e subevidencias se baseando no report\_html.pl
-	Utilizar \@comp\_ev e \@comp\_dna do report\_html.pl para poder utilizar a função verify\_element na refatoração
-	Modificar Repository.pm atual para SearchDatabaseRepository.pm
-	Modificar e atualizar action.js para search-database.js
-	Adicionar fileHandler.js para o assets.tar.gz
-	Inserir Blast.pm, BlastRepository.pm, BlastClient.pm report\_html\_db.pl services e website
-	Atualizar HTMLs
-	Atualizar SearchDatabase report\_html\_db.pl services e website
-	Criar função que va receber locus\_tag + nome do componente, realize consulta no SQLite e retorne o conteudo do arquivo
- 	Resolver bugs dos componentes na parte de analises de proteinas codificantes
-	Encobrir no report\_html\_\_db.pl os componentes que não estão criando links simbolicos e adicionando ao SQLite
-	Corrigir a parte do phobius das analises cds
-	Arrumar erros da pagina do BLAST, alguma notificação caso não haja resposta
-	tandem repeats (sequencia muito pequena, não encontra gene) e alienhunter(horizontal transfer genes) não estão com links para determinada sequencia
-	Adicionar links as evidencias/componentes que não tem resultados
-	Ver como funcionam os filtros usando os parametros -dust e -seg do BLAST - consultar documentacao // considerar como opção avançada?
-	Verificar como vão funcionar as opções avançadas do BLAST - validar dados a serem executados como parametros e apenas adicionar no comando
-	tRNA: Remover "or" da primeira opção
-	Phobius: Marcar peptídeo sinal como padrão
-	Validar parametros no services do BLAST
-	Paginação: Resolver atualização do numero da pagina