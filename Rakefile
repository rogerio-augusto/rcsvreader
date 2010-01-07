require 'rubygems'
require 'rake/gempackagetask'


spec = Gem::Specification.new do |s| 
  s.name = "rcsvreader"
  s.version = "0.1"
  s.author = "Daniel Quirino Oliveira"
  s.email = "daniel@nullability.org"
  s.homepage = "http://github.com/danielqo/rcsvreader"
  s.platform = Gem::Platform::RUBY
  s.summary = "Yet another CSV parser with CSV header validation, based on CCSV (http://github.com/fauna/ccsv/)."
  s.files = FileList["{lib}/**/*"].to_a
  s.require_path = "lib"
  s.autorequire = "name"
  s.test_files = FileList["{test}/**/*"].to_a
  s.add_dependency("ccsv", "0.1")
end

Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_tar = true
end

task :default => "pkg/#{spec.name}-#{spec.version}.gem" do
    puts "generated latest version"
end
