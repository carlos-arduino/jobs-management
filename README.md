# Desenvolvedor Caê Arduino 

Neste documento irei atualizando o status dos requisitos conforme caderno
de obrigação enviado pela Campus Code.

## Prioridades

Adianto que estou priorizando o back-end e desenvolvendo as funcionalidades
e testes de acordo com a ordem natural dos requisitos do caderno, sendo elas:

[X] Colaborador cria uma conta usando e-mail da empresa

[X] Colaborador preenche informações da empresa

[X] Colaborador cadastra uma vaga de emprego

[ ] Visitante visualiza empresas e vagas

[ ] Visitante se candidata para uma vaga

[ ] Colaboradores recebem candidaturas

[ ] Candidato acompanha suas candidaturas

[ ] Vaga é desativada automaticamente


## Secundários

Em virtude do curto do prazo de entrega (21/02/2021) estou focalizando meus esforços
nas coberturas dos testes e requisitos básicos, tentando deixar a aplicação mais
próximo da sua total funcionalidade.
Sendo assim, alguns requisitos secundários - considerados por mim :-) - serão encaixados no
final.

[ ] Upload de logo

[ ] Inserir seletores :css de precisão em todos os testes vinculados ao id de cada tag div

[ ] Bootstrap 

[ ] Internacionalização 

## Algumas ponderações

[ ] Possibilidade de deletar empresa no modo cascata para models dependentes??? Possível quebra de integridade no model Domain de acordo com arquitetura do schema.

[ ] Até o momento desabilitado feature 'remover inscrição do model USER'. Pois de acordo com sobrecarga no método destroy do RegistrationController irá apagar da tabela Domain a linha referente ao domínio vinculado ao email do usuário deletado.


