require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    context 'with all required fields filled out' do
      it 'successfully creates a user' do
        @new_user = User.create(
          first_name: 'First',
          last_name: 'Last',
          email: 'tester@example.com',
          password: 'pass',
          password_confirmation: 'pass'
        )
        expect(@new_user.errors.full_messages).to eql([])
      end
    end

    context 'without a password field' do
      it 'returns an error' do
        @new_user = User.create(
          first_name: 'First',
          last_name: 'Last',
          email: 'tester@example.com',
          password_confirmation: 'pass'
        )
        expect(@new_user.errors.full_messages).to include("Password can't be blank")
      end
    end

    context 'without a password_confirmation field' do
      it 'returns an error' do
        @new_user = User.create(
          first_name: 'First',
          last_name: 'Last',
          email: 'tester@example.com',
          password: 'pass'
        )
        expect(@new_user.errors.full_messages).to eql(["Password confirmation can't be blank"])
      end
    end

    context 'without a matching password and password_confirmation field' do
      it 'returns an error' do
        @new_user = User.create(
          first_name: 'First',
          last_name: 'Last',
          email: 'tester@example.com',
          password: 'pass',
          password_confirmation: 'not_pass'
        )
        expect(@new_user.errors.full_messages).to eql(["Password confirmation doesn't match Password"])
      end
    end

    context 'If an email field already exists in the database' do
      it 'returns an error' do
        @new_user1 = User.create(
          first_name: 'First',
          last_name: 'Last',
          email: 'exists@example.com',
          password: 'pass',
          password_confirmation: 'pass'
        )
        @new_user2 = User.create(
          first_name: 'First',
          last_name: 'Last',
          email: 'EXISTS@example.com',
          password: 'pass',
          password_confirmation: 'pass'
        )
        expect(@new_user2.errors.full_messages).to eql(["Email has already been taken"])
      end
    end

    context 'without a email field' do
      it 'returns an error' do
        @new_user = User.create(
          first_name: 'First',
          last_name: 'Last',
          password: 'pass',
          password_confirmation: 'pass'
        )
        expect(@new_user.errors.full_messages).to eql(["Email can't be blank"])
      end
    end

    context 'without a first_name field' do
      it 'returns an error' do
        @new_user = User.create(
          last_name: 'Last',
          email: 'tester@example.com',
          password: 'pass',
          password_confirmation: 'pass'
        )
        expect(@new_user.errors.full_messages).to eql(["First name can't be blank"])
      end
    end

    context 'without a last_name field' do
      it 'returns an error' do
        @new_user = User.create(
          first_name: 'First',
          email: 'tester@example.com',
          password: 'pass',
          password_confirmation: 'pass'
        )
        expect(@new_user.errors.full_messages).to eql(["Last name can't be blank"])
      end
    end

    context 'with a password less that 4 characters long' do
      it 'returns an error' do
        @new_user = User.create(
          first_name: 'First',
          last_name: 'Last',
          email: 'tester@example.com',
          password: 'bad',
          password_confirmation: 'bad'
        )
        expect(@new_user.errors.full_messages).to eql(["Password is too short (minimum is 4 characters)"])
      end
    end
  end

  describe '.authenticate_with_credentials' do
    context 'with a correct email & password' do
      it('returns the user successfully') do
        @new_user = User.create(
          first_name: 'First',
          last_name: 'Last',
          email: 'tester@example.com',
          password: 'pass',
          password_confirmation: 'pass'
        )
        expect(User.authenticate_with_credentials('tester@example.com', 'pass')).to eql(@new_user)
      end
    end

    context 'with an email that does not exist' do
      it('returns nil') do
        @new_user = User.create(
          first_name: 'First',
          last_name: 'Last',
          email: 'tester@example.com',
          password: 'pass',
          password_confirmation: 'pass'
        )
        expect(User.authenticate_with_credentials('new_fake_email@example.com', 'pass')).to eql(nil)
      end
    end

    context 'with an incorrect password' do
      it('returns nil') do
        @new_user = User.create(
          first_name: 'First',
          last_name: 'Last',
          email: 'tester@example.com',
          password: 'pass',
          password_confirmation: 'pass'
        )
        expect(User.authenticate_with_credentials('tester@example.com', 'wrong_pass')).to eql(nil)
      end
    end

  end

end