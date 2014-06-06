# ============================================
# pry config
# ============================================
Pry.config.pager = false
Pry.config.editor = 'vim'
Pry.config.history.should_save = true
Pry.config.history.file = '~/.pry_history'
Pry.config.hooks.add_hook(:after_session, :say_bye!) { puts "bye" }

## prompt
#prompt = "ruby-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
#Pry.config.prompt = [
  #proc { |obj, nest_level, _| "#{prompt} (#{obj}):#{nest_level} > " },
  #proc { |obj, nest_level, _| "#{prompt} (#{obj}):#{nest_level} * " }
#]
# wrap ANSI codes so Readline knows where the prompt ends
def colour(name, text)
  if Pry.color
    "\001#{Pry::Helpers::Text.send name, '{text}'}\002".sub '{text}', "\002#{text}\001"
  else
    text
  end
end

# pretty prompt
Pry.config.prompt = [
  proc do |object, nest_level, pry|
    prompt = colour(:yellow, "ruby-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}(#{Pry.view_clip(object)})")
    #prompt  = colour :bright_black, Pry.view_clip(object)
    #prompt += ":#{nest_level}" if nest_level > 0
    prompt += colour :cyan, ' >> '
  end, proc { |object, nest_level, pry| colour :cyan, '>> ' }
]

# ============================================
# awesome_print
# https://github.com/michaeldv/awesome_print/
# $ gem install awesome_print
# ============================================
begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError
  puts 'awesome_print not available :('
end

# ============================================
# hirb
# ============================================
begin
  require 'hirb'
  old_print = Pry.config.print
  Pry.config.print = proc do |output, value|
    Hirb::View.view_or_page_output(value) || old_print.call(output, value)
  end
  Hirb.enable
rescue LoadError
  puts 'hirb not available :('
end

# ============================================
## awesome settings
# ============================================

# Toys methods
# See https://gist.github.com/807492
class Array
  def self.toy(n = 10, &block)
    block_given? ? Array.new(n, &block) : Array.new(n){ |i| i + 1 }
  end
end

class Hash
  def self.toy(n = 10)
    Hash[Array.toy(n).zip(Array.toy(n){ |c| (96 + (c + 1)).chr })]
  end
end

