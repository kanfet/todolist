require 'spec_helper'

describe Task do

  describe "valid task" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:due_date) }
    it { should validate_presence_of(:priority) }
    it { should validate_presence_of(:user_id) }
  end

  describe "#priority_options" do
    it "should return 'priority' options as hash(key => label)" do
      options = Task.priority_options
      options.should be_an_instance_of Hash
      options.length.should eq(Task.priority.values.length)
    end
  end
end
