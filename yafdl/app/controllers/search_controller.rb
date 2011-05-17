class SearchController < ApplicationController
  def index
    @search = nil
    @fields = ["all","title","creator","subject","identifier"]
    @default_field = "all"    
    @bidis = ["all"]
    BiDi.get_server_names.each do |bidi|
      @bidis << bidi
    end
    @default_bidi = "all"
  end

  def results
    @results = []
    p = "field=#{params[:field]}&term=#{params[:term]}"

    BiDi.get_servers(params[:bidi]).each do |bidi|
      url = bidi[:url]
      name = bidi[:name]
      a = HTTParty.get("#{url}/metadata/query?#{p}")
      doc = Nokogiri::Slop(a.body.to_s)

      if  doc.metadata.content == ""
        array = []
      else
        array = doc.metadata.record
        array = [array] if array.count == 0
      end

      array.each do |xml|
        node = Nokogiri::Slop(xml.to_xml)
        tmp = Result.new
        tmp.repository = name
        tmp.title = node.record.title.content
        tmp.creator = ""
        node.record.creator.each do |author|
          tmp.creator += author.content + ";"
        end
        tmp.creator = node.record.creator.content if(tmp.creator == "")
        tmp.subject=""
        node.record.subject.each do |subject|
          tmp.subject += subject.content + ";"
        end
        tmp.identifier = node.record.identifier.content
        tmp.url = node.record.url.content
        @results << tmp
      end
    end

    
    
  end

end
