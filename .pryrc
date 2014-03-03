
# $ gem install pry-theme
# https://github.com/kyrylo/pry-theme-collection
# $ cd ~/.pry/themes
# $ wget https://raw2.github.com/kyrylo/pry-theme-collection/master/ocean/ocean.prytheme.rb
# $ pry
# $ pry-theme install ocean
Pry.config.theme = 'ocean'

# Custom prompt
prompt = "ruby-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
Pry.config.prompt = [
  proc { |obj, nest_level, _| "#{prompt} (#{obj}):#{nest_level} > " },
  proc { |obj, nest_level, _| "#{prompt} (#{obj}):#{nest_level} * " }
]

# Default Command Set, add custom methods here:
default_command_set = Pry::CommandSet.new do
  command 'copy', 'Copy to clipboard' do |str|
    str = "#{_pry_.input_array[-1]}#=> #{_pry_.last_result}\n" unless str
    IO.popen('pbcopy', 'r+') { |io| io.puts str }
    output.puts "-- Copy to clipboard --\n#{str}"
  end
end

# https://github.com/michaeldv/awesome_print/
# $ gem install awesome_print
begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts value.ai(:indent => 2) }
rescue LoadError => e
  warn "[WARN] #{e}"
  puts '$ gem install awesome_print'
end

Pry.config.commands.import(default_command_set)

