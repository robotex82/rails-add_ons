require 'rails_helper'

RSpec.describe Api::ResourcesController::ConditionParser do
  describe 'deep nested conditions' do
    subject { described_class.new(Post, 'foo', { 'bar' => { 'baz' => 'qux' } }).condition_statement }

    it { expect(subject).to eq({ 'foo' => { 'bar' => { 'baz' => 'qux' }}}) }
  end

  describe 'nested conditions' do
    subject { described_class.new(Post, 'code_type', {'identifier(eq)' => 'foo' }).condition_statement }

    it { expect(subject).to eq({ 'code_type' => { 'identifier' => 'foo' }}) }
  end

  describe 'simple conditions' do
    subject { described_class.new(Post, 'title(eq)', 'foo').condition_statement }

    it { expect(subject).to eq(["posts.title = ?", 'foo']) }
  end

  describe 'dot conditions using table name' do
    subject { described_class.new(Post, 'users.email(eq)', 'foo').condition_statement }

    it { expect(subject).to eq(["users.email = ?", 'foo']) }
  end

  describe 'dot conditions using underscored class name' do
    subject { described_class.new(Post, 'user.email(eq)', 'foo').condition_statement }

    it { expect(subject).to eq(["users.email = ?", 'foo']) }
  end
end
