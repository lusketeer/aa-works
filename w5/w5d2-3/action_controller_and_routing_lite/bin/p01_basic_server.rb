require 'webrick'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html


server = WEBrick::HTTPServer.new(Port: 3000)


server.mount_proc "/" do |req, resp|
  resp.content_type = "text/text"
  resp.body += "Everyone!!\n"
  resp.body += "Path: " + req.path + "\n"
  resp.body += "Request URI: " + req.request_uri.to_s + "\n"
end


trap("INT") do
  server.shutdown
end

server.start
