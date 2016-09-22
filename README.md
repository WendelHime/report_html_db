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
-	Finalizar pesquisa por descrição de gene


Selecionar pelo gene ID

select distinct f.feature_id, ps.value 
from feature f 
join feature_relationship r on (f.feature_id = r.object_id) 
join cvterm cr on (r.type_id = cr.cvterm_id) 
join featureprop ps on (r.subject_id = ps.feature_id) 
join cvterm cs on (ps.type_id = cs.cvterm_id) 
join featureloc l on (l.feature_id = f.feature_id) 
join featureprop pl on (l.srcfeature_id = pl.feature_id) 
join cvterm cp on (pl.type_id = cp.cvterm_id) 
where cr.name = 'based_on' and cs.name = 'locus_tag' and cp.name = 'pipeline_id' and 
pl.value='$pipeline' and ps.value like '%$param->{'geneID'}%' order by ps.value

Selecionar gene pela descrição

select distinct f.feature_id, ps.value, pd.value 
from feature f 
join feature_relationship r on (f.feature_id = r.object_id)
join cvterm cr on (r.type_id = cr.cvterm_id)
join featureprop ps on (r.subject_id = ps.feature_id)
join cvterm cs on (ps.type_id = cs.cvterm_id)
join featureprop pf on (f.feature_id = pf.feature_id)
join cvterm cf on (pf.type_id = cf.cvterm_id)
join featureloc l on (l.feature_id = f.feature_id)
join featureprop pl on (l.srcfeature_id = pl.feature_id)
join cvterm cp on (pl.type_id = cp.cvterm_id) 
join featureprop pd on (r.subject_id = pd.feature_id) 
join cvterm cd on (pd.type_id = cd.cvterm_id) 
where cr.name = 'based_on' and cf.name = 'tag' and pf.value='CDS' and cs.name = 'locus_tag' and cd.name = 'description' and cp.name = 'pipeline_id' and 
pl.value='$pipeline' and 
