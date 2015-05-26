require 'spec_helper'

describe Category do
  it 'saves new category' do
    category = Category.new(name: 'New Category')
    category.save
    expect(Category.first.name).to eq 'New Category'
  end

  it 'is invalid without a name' do
    category = Category.new(name: nil)
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end

  it 'has a unique name' do
    Category.create(name: 'New Category')
    category = Category.new(name: 'New Category')
    category.valid?
    expect(category.errors[:name]).to include("has already been taken")
  end
end
