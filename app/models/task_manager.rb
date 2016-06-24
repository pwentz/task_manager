require 'yaml/store'
class TaskManager
  attr_reader :task_database
  def initialize(task_database)
    @task_database = task_database
  end

  Task = Struct.new(:id, :name, :to_do)

  def create(task)
    task_database.transaction do
      task_database['tasks'] ||= []
      task_database['tasks_left'] ||= 0
      task_database['tasks_left'] += 1
      new_task = Task.new(task_database['tasks_left'], task[:name], task[:to_do])
      task_database['tasks'] << new_task
    end
  end

  def isolate_tasks
    task_database.transaction do
      task_database['tasks'] ||= []
    end
  end

  def all
    isolate_tasks.find_all{|task|task.is_a?(Task)}
  end

  def find(task_name)
    all.find {|task| task_name == task.name}
  end
end
