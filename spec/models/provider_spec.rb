require 'spec_helper'

describe Provider do

  before do
    @provider = Provider.new(username: "Example User", email: "user@example.com", office_id: 1, role: 1, access: 1, password_digest: "adfkljdasadsdaadfaklk32kl", password: "foosbars", password_confirmation: "foosbars")
  end

  subject { @provider }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
	it { should respond_to(:office_id) }
  it { should respond_to(:role) }
  it { should respond_to(:access) }
	it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when username is not present" do
    before { @provider.username = " " }
    it { should_not be_valid }
  end

	describe "when username is too long" do
    before { @provider.username = "a" * 71 }
    it { should_not be_valid }
  end

  describe "when office is not present" do
    before { @provider.office_id = " " }
    it { should_not be_valid }
  end

  describe "when role is not present" do
    before { @provider.role = " " }
    it { should_not be_valid }
  end

	  describe "when access is not present" do
    before { @provider.access = " " }
    it { should_not be_valid }
  end
	
	describe "when email is not present" do
    before { @provider.email = " " }
    it { should_not be_valid }
  end

	describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @provider.email = invalid_address
        expect(@provider).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @provider.email = valid_address
        expect(@provider).to be_valid
      end
    end
  end
	
	  describe "when email address is already taken" do
    before do
      provider_with_same_email = @provider.dup
      provider_with_same_email.email = @provider.email.upcase
      provider_with_same_email.save
    end

    it { should_not be_valid }
  end

	describe "when password is not present" do
    before do
      @provider = Provider.new(username: "Example User", email: "user@example.com", office: 1, role: 1, access: 1, password_digest: "adfkljdasadsdaadfaklk32kl", password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @provider.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

	describe "with a password that's too short" do
    before { @provider.password = @provider.password_confirmation = "a" * 7 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @provider.save }
    let(:found_provider) { Provider.find_by(email: @provider.email) }

    describe "with valid password" do
      it { should eq found_provider.authenticate(@provider.password) }
    end

    describe "with invalid password" do
      let(:provider_for_invalid_password) { found_provider.authenticate("invalid") }

      it { should_not eq provider_for_invalid_password }
      specify { expect(provider_for_invalid_password).to be_false }
    end
  end

end