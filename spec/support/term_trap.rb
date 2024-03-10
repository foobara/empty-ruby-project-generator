Signal.trap("TERM") do
  puts "SIGTERM received, printing backtrace:"
  puts caller.join("\n")
  exit
end
