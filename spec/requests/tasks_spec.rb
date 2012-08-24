require "spec_helper"

describe "Manage tasks", js: true do

  before(:each) do
    user = create(:user)
    @task = create(:task, user: user, completed: false)
    @tasks = [@task, create(:task, user: user), create(:task, user: user)]
    log_in_via_browser(user)
  end

  it "adds task" do
    task = attributes_for(:task)
    expect{
      within "#new_task" do
        fill_in "title", with: task[:title]
        fill_in "due_date", with: task[:due_date]
        click_button "Add"
      end
    }.to change(Task, :count).by(1)

    page.should have_content(task[:title])
  end

  it "deletes task" do
    expect{
      click_button "Delete"
      alert = page.driver.browser.switch_to.alert
      alert.accept
      wait_until{ page.has_no_content?(@task.title) }
    }.to change(Task, :count).by(-1)
  end

  it "starts edition of task" do
    click_button "Edit"
    find_button("Update").should be_visible
    find_button("Cancel").should be_visible
  end

  it "cancels editions of task" do
    click_button "Edit"
    click_button "Cancel"
    find_button("Update").should_not be_visible
    find_button("Cancel").should_not be_visible
  end

  it "updates task" do
    click_button "Edit"
    within "#task#{@task.id}" do
      fill_in "title", with: "Changed title"
      click_button "Update"
    end
    @task.reload
    @task.title.should eq("Changed title")
  end

  it "mark task as completed" do
    within "#task#{@task.id}" do
      click_button "Done"
    end
    @task.reload
    @task.completed.should be_true
  end

  it "sort tasks by due date" do
    find("#sort-date").click
    titles = []
    all(".edit-section").each{ |t| titles << t.find_field("title").value }
    titles.should eq(@tasks.sort_by{ |t| -t.due_date.to_i }.map(&:title))
  end

  it "sort tasks by priority" do
    find("#sort-priority").click
    titles = []
    all(".edit-section").each{ |t| titles << t.find_field("title").value }
    titles.should eq(@tasks.sort_by{ |t| -t.priority_before_type_cast.to_i }.map(&:title))
  end
end