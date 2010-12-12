namespace :netzke do    
  desc 'Clears netzke cache.'
  task :clear => :environment do
    sql = ActiveRecord::Base.connection();
    sql.execute "TRUNCATE `netzke_field_lists`";
    sql.execute "TRUNCATE `netzke_preferences`";
  end
end
