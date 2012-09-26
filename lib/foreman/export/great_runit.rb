require "erb"
require "foreman/export"

class Foreman::Export::GreatRunit < Foreman::Export::Base

  def export_template(name, file=nil, template_root=nil)
    name_without_first = name.split("/")[1..-1].join("/")
    matchers = []
    matchers << File.join(options[:template], name_without_first) if options[:template]
    matchers << File.expand_path("~/.foreman/templates/#{name}")
    matchers << File.expand_path("../../../../data/export/#{name}", __FILE__)
    File.read(matchers.detect { |m| File.exists?(m) })
  end

  def export
    super
    
    engine.each_process do |name, process|

      process_directory = "#{app}-#{name}"

      create_directory process_directory
      create_directory "#{process_directory}/env"
      create_directory "#{process_directory}/log"

      write_template "great-runit/run.erb", "#{process_directory}/run", binding
      chmod 0755, "#{process_directory}/run"

      write_template "great-runit/finish.erb", "#{process_directory}/finish", binding
      chmod 0755, "#{process_directory}/finish"

      write_template "great-runit/tools.erb", "#{process_directory}/tools", binding
      chmod 0755, "#{process_directory}/tools"

      engine.env.each do |key, value|
        write_file "#{process_directory}/env/#{key}", value
      end

      write_template "great-runit/log/run.erb", "#{process_directory}/log/run", binding
      chmod 0755, "#{process_directory}/log/run"
    end

  end

end
