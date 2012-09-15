HH = '#' * 22 unless defined?(HH)
H = '#' * 5    unless defined?(H)

def usage
  puts <<-EOS
  Ctrl-\\ or ctrl-4   Running all tests
  Ctrl-C             Exit
  EOS
end

def separator
  puts "#{HH} #{Time.now} #{HH}"
end

def run(cmd)
  separator
  puts "#{H} #{cmd}"
  system "/usr/bin/time --format '#{HH} Elapsed time %E' #{cmd}"
end

def run_test_file(file)
  run(%Q(ruby -I"lib:test" -rubygems #{file}))
end

def run_all_tests
  puts "\n#{HH} Running all tests #{HH}\n"
  run "rake"
end

def related_test_files(base)
  files = Dir['test/**/*.rb'].select { |file| file =~ /#{base}_test.rb/ }
  files.map {|tf| run_test_file(tf) }
end

watch('test/.*_test\.rb')    { |m| run_test_file(m[0]) }
watch('lib/.*\.rb')          { run_all_tests }
watch('test/test_helper.rb') { run_all_tests }


# Ctrl-\ or ctrl-4
Signal.trap('QUIT') { run_all_tests }

# Ctrl-C
Signal.trap('INT') { abort("Interrupted\n") }

usage
