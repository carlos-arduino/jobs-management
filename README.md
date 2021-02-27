# Desenvolvedor Caê Arduino 

Neste documento irei atualizando o status dos requisitos conforme caderno
de obrigação enviado pela Campus Code.

## Prioridades

Adianto que estou priorizando o back-end e desenvolvendo as funcionalidades
e testes de acordo com a ordem natural dos requisitos do caderno, sendo elas:

[X] Colaborador cria uma conta usando e-mail da empresa

[X] Colaborador preenche informações da empresa

[X] Colaborador cadastra uma vaga de emprego

[X] Visitante visualiza empresas e vagas

[X] Visitante se candidata para uma vaga

[X] Colaboradores recebem candidaturas

[X] Candidato acompanha suas candidaturas

[ ] Vaga é desativada automaticamente


## Secundários

Em virtude do curto do prazo de entrega (21/02/2021) estou focalizando meus esforços
nas coberturas dos testes e requisitos básicos, tentando deixar a aplicação mais
próximo da sua total funcionalidade.
Sendo assim, alguns requisitos secundários - considerados por mim :-) - serão encaixados no
final.

[ ] Upload de logo

[X] Inserir seletores :css de precisão em todos os testes vinculados ao id de cada tag div

[ ] Bootstrap 

[X] Internacionalização 

## Algumas ponderações

[ ] Possibilidade de deletar empresa no modo cascata para models dependentes??? Possível quebra de integridade no model Domain de acordo com arquitetura do schema.

[ ] Até o momento desabilitado feature 'remover inscrição do model USER'. Pois de acordo com sobrecarga no método destroy do RegistrationController irá apagar da tabela Domain a linha referente ao domínio vinculado ao email do usuário deletado.

## Gems utilizadas no desenvolvimento

* Devise - Gerenciamento de autenticação e autorização 
* Rspec-rails e Capybara - Testes de integração
* Rspec e Shoulda Matchers - Testes unitários

## Instruções para rodar
1. Clone o projeto
2. Na raiz do projeto rode o comando *bin/setup*
3. Execute o comando rails *db:migrate*
4. Execute o comando rails *db:seed*

## Registros criados no banco contidos no arquivo seeds.rb

### Empresas
* Rebase Tecnologia
* Vindi Serviços de Pagamentos

### Usuários Corporativos associados às empresas
* [Rebase] - **email:** paulo@rebase.com **password:** 123456
* [Vindi] - **email:** maria@vindi.com **password:** 111111

### Vagas de emprego criadas e associadas às empresas
* [Rebase] - 3 vagas -> Dev. Júnior, Dev. Pleno, Analista de PO
* [Vindi] - 2 vagas -> Desenvolvedor C#, Tech Lead Full Stack
*Nota: Todas as vagas são criadas com status ativo como default*

### Candidatos
* [Cleber] - **email:** cleber@gmail.com **password:** 222222
* [Lucas] - **email:** lucas@gmail.com **password:** 333333
 


