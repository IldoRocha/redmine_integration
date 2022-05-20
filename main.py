from importlib_metadata import version
from redminelib import Redmine
import datetime
import json

OBJETO = {
    "status": {
        "desenvolvimento": 36,
        "sprint backlog": 54,
        "pronto": 60
    },
    "prioridade": {
        "crítica": 1,
        "alta": 2,
        "baixa": 3
    },
    "tipo": {
        "atividade": 49,
        "história": 102,
        "análise técnica": 106,
        "desenvolvimento": 107,
        "teste funcional": 108,
        "refatoração": "?",
        "regra negócio": "?",
        "teste unitário": "?"
    }
}

PROJETOQUIU = 587
AGENTEQUIU = 1834
PRODUTOQUIU = 34446

STATUS = "status"
DESENV = "desenvolvimento"
BACKLOG = "sprint backlog"

PRIORIDADE = "prioridade"
BAIXA = "baixa"
ALTA = "alta"

TIPO = "tipo"
ATIVIDADE = "atividade"
HISTORIA = "história"
ANALISETECNICA = "análise técnica"
TESTE = "teste"
REFATORACAO = "refatoração"
REGRANEGOCIO = "regra negócio"
TDD = "teste unitário"

ID = 'id'
NAME = 'name'
VALUE = 'value'
REDMINE = 'https://redmine.questor.com.br'

#region GetCustomFields
def CF_GetVersaoFinalizacao(Versao):
    return {ID: 62,
          NAME: 'Versão Finalização',
         VALUE: Versao['name']}
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
#endregion

def getCustom2(Versao):
    return [
        CF_GetVersaoFinalizacao(Versao),
        CF_GetDocumentacaoIndefinida(),
        CF_GetIntervencao(),
        CF_GetAntecipado(),
        CF_GetDLLHistoria(),
        CF_GetTamanhoEstimado()
    ]


def getCustomFields(Versao, Tamanho = 'P', DLL = '0'):
    return [
    {
        'ID': 62,
        'NAME': 'Versão Finalização',
        'VALUE': Versao[NAME]
    },
    {
        'ID': 33,
        'NAME': 'Ajuda',
        'VALUE': 'Documentação indefinida'
    },
    {
        'ID': 73,
        'NAME': 'Intervenção',
        'VALUE': '0'
    },
    {
        'ID': 144,
        'NAME': 'Antecipado',
        'VALUE': 'Não'
    },
    {
        'ID': 71,
        'NAME': 'DLL',
        'VALUE': DLL
    },
    {
        'ID': 127,
        'NAME': 'Tamanho estimado',
        'VALUE': Tamanho
    }]

# OBJETO[STATUS][DESENV]
def CriarTarefa(id, subject, description, status, priority, agent, category, version, initialdate, enddate, tracker, custom, parent_id = None, save = True):
    issue = redmine.issue.new()
    issue.project_id            = id
    issue.subject               = subject
    issue.description           = description
    issue.status_id             = status
    issue.priority_id           = priority
    issue.assigned_to_id        = agent
    issue.category_id           = category
    issue.fixed_version_id      = version
    issue.start_date            = initialdate
    issue.due_date              = enddate
    issue.tracker_id            = tracker
    issue.custom_fields         = custom
    issue.parent_issue_id       = parent_id
    if save:
        issue.save()

REDMINEKEY = "7191d4dd9cc2fa5270a8335db1945ed75c3a6f89"
REDMINEURL = 'https://redmine.questor.com.br'

redmine     = Redmine(REDMINEURL,
key         = REDMINEKEY)

VERSAO = {
    "id": 4824,
    "name": "999.999.999.999"
}

class Tarefa:
    def __init__(
        self, 
        assunto, 
        descricao = '', 
        tipo = 'desenvolvimento', 
        tarefaprincipal = None):
        self.assunto = assunto,
        if descricao > '':
            self.descricao = descricao
        else:
            self.descricao = assunto
        self.tipo = tipo
        self.tarefaprincipal = tarefaprincipal

class Contexto:
    def __init__(
        self,
        id,
        status,
        priority,
        agent,
        category,
        version,
        initialdate,
        enddate):
        self.id = id,
        self.status = status,
        self.priority = priority,
        self.agent = agent,
        self.category = category,
        self.version = version,
        self.initialdate = initialdate,
        self.enddate = enddate

tarefaJson = json.load("tarefas.json")

for tarefaItem in tarefaJson:
    tarefa = Tarefa(assunto = tarefaItem['assunto'],
                descricao = tarefaItem['descrucai'],
                tipo = tarefaItem['tipo'],
                tarefaprincipal = tarefaItem['tarefaprincipal'])

contexto = Contexto(
    id = PROJETOQUIU,
    status = OBJETO[STATUS][DESENV], # OBJETO[STATUS][DESENV] | OBJETO[STATUS][BACKLOG]     priority = OBJETO[PRIORIDADE][BAIXA], # OBJETO[STATUS][ALTA] | OBJETO[STATUS][BAIXA],
    priority = OBJETO[PRIORIDADE][BAIXA], # OBJETO[STATUS][ALTA] | OBJETO[STATUS][BAIXA],
    agent = AGENTEQUIU,
    category = PRODUTOQUIU,
    version = VERSAO[ID],
    initialdate = datetime.date(2022, 5, 6),
    enddate = datetime.date(2022, 5, 19))

CriarTarefa(
    #parentid = '2081918',
    id = PROJETOQUIU,
    subject = tarefa.assunto,
    description = tarefa.descricao,
    status = contexto.status,
    priority = contexto.priority,
    agent = contexto.agent,
    category = contexto.category,
    version = contexto.version,
    initialdate = contexto.initialdate,
    enddate = contexto.enddate,
    tracker = tarefa.tipo,
    # custom = getCustomFields(VERSAO, Tamanho = "")    
    custom = getCustom2(VERSAO)
)