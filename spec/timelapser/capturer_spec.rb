require "spec_helper"

RSpec.describe Capturer do
  it 'works' do
    c = Capturer.new(save_to: 'tmp/', interval: 0.0)
    c.capture(10)
    loop until not c.running?
    expect(c.capture_count).to eq(10)
    expect(File.exists?("#{c.save_path}/#{c.folder}.mp4")).to be_truthy
    expect(File.size("#{c.save_path}/#{c.folder}.mp4")).not_to eq(0)
    system "rm -rf #{c.save_path}"
  end
end
