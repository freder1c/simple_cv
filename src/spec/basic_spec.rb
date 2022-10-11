# frozen_string_literal: true

RSpec.describe SimpleCV::Basic do
  let(:current_working_dir) { File.expand_path(File.dirname(__FILE__)) }
  let(:config_file_path) { File.join(current_working_dir, "..", "examples", "example.#{config_file_type}") }
  let(:config_file_type) { "json" }

  subject { SimpleCV::Basic.new(config_file_path).render_file }

  after(:each) do
    path = File.join(current_working_dir, "..", "SimpleCV.pdf")
    File.delete(path) if File.exist?(path)
  end

  it "renders pdf file with json config file" do
    expect(subject).to eq("/app/SimpleCV.pdf")
  end

  context "when config file type is yml" do
    let(:config_file_type) { "yml" }

    it "should render pdf file" do
      expect(subject).to eq("/app/SimpleCV.pdf")
    end
  end
end
