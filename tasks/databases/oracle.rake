namespace :oracle do
  desc 'Build the Oracle test databases'
  task :build_databases do 
    puts File.join(SCHEMA_PATH, 'oracle.sql')
    options_str = connection_string
    sh %( sqlplus #{options_str} < #{File.join(SCHEMA_PATH, 'oracle.sql')} )
  end

  desc 'Drop the Oracle test databases'
  task :drop_databases => :load_connection do 
    puts File.join(SCHEMA_PATH, 'oracle.drop.sql')
    options_str = connection_string
    sh %( sqlplus #{options_str} < #{File.join(SCHEMA_PATH, 'oracle.drop.sql')} )
  end

  desc 'Rebuild the Oracle test databases'
  task :rebuild_databases => [:drop_databases, :build_databases]
  
  def connection_string
    spec = CompositePrimaryKeys::ConnectionSpec[:oracle]
    "#{spec['username'']}/#{spec['password']}@#{spec['host']}"
  end
end
