require "spec_helper"

RSpec.describe SimpleCV::Basic do

  let(:current_working_dir) { File.expand_path(File.dirname(__FILE__)) }

  after(:each) do
    path = File.join(current_working_dir, "..", "SimpleCV.pdf")
    expect(File.exist?(path)).to be true
    File.delete(path)
  end

  it "renders pdf file with json config file" do
    SimpleCV::Basic.new(config_path: File.join(current_working_dir, "..", "examples", "example.json")).render_file
  end

  it "renders pdf file with yml config file" do
    SimpleCV::Basic.new(config_path: File.join(current_working_dir, "..", "examples", "example.json")).render_file
  end

end
