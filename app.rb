require 'json'

class App
  @@request_number = 0

  def self.call(env)
    if @@request_number == 0
      puts "Initial memory usage: #{memory_usage}"
    end

    print "Request ##{@@request_number += 1}: "
    10.times do |i|
      JSON.parse(File.read('file.json'))
      print "#{memory_usage} > "
    end
    puts

    [200, {}, ['']]
  end

  def self.memory_usage
    `cat /proc/#{Process.pid}/status | grep VmRSS`.split(':').last.strip
  end
end
