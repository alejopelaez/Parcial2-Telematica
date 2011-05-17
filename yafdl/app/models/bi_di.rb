class BiDi < ActiveRecord::Base
  def self.get_server_names
    servers = []
    doc = Nokogiri::XML(File.new("public/servers/servers.xml"))
    doc.xpath("/servers/bidi/name").each do |server|
      servers << server.content
    end
    servers
  end

  def self.get_servers(q)
    servers = []
    doc = Nokogiri::XML(File.new("public/servers/servers.xml"))
    doc = Nokogiri::Slop(doc.to_xml)
    doc.servers.bidi.each do |server|
      node = Nokogiri::Slop(server.to_xml)
      name = node.bidi.content.split(" ").first
      url = node.bidi.url.content
      if(name == q or q == "all")
        servers << {:name => name, :url => url}
      end
    end
    servers
  end

  def self.get_server_url(q)
    servers = []
    doc = Nokogiri::XML(File.new("public/servers/servers.xml"))
    doc.xpath("//url").each do |server|
      servers << server.content
    end
    servers
  end
end
