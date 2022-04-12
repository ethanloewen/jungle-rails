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
        expect(@new_user.errors.full_messages).to eql(["Password can't be blank"])
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

  end
end