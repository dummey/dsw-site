require 'spec_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to belong_to(:submission).touch(true) }
end
