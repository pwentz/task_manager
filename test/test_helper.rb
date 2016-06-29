ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'launchy'

module TestHelpers
  def teardown
    task_manager.delete_all
    super
  end

  def task_manager
    if ENV['RACK_ENV'] == 'test'
      task_database = YAML::Store.new("to_do/task_list_test")
    else
      task_database = YAML::Store.new("to_do/task_list")
    end
    @manager ||= TaskManager.new(task_database)
  end
end

Capybara.app = TaskManagerApp 

class FeatureTest < Minitest::Test
  include TestHelpers
  include Capybara::DSL
end
