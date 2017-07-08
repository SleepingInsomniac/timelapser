require 'thread'

class Capturer

  attr_reader :save_path, :capture_count, :folder

  def initialize(interval: 1.0, save_to: '~/Pictures/timelapses', folder_format: '%Y%m%dT%H%M%S', delete_screenshots: false)
    @capture_count = 0
    @interval = interval
    @folder = Time.now.strftime(folder_format)
    @save_path = File.expand_path File.join(save_to, @folder)
    @running = false
    @delete_screenshots = delete_screenshots
  end

  def capture(count)
    start
    loop until @capture_count == count
    stop
  end

  def start
    return false if running?
    @running = true
    system "mkdir -p #{@save_path}"
    puts "Saving to #{@save_path}"
    run_capture_loop!
  end

  def stop
    return false unless running?
    @thread.exit
    working_path = Dir.pwd
    Dir.chdir @save_path
    puts 'Stitching images...'
    stitch
    puts 'Done!'
    Dir.chdir working_path
    @running = false
  end

  def running?
    @running
  end

  private

  def run_capture_loop!
    @thread = Thread.new do
      loop do
        take_screenshot
        sleep @interval
      end
    end
  end

  def take_screenshot
    @capture_count += 1
    file_name = "#{@capture_count.to_s.rjust(5, '0')}.png"
    out = `screencapture -mx #{@save_path}/#{file_name}`
    if $?.success?
      cols = `tput cols`.to_i
      msg = "#{(@capture_count / 30.0).round(2).to_s.rjust(10, ' ')}s - #{file_name}"
      print "\r#{msg}".ljust(cols, ' ')
    else
      puts "Error! #{file_name}: #{out}"
    end
  end

  def stitch
    `ffmpeg -r 30 -i '%05d.png' #{@folder}.mp4 2> /dev/null`
    if $?.success?
      File.rm_rf "*.png" if @delete_screenshots
    else
      puts "Stitching failed!"
    end
  end

end
