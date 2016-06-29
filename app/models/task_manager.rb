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
      task_database['tasks'] << new_task({:id => task_database['tasks_left'], :name => task[:name], :to_do => task[:to_do]})
    end
  end

  Task = Struct.new(:id, :name, :to_do)

  def new_task(task_details)
    Task.new(task_details[:id], task_details[:name], task_details[:to_do])
  end
  
  def all
    task_database.transaction do
      task_database['tasks'] ||= []
    end
  end

  def find(id)
    all.find{|task| id == task.id}
  end

  def update(id, task)
    task_database.transaction do
      require 'pry'; binding.pry
      dated_task = task_database['tasks'].find{|task|task.id == id}
      dated_task.name = task[:name] unless task[:name].nil?
      dated_task.to_do = task[:to_do] unless task[:to_do].nil?
    end
  end

  def destroy(id)
    task_database.transaction do
      task_database['tasks'].delete_if{|task|task.id == id}
    end
  end

  def delete_all
    task_database.transaction do
      task_database['tasks'].delete_if{|task|task.is_a?(Task)}
      task_database['tasks_left'] = 0
    end
  end
end
