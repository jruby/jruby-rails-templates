
desc "Copy latest templates to ../jruby.org repo if it exists"
task :default do
  if File.exists?("../jruby.org/www")
    cp_r FileList["*.rb", "templates"], "../jruby.org/www"
  end
end
