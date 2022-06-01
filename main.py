from redminelib import Redmine
import json

OBJETO = {
    "status": {
        "desenvolvimento": "x",
        "sprint backlog": "x",
        "pronto": "x"
    },
    "prioridade": {
        "crítica": "x",
        "alta": "x",
        "baixa": "x"
    },
    "tipo": {
        "atividade": "x",
        "história": "x",
        "análise técnica": "x",
        "desenvolvimento": "x",
        "teste funcional": "x",
        "refatoração": "x",
        "regra negócio": "x",
        "teste unitário": "x"
    }
}

PROJETO = "x"
AGENTE = "x"
PRODUTO = "x"

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
def CF_GetCustomFieldX(Versao):
    return {ID: 'x',
          NAME: 'Custom Field x',
         VALUE: Versao['name']}
def CF_GetCustomFieldY():
    return {ID: 'x',
          NAME: 'Custom Field y',
         VALUE: 'Custom Field y'}
def CF_GetCustomFieldZ():
    return {ID: 'x',
          NAME: 'Custom Field z',
         VALUE: 'Custom Field z'}
#endregion

def getCustom2(Versao):
    return [
        CF_GetCustomFieldX(Versao),
        CF_GetCustomFieldY(),
        CF_GetCustomFieldZ()
    ]
        
def getCustomFields(Versao, Tamanho = 'P', DLL = '0'):
    return [
    {
        'ID': 'x',
        'NAME': 'Custom Field X',
        'VALUE': Versao[NAME]
    },
    {
        'ID': 'y',
        'NAME': 'Custom Field Y',
        'VALUE': 'Custom Field Y'
    },
    {
        'ID': 'z',
        'NAME': 'Custom Field Z',
        'VALUE': 'Custom Field Z'
    }]

# OBJETO[STATUS][DESENV]
def CriarTarefa(id, subject, description, status, priority, agent, category, version, initialdate, enddate, tracker, custom, parent_id = None, save = True):
            
    print(custom)

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

REDMINEKEY = "x"
REDMINEURL = 'https://redmine.questor.com.br'

redmine     = Redmine(REDMINEURL,
key         = REDMINEKEY)

VERSAO = {
    "id": "x",
    "name": "x"
}

class Tarefa:
    def __init__(self, assunto, descricao = '', tipo = 'desenvolvimento', tarefaprincipal = ''):
        self.assunto = assunto
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
        self.id = id
        self.status = status
        self.priority = priority
        self.agent = agent
        self.category = category
        self.version = version
        self.initialdate = initialdate
        self.enddate = enddate

with open("tarefas.json", 'r', encoding="utf-8") as f:
            tarefaJson = json.load(f)

contexto = Contexto(
    id = PROJETO,
    status = str(OBJETO[STATUS][DESENV]), 
    priority = OBJETO[PRIORIDADE][BAIXA], 
    agent = AGENTE,
    category = PRODUTO,
    version = VERSAO[ID],
    initialdate = "yyyy-mm-dd",
    enddate = "yyyy-mm-dd"
    )

# print(json.dumps(tarefaJson, indent=4, sort_keys=True))

for TarefaObjeto in tarefaJson:
    tarefa = tarefaJson[TarefaObjeto]
    tarefa = Tarefa(
                assunto = tarefa['Subject'],
                descricao = tarefa['Description'],
                tipo = tarefa['Tracker'],
                tarefaprincipal = tarefa['Parent'])

    CriarTarefa(
    id = PROJETO,
    subject = tarefa.assunto,
    description = tarefa.descricao,
    status = contexto.status,
    priority = contexto.priority,
    agent = contexto.agent,
    category = contexto.category,
    version = contexto.version,
    initialdate = contexto.initialdate,
    enddate = contexto.enddate,
    tracker =  OBJETO[TIPO][tarefa.tipo],
    custom = getCustom2(VERSAO)
)