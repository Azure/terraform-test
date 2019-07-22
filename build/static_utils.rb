require 'colorize'
require 'fileutils'

def lint_tf
  # Do the linting on current working folder.
  print "INFO: Linting Terraform configurations...\n".yellow  
  message = `terraform validate >/dev/null`

  # Check the linting message.
  if not message.empty?
    raise "ERROR: Linting Terraform configurations failed!\n#{message}\n".red
  else
    print "INFO: Done!\n".green
  end
end

def style_tf
  # Do the style checking on current working folder.
  print "INFO: Styling Terraform configurations...\n".yellow  
  message = `terraform fmt -check 2>&1`

  # Check the styling message.
  if not message.empty?
    raise "ERROR: Styling Terraform configurations failed!\n#{message}\n".red
  else
    print "INFO: Done!\n".green
  end
end

def format_tf
  # Apply the canonical format and style on current working folder.
  print "INFO: Formatting Terraform configurations...\n".yellow  
  message = `terraform fmt -diff 2>&1`

  # Check the styling message.
  if not message.empty?
    raise "ERROR: Formatting Terraform configurations failed!\n#{message}\n".red
  else
    print "INFO: Done!\n".green
  end
end