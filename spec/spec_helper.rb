require 'validates_immutability'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

ActiveRecord::Schema.define(:version => 0) do
  create_table :widgets, :force => true do |t|
    t.string :attr1
    t.string :attr2
    t.string :attr3
  end
end