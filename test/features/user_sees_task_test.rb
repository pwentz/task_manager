require_relative '../test_helper'
class UserSeesTaskTest < FeatureTest
  def test_user_sees_index_of_tasks
    task_one = task_manager.create(
      :name => "coding is cool",
      :to_do => "I know it's cool"
    )

    #As a user,
    # when I visit the tasks index,
    visit '/tasks'
    # then I should see a list of my tasks
    within(".list-group-item h4") do
      assert page.has_content?("coding is cool")
    end
  end

  def test_user_can_click_shit
    visit '/'
    click_link "Add a new task"
    assert_equal "/tasks/new", current_path
    fill_in "task[name]", with: "new task"
    fill_in "task[to_do]", with: "new to do"
    click_button("add to tasks")
    assert_equal "/tasks", current_path
  end

  def test_user_can_click_on_tasks
    visit '/'
    click_link 'Add a new task'
    fill_in "task[name]", with: "I'm a task!"
    fill_in "task[to_do]", with: "capybara is fun"
    click_button("add to tasks")
    click_link("I'm a task!")

    assert_equal "/tasks/1", current_path

    within("p") do
      assert page.has_content?("capybara is fun")
    end
  end
end
