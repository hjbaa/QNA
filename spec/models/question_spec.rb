# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'Associations' do
    it { should have_many(:answers) }
    it { should have_many(:answers).dependent(:destroy) }
    it { should belong_to(:author).optional(true) }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
  end
end
