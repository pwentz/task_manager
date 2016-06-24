require_relative 'task'
require 'yaml/store'
class TaskManager
  attr_reader :task_database
  def initialize(task_database)
    @task_database = task_database
  end

  def create(task)
    task_database.transaction do
      task_database['tasks'] ||= []
      task_database['total'] ||= 0
      task_database['total'] += 1
      task_database['tasks'] << {:id => task_database['total'].to_i, :title => task[:title], :to_do => task[:to_do]}
    end
  end

  def isolate_task_instances
    task_database.transaction do
      task_database['tasks'] ||= []
    end
  end

  def all
    isolate_task_instances.map {|task_details| Task.new(task_details)}
  end

  def find(task_name)
    all.find{|task| task.title == task_name}
  end
end
