require 'spec_helper'

describe Office do

  before do
    @office = Office.new(name: "The abc corporation", listed: 1)
  end

  subject { @office }

  it { should respond_to(:name) }
  it { should respond_to(:listed) }
	it { should respond_to(:status) }

  it { should be_valid }

  describe "when name is not present" do
    before { @office.name = " " }
    it { should_not be_valid }
  end

	describe "when name is too long" do
    before { @office.name = "a" * 141 }
    it { should_not be_valid }
  end

  describe "when listed is not present" do
    before { @office.listed = " " }
    it { should_not be_valid }
  end
end