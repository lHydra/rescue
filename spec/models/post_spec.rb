require 'rails_helper'

RSpec.describe Post, type: :model do 
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should belong_to(:user) }
end
