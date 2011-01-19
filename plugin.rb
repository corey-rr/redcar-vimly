
Plugin.define do
  name    "Vimly"
  version "1.0"
  file    "lib", "vimly"
  object  "Redcar::Vimly"
  dependencies "application",">0",
               "runnables"  ,">0",
               "ruby"       ,">0"
end