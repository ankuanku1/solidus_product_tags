require 'spec_helper'

RSpec.describe SolidusProductTags::Tag, type: :model do
  subject { described_class.new(name: 'Summer') }

  describe 'validations' do
    it 'is valid with a unique name' do
      expect(subject).to be_valid
    end

    it 'is invalid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end


    it 'is valid with a very long name (up to 255 characters)' do
      subject.name = 'A' * 255
      expect(subject).to be_valid
    end

    it 'is invalid if name exceeds 255 characters' do
      subject.name = 'A' * 256
      expect(subject).not_to be_valid
    end

    it 'is valid with special characters in the name' do
      subject.name = '💥🔥#Trend-2025!'
      expect(subject).to be_valid
    end

    it 'trims leading and trailing whitespace from the name' do
      subject.name = '  Trendy  '
      subject.save!
      expect(subject.reload.name).to eq('Trendy') if subject.name.respond_to?(:strip)
    end

    it 'is valid with numbers in the name' do
      subject.name = 'Fall 2025'
      expect(subject).to be_valid
    end

    it 'is valid with SQL-like input' do
      subject.name = "Robert'); DROP TABLE tags;--"
      expect(subject).to be_valid
    end
  end

  describe 'persistence' do
    it 'saves and persists correctly' do
      expect { subject.save! }.to change { described_class.count }.by(1)
      expect(described_class.last.name).to eq('Summer')
    end
  end
end
