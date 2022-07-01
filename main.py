from redminelib import Redmine
import json

ListaObjetosTarefas = []

#region Classes
class Configuracao:
    def __init__(self, RedmineUrl, RedmineKey, IdProjeto, IdVersao, Agent, NomeVersao, Status, Categoria, Prioridade, DataInicial, DataFinal):
        self.RedmineUrl = RedmineUrl
        self.RedmineKey = RedmineKey
        self.IdProjeto = IdProjeto
        self.IdVersao = IdVersao
        self.Agent = Agent
        self.NomeVersao = NomeVersao
        self.Status = Status
        self.Categoria = Categoria
        self.Prioridade = Prioridade
        self.DataInicial = DataInicial
        self.DataFinal = DataFinal

class Tarefa:
    def __init__(self, Name, Subject, Description, Status, Priority, Tracker, Parent, Custom):
        self.nome = Name
        self.assunto = Subject
        if Description > '':
            self.descricao = Description
        else:
            self.descricao = Subject
        self.status = Status
        self.prioridade = Priority
        self.tipo = Tracker
        self.tarefaprincipal = Parent
        self.custom = Custom
#end Classes

#region Config
with open(r"C:\Users\ildo.banaseski\Desktop\Tarefas\ExecutarTarefas\Config.json", 'r', encoding="utf-8") as f:
    ConfiguracaoJson = json.load(f)

configuracao = Configuracao(
    RedmineUrl = ConfiguracaoJson['RedmineUrl'],
    RedmineKey = ConfiguracaoJson['RedmineKey'],
    IdProjeto = ConfiguracaoJson['IdProjeto'],
    IdVersao = ConfiguracaoJson['IdVersao'],
    Agent = ConfiguracaoJson['Agent'],
    NomeVersao = ConfiguracaoJson['NomeVersao'],
    Status = ConfiguracaoJson['Status'],
    Categoria = ConfiguracaoJson['Categoria'],
    Prioridade = ConfiguracaoJson['Prioridade'],
    DataInicial = ConfiguracaoJson['DataInicial'],
    DataFinal = ConfiguracaoJson['DataFinal']
)
#end Config

ID = 'id'
NAME = 'name'
VALUE = 'value'

#region Custom
def CF_GetVersaoFinalizacao():
    return {ID: 62,
          NAME: 'Versão Finalização',
         VALUE: configuracao.NomeVersao}
def CF_GetDocumentacaoIndefinida():
    return {ID: 33,
          NAME: 'Ajuda',
         VALUE: 'Documentação indefinida'}
def CF_GetIntervencao():
    return {ID: 73,
          NAME: 'Intervenção',
         VALUE: '0'}
def CF_GetAntecipado():
    return {ID: 144,
          NAME: 'Antecipado',
         VALUE: 'Não'}
def CF_GetDLLHistoria():
    return {ID: 71,
          NAME: 'DLL',
         VALUE: '0'}
def CF_GetTamanhoEstimado():
    return {ID: 127,
          NAME: 'Tamanho estimado',
         VALUE: 'P'}

def getCustom():
    return [
        CF_GetVersaoFinalizacao(),
        CF_GetDocumentacaoIndefinida(),
        CF_GetIntervencao(),
        CF_GetAntecipado(),
        CF_GetDLLHistoria(),
        CF_GetTamanhoEstimado()
    ]         
#end Custom

redmine = Redmine(configuracao.RedmineUrl, key = configuracao.RedmineKey)

#region CriarTarefa
def CriarTarefa(tarefa, save = False):
    issue = redmine.issue.new()
    issue.project_id            = configuracao.IdProjeto
    issue.subject               = tarefa['Name']
    issue.description           = tarefa['Description']
    issue.status_id             = configuracao.Status
    issue.priority_id           = configuracao.Prioridade
    issue.assigned_to_id        = configuracao.Agent
    issue.category_id           = configuracao.Categoria
    issue.fixed_version_id      = configuracao.IdVersao
    issue.start_date            = configuracao.DataInicial
    issue.due_date              = configuracao.DataFinal
    issue.tracker_id            = tarefa['Tracker']
    issue.custom_fields         = getCustom()
    issue.parent_issue_id       = tarefa['Parent']
    print('Executou', tarefa['Name'])
    if save:
        issue.save()
#end CriarTarefa

#region Tarefa
with open(r"C:\Users\ildo.banaseski\Desktop\Tarefas\ExecutarTarefas\Tarefas.json", 'r', encoding="utf-8") as f:
    ListaTarefas = json.load(f)

for tarefa in ListaTarefas:
    CriarTarefa(tarefa, True)
#end Tarefa