require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
end

#  Benchmark
#-----------------------------------------------
desc "Compare with pure ruby"
task :benchmark do
  require "benchmark/ips"
  require "kasen"
  require "kasen"

  puts "ruby version: #{RUBY_VERSION}"
  puts "Kasen version: #{Kasen::VERSION}"


  Benchmark.ips do |x|
    x.report('Pure Ruby') { [1, 2, 3].map { |n| n + 1 } }
    x.report('Kasen')     { [1, 2, 3].map &k.+(1) }

    x.compare!
  end
end
task bm: :benchmark

task :default => :test
