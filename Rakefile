task :default do
  Rake::Task["build"].invoke
  Rake::Task["play"].invoke
end

task :build do
  puts `mxmlc -o _bin/game.swf -source-path="#{Dir.pwd}" -default-size=700,420 "#{Dir.pwd}/Game.as"`
end

task :play do
  `open -a "Flash Player" _bin/game.swf`
end
