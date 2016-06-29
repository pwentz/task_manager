require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_creates_a_task
    task_manager.create(:name => "Cook", :to_do =>"Cook food")
    task = task_manager.find(task_manager.all.count)

    assert_equal 1, task_manager.all.count
    assert_equal "Cook", task.name
    assert_equal "Cook food", task.to_do
    assert_instance_of TaskManager::Task, task
  end

  def test_edits_a_task
    task_manager.create(:name => "Mow", :to_do => "mow the front lawn")
    task = task_manager.find(1)

    assert_equal "Mow", task.name
    assert_equal "mow the front lawn", task.to_do
    
    task_manager.update(1, :name => "Feed")
    
    assert_equal "Feed", task.name
    assert_equal "mow the front lawn", task.to_do
  end
end
