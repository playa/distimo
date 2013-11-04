source 'https://rubygems.org'

gem 'rake'
gem 'yard'

group :development do
  gem 'pry'
  gem 'pry-rescue'
  gem 'pry-stack_explorer', :platforms => :mri_19
  gem 'pry-debugger', :platforms => :mri_19
end

group :test do
  gem 'rspec', '>= 2.14'
  gem 'simplecov', :require => false
  gem 'timecop', '0.6.1'
  gem 'webmock'
end

# Specify your gem's dependencies in distimo.gemspec
gemspec
