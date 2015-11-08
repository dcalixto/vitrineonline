# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Vitrineonline::Application.initialize!

# ERROR MESSAGE
ActionView::Base.field_error_proc = proc do |html_tag, instance|
  errors = Array(instance.error_message).join(',')
  %(#{html_tag}<span class="validation-error">&nbsp;#{errors}</span>).html_safe
end
