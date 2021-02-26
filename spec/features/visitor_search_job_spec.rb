require 'rails_helper'

feature 'visitors can search for jobs and company' do
    scenario 'through description content' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        iugu_company = Company.create!(name: 'Iugu Pagamentos', 
                                       address: 'Avenida Paulista, 7',
                                       domain: 'iugu') 
        job_pleno = Job.create!(title: 'Dev. Pleno', 
                                description: 'Desenvolvedor ruby on rails',
                                income: '5300,00', level: 'Pleno', 
                                limit_date: Date.current + 2.day,
                                quantity: 5, 
                                company: rebase_company)
        job_senior = Job.create!(title: 'Dev. Sênior',
                                 description: 'Desenvolvedor C#',
                                 income: '7000,00', level: 'Sênior', 
                                 limit_date: Date.current + 3.day,
                                 quantity: 22, 
                                 company: rebase_company)
        job_another_domain = Job.create!(title: 'Dev. Júnior', 
                                         description: 'Desenvolvedor Javascript',
                                         income: '1500,00', level: 'Júnior', 
                                         limit_date: Date.current + 1.day,
                                         quantity: 13, 
                                         company: iugu_company)

        visit root_path
        click_on 'Visualizar Vagas'
        fill_in 'Busca:', with: 'C#'
        page.select rebase_company.name, from: 'Empresa:'
        click_on 'Pesquisar'

        expect(current_path).to eq(search_path)
        expect(page.find("#filter-job-#{job_senior.id}")).to have_content("Empresa: #{job_senior.company.name}")
        expect(page.find("#filter-job-#{job_senior.id}")).to have_content("Título: #{job_senior.title}")
        expect(page.find("#filter-job-#{job_senior.id}")).to have_content("Descrição: #{job_senior.description}")

        expect(page).not_to have_content("Título: #{job_pleno.title}")
        expect(page).not_to have_content("Descrição: #{job_pleno.description}")
        expect(page).not_to have_content("Título: #{job_another_domain.title}")
        expect(page).not_to have_content("Descrição: #{job_another_domain.description}")
    end

    scenario 'through title content' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase') 
        job_pleno = Job.create!(title: 'Dev. Pleno Ruby', 
                                description: 'Desenvolvedor ruby on rails',
                                income: '5300,00', level: 'Pleno', 
                                limit_date: Date.current + 2.day,
                                quantity: 5, 
                                company: rebase_company)
        job_senior = Job.create!(title: 'Analista de Teste', 
                                 description: 'Programador de testes',
                                 income: '7000,00', level: 'Sênior', 
                                 limit_date: Date.current + 3.day,
                                 quantity: 22, 
                                 company: rebase_company)
        job = Job.create!(title: 'Analista Pleno PO', 
                          description: 'Product Owner',
                          income: '1500,00', level: 'Júnior', 
                          limit_date: Date.current + 1.day,
                          quantity: 13, 
                          company: rebase_company)

        visit jobs_path
        fill_in 'Busca:', with: 'Pleno'
        page.select rebase_company.name, from: 'Empresa:'
        click_on 'Pesquisar'
        
        expect(page.find("#filter-job-#{job_pleno.id}")).to have_content("Título: #{job_pleno.title}")
        expect(page.find("#filter-job-#{job.id}")).to have_content("Título: #{job.title}")
        expect(page).not_to have_content("Título: #{job_senior.title}")
    end

    scenario 'through selected company filter' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        iugu_company = Company.create!(name: 'Iugu Pagamentos', 
                                       address: 'Avenida Paulista, 7',
                                       domain: 'iugu') 
        equal_content_rebase = Job.create!(title: 'Dev. Pleno', 
                                           description: 'Desenvolvedor ruby on rails',
                                           income: '5300,00', level: 'Pleno', 
                                           limit_date: Date.current + 2.day,
                                           quantity: 5, 
                                           company: rebase_company)
        equal_content_iugu = Job.create!(title: 'Dev. Pleno', 
                                         description: 'Desenvolvedor ruby on rails',
                                         income: '5300,00', level: 'Pleno', 
                                         limit_date: Date.current + 2.day,
                                         quantity: 5, 
                                         company: iugu_company)

        visit jobs_path
        fill_in 'Busca:', with: 'Pleno'
        page.select rebase_company.name, from: 'Empresa:'
        click_on 'Pesquisar'

        expect(page.find("#filter-job-#{equal_content_rebase.id}")).to have_content("Título: #{equal_content_rebase.title}")
        expect(page).not_to have_content("Empresa: #{equal_content_iugu.company.name}")
    end

    scenario 'and show message for not found job' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        iugu_company = Company.create!(name: 'Iugu Pagamentos', 
                                       address: 'Avenida Paulista, 7',
                                       domain: 'iugu') 
        job_pleno = Job.create!(title: 'Dev. Pleno', 
                                description: 'Desenvolvedor ruby on rails',
                                income: '5300,00', level: 'Pleno', 
                                limit_date: Date.current + 2.day,
                                quantity: 5, 
                                company: rebase_company)
        job_senior = Job.create!(title: 'Dev. Sênior', 
                                 description: 'Desenvolvedor C#',
                                 income: '7000,00', level: 'Sênior', 
                                 limit_date: Date.current + 3.day,
                                 quantity: 22, 
                                 company: rebase_company)
        job_another_domain = Job.create!(title: 'Dev. Júnior', 
                                         description: 'Desenvolvedor Javascript',
                                         income: '1500,00', level: 'Júnior', 
                                         limit_date: Date.current + 1.day,
                                         quantity: 13, 
                                         company: iugu_company)

        visit jobs_path
        fill_in 'Busca:', with: 'Cozinheiro'
        page.select rebase_company.name, from: 'Empresa:'
        click_on 'Pesquisar'
        
        expect(page).to have_content('Não foram encontradas vagas para essa pesquisa')
        expect(page).not_to have_content("Título: #{job_pleno.title}")
        expect(page).not_to have_content("Título: #{job_senior.title}")
        expect(page).not_to have_content("Título: #{job_another_domain.title}")
    end

    scenario 'and does not search for expired or inactivated jobs' do
        rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                         address: 'Rua Alameda Santos, 45',
                                         domain: 'rebase')
        job_inactive = Job.create!(title: 'Dev. Pleno', 
                                description: 'Desenvolvedor ruby on rails',
                                income: '5300,00', level: 'Pleno', 
                                limit_date: Date.current + 2.day,
                                quantity: 5,
                                status: :inactive, 
                                company: rebase_company)
        job_expired = Job.create!(title: 'Dev. Pleno', 
                                 description: 'Desenvolvedor C#',
                                 income: '7000,00', level: 'Pleno', 
                                 limit_date: '15/02/2021',
                                 quantity: 22, 
                                 company: rebase_company)

        visit jobs_path
        
        expect(page).to have_content('Sem vagas cadastradas até o momento')
        expect(page).not_to have_content('Pesquisar')
    end

end