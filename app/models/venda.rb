class Venda < ActiveRecord::Base
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    type = "ActiveRecord::Type::#{sql_type.to_s.camelize}".constantize.new
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, type, null)
  end

  column :produto_id, :integer
  column :cliente_id, :integer
  column :quantidade, :integer
  column :valorVenda, :float

  column :tipo_pgt, :string
  column :num_cartao, :string
  column :validade_cartao, :string
  column :codigo_cartao, :string

  column :desconto, :float
end
