$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rsaucecrud/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rsaucecrud"
  s.version     = Rsaucecrud::VERSION
  s.authors     = ["Nitza Alfinas"]
  s.email       = ["nitzaalfinas@gmail.com"]
  s.homepage    = "https://nitzaalfinas.com"
  s.summary     = "A plugin that is use to create controller, form and display the data"
  s.description = "A plugin that is use to create controller, form and display the data"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"
end
