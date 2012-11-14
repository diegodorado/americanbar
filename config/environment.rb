
# At the top of environment.rb, set your default encodings:
Encoding.default_external = Encoding.default_internal = Encoding::UTF_8

# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.action_controller.session = {
    :session_key => '_netzke-demo_session',
    :secret      => '61fcd38cf02513e1068fe72f607302d81cd8f996b6b5a091127cb2de074bf0bc3a9c5b913e72236b658a95c942af65aa60e26d26ea89d4bda15b213db880914f'
  }
  config.action_controller.session_store = :active_record_store  
end


class Date 
  class << self 
    def _parse_with_danish_format(date, now = Time.now) 
      if (match_data = date.strip.match(/^(\d{1,2})\/(\d{1,2})\/(\d{4})$/)) 
        {:mday => match_data[1].to_i, 
         :mon => match_data[2].to_i, 
         :year => match_data[3].to_i} 
      else 
        _parse_without_danish_format(date, now) 
      end 
    end 
    alias_method_chain :_parse, :danish_format 
  end 
end

CalendarDateSelect.format = :danish
CalendarDateSelect.default_options.update(:locale => 'es')



