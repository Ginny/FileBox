# Load the rails application
require File.expand_path('../application', __FILE__)

#Formatting DateTime to look like "20/01/2011 10:28PM"  
Time::DATE_FORMATS[:default] = "%d/%m/%Y %l:%M%p"  
    
# Initialize the rails application
Filebox::Application.initialize!
