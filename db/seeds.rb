puts '************ Persistindo dados na base **********************************'

rebase_company = Company.create!(name: 'Rebase Tecnologia', 
                                 address: 'Rua Alameda Santos, 45',
                                 domain: 'rebase')

rebase_company.logo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'logo_compass.png')), 
                           filename: 'logo_compass.png')


User.create!(email: 'paulo@rebase.com', password: '123456',
                            company: rebase_company)

Job.create!(title: 'Dev. Júnior', 
            description: 'Desenvolvedor ruby on rails',
            income: '3000,00', level: 'Júnior', 
            limit_date: Date.current + 1.day,
            quantity: 5, company: rebase_company)

Job.create!(title: 'Dev. Pleno', 
            description: 'Desenvolvedor javascript',
            income: '4500,00', level: 'Pleno', 
            limit_date: Date.current + 10.day,
            quantity: 2, company: rebase_company)

Job.create!(title: 'Analista de PO', 
            description: 'Ajudar nos processos de melhoria de produtos',
            income: '3700,00', level: 'Pleno', 
            limit_date: Date.current + 5.day,
            quantity: 1, company: rebase_company)

vindi_company = Company.create!(name: 'Vindi Serviços de Pagamentos', 
                                address: 'Av. Paulista, 250',
                                domain: 'vindi')
                                
vindi_company.logo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'logo_aviao.png')),
                          filename: 'logo_aviao.png')

User.create!(email: 'maria@vindi.com', password: '111111',
                            company: vindi_company)

Job.create!(title: 'Desenvolvedor C#', 
            description: 'Dev. C# com SQL Server',
            income: '3200,00', level: 'Júnior', 
            limit_date: Date.current + 1.day,
            quantity: 7, company: vindi_company)

Job.create!(title: 'Tech Lead Full Stack', 
            description: 'Dev. com experiência em gerenciamento de times',
            income: '9200,00', level: 'Sênior', 
            limit_date: Date.current + 1.day,
            quantity: 1, company: vindi_company)

Candidate.create!(email: 'cleber@gmail.com', 
                  password: '222222', 
                  full_name: 'Cleber Feltrin',
                  biography: 'Tenho experiência de 5 anos em programação web',
                  birth_date: '22/01/1983')

Candidate.create!(email: 'lucas@gmail.com', 
                  password: '333333', 
                  full_name: 'Lucas Cassolari',
                  biography: 'Desenvolvedor back end na stack Microsoft',
                  birth_date: '01/11/1999')

puts '************ Registros realizados com sucesso ***************************'
















