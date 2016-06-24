class Task
  attr_reader :title, :to_do, :id
  def initialize(task_details)
    @title = task_details[:title]
    @to_do = task_details[:to_do]
    @id = task_details[:id]
  end
end
