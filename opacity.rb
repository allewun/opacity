#!/usr/bin/env ruby

require 'optparse'

#============================================================================
# Helper methods
#============================================================================

def parse_color(input)
  if (input.size == 3)
    r, g, b = input
    return [r, g, b] if r.valid_rgb? && g.valid_rgb? && b.valid_rgb?
  end
end

def color_string(input)
  return "rgb(#{input.map { |x| x.to_i }.join(', ')})"
end

class Float
  def valid_rgb?
    return self.between?(0,255)
  end
end


#============================================================================
# Parse command line options
#============================================================================

options = {}

optparse = OptionParser.new do |opts|
  opts.on('-a', '--alpha N', Float, 'Alpha opacity granularity (defaults to 0.01)') do |a|
    options[:a] = a
  end
  opts.on('-b', '--background R,G,B', Array, 'Specify background color') do |b|
    options[:b] = parse_color(b.map { |x| x.to_f })
  end
  opts.on('-o', '--overlay R,G,B', Array, 'Specify overlay (blended) color') do |o|
    options[:o] = parse_color(o.map { |x| x.to_f })
  end
  opts.on('-h', '--help', 'Show the help screen') do
    puts opts
    exit
  end
end.parse!


#============================================================================
# Run
#============================================================================

if (options[:b].nil? || options[:o].nil?)
  puts "Invalid or missing colors."
else
  rgb_bg      = options[:b]
  rgb_overlay = options[:o]
  alpha_granularity = (options[:a].nil?) ? 100 : 1.0/options[:a]
  round = Math.log10(alpha_granularity).to_i + 1

  puts
  puts "Overlay/blended color:\n  #{color_string(options[:o])}\n\n"
  puts "Background color:\n  #{color_string(options[:b])}"
  puts
  puts "Possible foreground colors:"
  puts "---------------------------"

  (1..(alpha_granularity.to_i)).each do |alpha|
    a = alpha.to_f/alpha_granularity.to_f

    r_fg = (rgb_overlay[0] - (1-a)*rgb_bg[0]) / a
    g_fg = (rgb_overlay[1] - (1-a)*rgb_bg[1]) / a
    b_fg = (rgb_overlay[2] - (1-a)*rgb_bg[2]) / a

    if (r_fg.valid_rgb? && g_fg.valid_rgb? && b_fg.valid_rgb?)
      puts "rgba(#{r_fg.round(0)}, #{g_fg.round(0)}, #{b_fg.round(0)}, #{a.round(round)})"
    end
  end
end
