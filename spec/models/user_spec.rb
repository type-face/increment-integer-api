# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'should validate postitive incrementer' do
      expect(User.new(email: 'test123@example.com', password: 'password123', incrementer: 1).valid?).to be true
    end
    it 'should invalidate negative incrementer' do
      user = User.new(incrementer: -1)
      user.valid?
      expect(user.errors.messages[:incrementer]).to include 'must be greater than or equal to 0'
    end
  end
end
