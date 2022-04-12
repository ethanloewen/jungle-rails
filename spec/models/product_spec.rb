require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'with all 4 required fields filled out' do
      it 'saves successfully' do
        @new_category = Category.create(name: 'Fridges')
        @new_product = @new_category.products.create(
          name:  'Big Fridge',
          price: 499.00,
          quantity: 10
        )
        expect(@new_product.errors.full_messages).to eql([])
      end
    end

    context 'without a name field' do
      it 'returns an error' do
        @new_category = Category.create(name: 'Fridges')
        @new_product = @new_category.products.create(
          price: 499.00,
          quantity: 10
        )
        expect(@new_product.errors.full_messages).not_to eql([])
      end
    end

    context 'without a price field' do
      it 'returns an error' do
        @new_category = Category.create(name: 'Fridges')
        @new_product = @new_category.products.create(
          name: 'Big Fridge',
          quantity: 10
        )
        expect(@new_product.errors.full_messages).not_to eql([])
      end
    end

    context 'without a quantity field' do
      it 'returns an error' do
        @new_category = Category.create(name: 'Fridges')
        @new_product = @new_category.products.create(
          name: 'Big Fridge',
          price: 499.00,
        )
        puts @new_product.errors.full_messages
        expect(@new_product.errors.full_messages).not_to eql([])
      end
    end

    context 'without a category field' do
      it 'returns an error' do
        @new_product = Product.create(
          name:  'Big Fridge',
          price: 499.00,
          quantity: 10
        )
        puts @new_product.errors.full_messages
        expect(@new_product.errors.full_messages).not_to eql([])
      end
    end
  end
end
