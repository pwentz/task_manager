require_relative '../test_helper'
class UserEditsTaskTest < FeatureTest
  def test_user_can_edit_tasks
    visit '/'
    click_link 'Add a new task'
    fill_in "task[name]", with: "I'm a task!"
    fill_in "task[to_do]", with: "capybara is fun"
    click_button("add to tasks")
    
    within(".list-group-item h4") do
      assert page.has_content?("I'm a task!")
    end

    click_link("Edit")

    assert_equal "/tasks/1/edit", current_path

    fill_in "task[name]", with: "I'm a(n edited) task!"
    click_button("Submit")

    within(".list-group-item h4") do 
      refute page.has_content?("I'm a task!")
      assert page.has_content?("I'm a(n edited) task!")
    end
  end
end
