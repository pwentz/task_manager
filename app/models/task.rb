class Task
  attr_reader :id,  :name,  :to_do
  def initialize(task_details)
    @id = task_details[:id]
    @name = task_details[:name]
    @to_do = task_details[:to_do]
  end
end
