guard :bundler, cmd: 'bundler install --path vendor/bundle' do
  watch('Gemfile')
end

guard :rspec, all_after_pass: true, all_on_start: true, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})        { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')     { 'spec' }
  watch(%r{^spec/support/.+\.rb$}) { 'spec' }
end

guard :rubocop do
  watch('Rakefile')
  watch('Guardfile')
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
