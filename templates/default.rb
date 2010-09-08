db_gem_line = "gem '#{gem_for_database}'"
db_gem_line << ", :require => '#{require_for_database}'" if require_for_database
db_gem_regexp = Regexp::quote(db_gem_line).gsub("'", "['\"]")
jdbc_db = case options[:database]
          when /postgresql/
            "postgres"
          when /mysql2/
            "mysql"
          when /mysql|sqlite3/
            options[:database]
          end
jdbc_gem_line = "\n  gem 'jdbc-#{jdbc_db}', :require => false" if jdbc_db

gsub_file "Gemfile", /^#{db_gem_regexp}\w*$/, <<DB
if defined?(JRUBY_VERSION)
  gem 'activerecord-jdbc-adapter'#{jdbc_gem_line}
else
  #{db_gem_line}
end
DB

# Avoid MySQL2 option for Rails 3
if options[:database] =~ /mysql/
  gsub_file "config/database.yml", /mysql2/, 'mysql'
end
