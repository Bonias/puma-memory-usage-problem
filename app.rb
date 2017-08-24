class App
  A = 'a'.freeze
  LONG_STRING = ENV['LONG_STRING'] == 'true'

  @@request_number = 0

  def self.call(env)
    if @@request_number == 0
      puts "Initial memory usage: #{memory_usage}"
    end

    print "Request ##{@@request_number += 1}: "
    10.times do |i|
      if LONG_STRING
        A * (1024 * 1024 * 50) # 50 MB
      else
        10_000.times.map { |i| A * i } # about 50 MB
      end

      print "#{memory_usage} > "
    end
    puts

    [200, {}, ['']]
  end

  def self.memory_usage
    `cat /proc/#{Process.pid}/status | grep VmRSS`.split(':').last.strip
  end
end
