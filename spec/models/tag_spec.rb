require 'spec_helper'

RSpec.describe SolidusProductTags::Tag, type: :model do
  subject { described_class.new(name: 'Summer') }

  it 'is valid with a unique name' do
    expect(subject).to be_valid
  end

  it 'is invalid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:name]).to include("can't be blank")
  end

  it 'saves and persists correctly' do
    expect { subject.save! }.to change { described_class.count }.by(1)
    expect(described_class.last.name).to eq('Summer')
  end
end

