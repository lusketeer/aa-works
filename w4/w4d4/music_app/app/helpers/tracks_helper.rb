module TracksHelper
  def display_lyrics(lyrics)
    html = "<pre>"
    lyrics.split(/\r?\n/).each do |line|
      html += line.empty? ? "" : ("&#9835; " + h(line))
      html += "\n"
    end
    html += "</pre>"
    html.html_safe
  end
end
