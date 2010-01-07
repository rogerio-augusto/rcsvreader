spec = Gem::Specification.new do |s| 
  s.name = "csvreader"
  s.version = "0.1"
  s.author = "Daniel Quirino Oliveira"
  s.email = "daniel@nullability.org"
  s.homepage = "http://nullability.org"
  s.platform = Gem::Platform::RUBY
  s.summary = "Yet another CSV parser with CSV header validation, based on CCSV (http://github.com/fauna/ccsv/)."
  s.files = FileList["{bin,lib}/**/*"].to_a
  s.require_path = "lib"
  s.autorequire = "name"
  s.test_files = FileList["{test}/**/*"].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.add_dependency("ccsv", "0.1")
end
