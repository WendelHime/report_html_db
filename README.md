# report\_html\_db
Projeto de iniciação científica, componente utilizado para gerar site(com conteúdo dinâmico) baseado nos resultados de componentes utilizados anteriormente

Para instalar dependencias:

sudo apt-get install sqlite3

cpan DBIx::Class Catalyst::Devel Catalyst::Runtime Catalyst::View::TT Catalyst::View::JSON Catalyst::Model::DBIC::Schema  DBIx::Class::Schema::Loader MooseX::NonMoose Helper::ResultSet::SetOperations

Para rodar:

bigou\_m.pl -c html\_db.cnf -d database\_name -u username\_database -p password -h address -o output\_dir

Inicialize o servidor:

./Test/script/test\_server.pl -r
  
Acesse o site:

http://127.0.0.1:3000


TODO:
- 

Dev:
-
-	Formulario TMHMM analyses
-	Checar todas as etapas de anotação e ver se falta alguma outra interface a ser feita.

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
-	Alienhunter, Terminator, RBS: 3 colunas(dos resultados) e link para sequência
-	tRNA: Bug exibindo tudo quando não existe
-	Analyses of protein coding genes: 
-	não esta mostrando erro caso não encontra nada
-	Busca por identificador do orthology não esta funcionando
-	Transporter: Não mostra se esta vazio


-	Remover redundancia de inserções e correções de textos da pagina SearchDatabase
-	Atualizar SearchDatabaseRepository, SearchDatabase do Services e search-database.js
-	Blast services esta com caminhos fixos para o banco de dados
-	Criar arquivo unificado de sequencias separando pelos tipos para geração do makeblastdb
-	Adicionar valor absoluto para pegar arquivos para download
-	Paginar resultados de tabelas
-	Script deve gerar arquivos fasta de CDS(done); ribosomal RNA; transferRNA; other non coding;
-	Atualizar LIMIT e OFFSET nas pesquisas tandemRepeats, transcriptionalTerminators, ribosomalBindingSites, horizontalGeneTransfers, ncRNA no SearchDatabaseRepository, SearchDatabaseController do services  e no SearchDatabaseController do website
-	All-genes: colocar reverso complementar e colocar todos os genes(e não somente CDS)
-	Protein-coding genes para CDS
-	Alinhar sequencia de nucleotídeos
-       Arquivos das análises de DNA
-       tRNA: Adicionar link do arquivo
-       Arquivos das analises estão linkados no SQLite, criar função para acesso e link para baixar 
-       Adicionar opção de selecionar contig em pesquisas de gene
-	Preparar SearchDatabase do website, search-database.js e site-client.js para searchGene
-       Global analyses:
-       Go mapping: expansible tree
-       KEGG pathways: link errado
-       Criar pagina de erro geral
-	Corrigir report\_html\_db.pl, parte do script de download; Site.pm 275
-	sequencia esta bugada, adicionar div col-md-12
-       correção porra do numero da paginação não reseta
-   "annotation\_signalP.pl" => 'SignalP' adicionar tudo do signalp
-	Correção de global analyses, acesso a arquivos internos

-	Opção tblastn não funciona (query proteína e o db é nucleotídica) e tblastx também não.
-	Botão "Clear sequence" não funciona
-	Tratar adequadamente qualquer caractere do cabeçalho de uma sequência FASTA
-	TMHMM - Predicted TMHs  -> Predicted Transmembrane domains
-	Contig: All (default)
-	Gene type deve ser Gene predictor
-	No resultado da busca, informar total de resultados. Ao lado do Back:   Found 49 results.
-	Em tRNA, rever gene name. Aponta Gly???
-	annotation\_predgpi: 
-        Dados gerais: start, end, strand
-        Dados de regiões com resultados positivos: name, position, specificity, sequence 
-	annotation\_bigpi: 
-        Dados gerais: start, end, strand
-        Dados de regiões com resultados positivos: pvalue, position
-	annotation\_dgpi.pl: 
-        Dados: start, end, strand, score, cleavage_site
-	Onde estão os resultados do RNAmmer? Tem que fazer um formulário.