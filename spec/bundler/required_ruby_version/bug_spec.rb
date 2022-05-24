# frozen_string_literal: true

RSpec.describe Bundler::RequiredRubyVersion::Bug do
  it "has a version number" do
    expect(Bundler::RequiredRubyVersion::Bug::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
