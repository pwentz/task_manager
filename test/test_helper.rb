ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'minitest/autorun'
require 'minitest/pride'

module TestHelpers
  def teardown
    task_manager.delete_all
    super
  end

  def task_manager
    database = YAML::Store.new('to_do/task_manager_test')
    @database ||= TaskManager.new(database)
  end

end
