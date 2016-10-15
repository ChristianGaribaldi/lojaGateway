class Cliente < ActiveRecord::Base
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    type = "ActiveRecord::Type::#{sql_type.to_s.camelize}".constantize.new
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, type, null)
  end

  column :nome, :string
  column :cpf, :string
  column :email, :string
  column :rua, :string
  column :numero, :integer
  column :bairro, :string
  column :cidade, :string
  column :estado,:string
  column :cep, :string

end
