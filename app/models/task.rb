class Task
  attr_reader :id, :name, :to_do
  def initialize(id, name, to_do)
    @id = id
    @name = name
    @to_do = to_do
  end
end
