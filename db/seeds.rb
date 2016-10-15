# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

estados = Estado.create([
                            {sigla: 'AC', nome: 'ACRE'},
                            { sigla: 'AL', nome: 'ALAGOAS'},
                            { sigla: 'AP', nome: 'AMAPÁ'},
                            { sigla: 'AM',  nome: 'AMAZONAS'},
                            { sigla: 'BA',  nome: 'BAHIA'},
                            { sigla: 'CE',  nome: 'CEARÁ'},
                            { sigla: 'DF', nome: 'DISTRITO FEDERAL'},
                            { sigla: 'ES', nome: 'ESPÍRITO SANTO'},
                            { sigla: 'GO', nome: 'GOIÁS'},
                            { sigla: 'MA', nome: 'MARANHÃO'},
                            { sigla: 'MT', nome: 'MATO GROSSO'},
                            { sigla: 'MS', nome: 'MATO GROSSO DO SUL'},
                            { sigla: 'MG', nome: 'MINAS GERAIS'},
                            { sigla: 'PA', nome: 'PARÁ'},
                            { sigla: 'PB', nome: 'PARAÍBA'},
                            { sigla: 'PR', nome: 'PARANÁ'},
                            { sigla: 'PE', nome: 'PERNAMBUCO'},
                            { sigla: 'PI', nome: 'PIAUÍ'},
                            { sigla: 'RJ', nome: 'RIO DE JANEIRO'},
                            { sigla: 'RN', nome: 'RIO GRANDE DO NORTE'},
                            { sigla: 'RS', nome: 'RIO GRANDE DO SUL'},
                            { sigla: 'RO', nome: 'RONDONIA'},
                            { sigla: 'RR', nome: 'RORAIMA'},
                            { sigla: 'SC', nome: 'SANTA CATARINA'},
                            { sigla: 'SP', nome: 'SÃO PAULO'},
                            { sigla: 'SE', nome: 'SERGIPE'},
                            {sigla: 'TO',  nome: 'TOCANTINS'},
                        ])
