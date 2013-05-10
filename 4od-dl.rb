#Written by Mike Worth
#http://www.mike-worth.com/2012/11/19/a-script-to-download-4od/
#https://github.com/MikeWorth

require 'hpricot'
require 'open-uri'

#First lookup the programme, list available if not found
begin
  showid=ARGV.first#TODO sanitise
  doc = Hpricot(open('http://www.youtube.com/show/'+showid))
  serieslinks=doc.search("[@class~='playlists-wide']").search("[@class~='yt-uix-tile-link']")
  series=Hash.new
  serieslinks.each do |serieslink|
    series[serieslink.inner_text.strip.match(/Season ([0-9]*) Episodes/)[1]]=serieslink.attributes['href']#TODO what if there are playlists that we don`t get a match for
  end
rescue
  puts 'Show not found, available shows:'
  begin
    doc = Hpricot(open('http://www.youtube.com/user/4oD'))
    shows=doc.search("[@class='channel-summary-list']").search("[@class='yt-uix-tile-link']")
    shows.each do |showlink|
      puts showlink.inner_text.strip + '	' + showlink.attributes['href'].gsub('/show/','') + "\n"
    end
  rescue
    puts 'Error fetching listings'
  end
  Kernel::exit
end

#Then the series and episode, list available if not found
begin
  class NoSeries<StandardError; end
  class NoEpisode<StandardError; end#TODO are these the best way to handle this?
  raise NoSeries if ARGV[1].nil?
  seriesid=ARGV[1]#TODO sanitise
  seriespage=Hpricot(open('http://www.youtube.com'+series[seriesid]))
  episodelinks=seriespage.search("[@class~='playlist-landing']").search("[@class~='yt-uix-tile-link']")
  raise NoEpisode if ARGV[2].nil?
  episodeid=ARGV[2].to_i#TODO sanitise
  episodehref=episodelinks[episodeid-1].attributes['href']
  episodeyid=episodehref.to_s.match(/v=([a-zA-Z0-9\-_]{11})&/)[1]
rescue
  begin
    series.sort.each do |s|
      puts 'Series '+s[0]+':'
      seriespage=Hpricot(open('http://www.youtube.com'+s[1]))
      episodelinks=seriespage.search("[@class~='playlist-landing']").search("[@class~='yt-uix-tile-link']")
      i=1
      episodelinks.each do |es|
        puts '  '+i.to_s+': '+es.inner_text.strip
        i+=1
      end
    end
  rescue
    puts 'Error fetching listings'
  end  
  Kernel::exit
end

#Now actually download it:
puts 'Downloading: ' + episodelinks[episodeid-1].inner_text.strip + ': ' + episodeyid
filename=showid.to_s + '.' + seriesid.to_s + '.' + episodeid.to_s
system('youtube-dl -o ' + filename + '.flv.tmp http://www.youtube.com/watch?v=' +episodeyid)#give the full youtube path in case yid starts with a -
system('avconv -i ' + filename + '.flv.tmp  -acodec copy -b 1024k ' + filename + '.avi')
File.delete(filename + '.flv.tmp')
