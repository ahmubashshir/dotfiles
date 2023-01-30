#!/usr/bin/ruby -w
#
#reads xspf file from stdin and writes it to stdout as m3u

require 'rexml/document'
include REXML

#xmlfile = File.new("vlc-playlist.xspf")
xmldoc = Document.new(STDIN)

# Now get the root element
root = xmldoc.root

xmldoc.elements.each("playlist/trackList/track") do |element|
	puts "#EXTINF:0,#{element.elements["title"].text}"
	puts "#{element.elements["location"].text}"
end
