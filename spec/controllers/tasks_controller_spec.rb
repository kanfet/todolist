require 'spec_helper'

describe TasksController do

  describe "GET #index" do

    before(:each) do
      user = create(:user)
      log_in user
      @tasks = []
      5.times do
        @tasks << create(:task, user: user)
      end
      @tasks.each{ |t| t.reload }

      other_user = create(:user)
      @tasks_of_other_user = []
      3.times do
        @tasks_of_other_user << create(:task, user: other_user)
      end
      @tasks_of_other_user.each{ |t| t.reload }
    end

    it "returns tasks of current user" do
      get :index, format: :json
      response.body.should eq(@tasks.to_json)
    end

    it "does not return tasks of another user" do
      get :index, format: :json
      returned_tasks = JSON.parse(response.body)
      returned_tasks.each do |t|
        @tasks_of_other_user.map{ |ot| ot.id }.should_not include(t['id'])
      end
    end

    context "when no sort params" do
      it "returns tasks ordered by id" do
        get :index, format: :json
        returned_tasks = JSON.parse(response.body)
        returned_tasks.map{ |t| t['id'] }.
            should eq(@tasks.sort_by(&:id).map(&:id))
      end
    end

    context "when 'date_sort' param is set" do
      it "returns tasks ordered by due date ascending and by id" do
        get :index, format: :json, date_sort: "asc"
        returned_tasks = JSON.parse(response.body)
        returned_tasks.map{ |t| t['id'] }.
            should eq(@tasks.sort_by{ |t| [t.due_date, t.id] }.map(&:id))
      end

      it "returns tasks ordered by due date descending and by id" do
        get :index, format: :json, date_sort: "desc"
        returned_tasks = JSON.parse(response.body)
        returned_tasks.map{ |t| t['id'] }.
            should eq(@tasks.sort_by{ |t| [-t.due_date.to_time.to_i, t.id] }.map(&:id))
      end
    end

    context "when 'priority_sort' param is set" do
      it "returns tasks ordered by priority ascending and by id" do
        get :index, format: :json, priority_sort: "asc"
        returned_tasks = JSON.parse(response.body)
        returned_tasks.map{ |t| t['id'] }.
            should eq(@tasks.sort_by{ |t| [t.priority_before_type_cast, t.id] }.map(&:id))
      end

      it "returns tasks ordered by priority descending and by id" do
        get :index, format: :json, priority_sort: "desc"
        returned_tasks = JSON.parse(response.body)
        returned_tasks.map{ |t| t['priority'] }.
            should eq(@tasks.sort_by{ |t| [-t.priority_before_type_cast.to_i, t.id] }.map(&:priority))
      end
    end

    context "when 'date_sort' and 'priority_sort' params are set" do
      it "returns tasks ordered by due date, priority and id" do
        get :index, format: :json, date_sort: "asc", priority_sort: "asc"
        returned_tasks = JSON.parse(response.body)
        returned_tasks.map{ |t| t['id'] }.
            should eq(@tasks.sort_by{ |t| [t.due_date, t.priority, t.id] }.map(&:id))
      end
    end
  end

  describe "POST #create" do
    context "when user is logged in" do
      before(:each) do
        @user = create(:user)
        log_in @user
      end

      context "with valid attributes" do
        it "saves new task in database" do
          expect{
            post :create, task: attributes_for(:task)
          }.to change(Task, :count).by(1)
        end

        it "returns saved task as json" do
          task = attributes_for(:task)
          post :create, task: task, format: :json
          returned_task = JSON.parse(response.body)
          returned_task["title"].should eq(task[:title])
          returned_task["priority"].should eq(task[:priority])
          returned_task["due_date"].to_date.should eq(task[:due_date].to_date)
        end

        it "saves new task in database with current user's id" do
          post :create, task: attributes_for(:task), format: :json
          JSON.parse(response.body)["user_id"].should eq(@user.id)
        end
      end

      context "with invalid attributes" do
        it "does not save new task in database" do
          expect{
            post :create, task: attributes_for(:invalid_task)
          }.to_not change(Task, :count)
        end

        it "returns errors as json" do
          post :create, task: attributes_for(:invalid_task), format: :json
          JSON.parse(response.body)["errors"].should_not be_nil
        end
      end
    end

    context "when user is not logged in" do
      it "does not save new task in database" do
        expect{
          post :create, task: attributes_for(:task)
        }.to_not change(Task, :count)
      end

      it "returns errors as json" do
        post :create, task: attributes_for(:task), format: :json
        JSON.parse(response.body)["errors"].should_not be_nil
      end
    end
  end

  describe "PUT #update" do
    context "when user is logged in" do
      before(:each) do
        @user = create(:user)
        log_in @user
      end

      context "with valid attributes" do

        it "changes task's attributes" do
          task = create(:task, user: @user)
          put :update, id: task, task: attributes_for(:task, title: "Changed title")
          task.reload
          task.title.should eq("Changed title")
        end

        it "does not change other user's task's attributes" do
          task_of_other_user = create(:task, user: create(:user))
          put :update, id: task_of_other_user, task: attributes_for(:task, title: "Changed title")
          task_of_other_user.reload
          task_of_other_user.title.should_not eq("Changed title")
        end
      end
    end

    context "when user is not logged in" do
      it "does not change task's attributes" do
        task = create(:task)
        put :update, id: task, task: attributes_for(:task, title: "Changed title")
        task.reload
        task.title.should_not eq("Changed title")
      end
    end
  end

  describe "DELETE #destroy" do

    context "when user is logged in" do
      before(:each) do
        @user = create(:user)
        log_in @user
      end

      it "deletes task" do
        task = create(:task, user: @user)
        expect{
          delete :destroy, id: task
        }.to change(Task, :count).by(-1)
      end

      it "does not delete task of other user" do
        task_of_other_user = create(:task, user: create(:user))
        expect{
          delete :destroy, id: task_of_other_user
        }.to_not change(Task, :count)
      end
    end

    context "when user is not logged in" do
      it "does not delete task" do
        task = create(:task)
        expect{
          delete :destroy, id: task
        }.to_not change(Task, :count)
      end
    end
  end
end
