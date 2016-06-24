require 'yaml/store'
class TaskManager
  attr_reader :task_database
  def initialize(task_database)
    @task_database = task_database
  end

  def create(task)
    task_database.transaction do
      task_database['tasks'] ||= []
      task_database['tasks_left'] ||= 0
      task_database['tasks_left'] += 1
      task_database['tasks'] << {:id => task_database['tasks_left'], :name => task[:name], :to_do => task[:to_do]}
    end
  end

  def isolate_tasks
    task_database.transaction do
      task_database['tasks'] ||= []
    end
  end

  Task = Struct.new(:id, :name, :to_do)

  def all
    isolate_tasks.map{|task_details| Task.new(task_details[:id], task_details[:name], task_details[:to_do])}
  end

  def find(task_name)
    all.find {|task| task_name == task.name}
  end
end
