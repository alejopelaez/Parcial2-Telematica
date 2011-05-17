class Metadata < ActiveRecord::Base
  def self.query(field, term)
    metadata = []

    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.metadata do |xml|        
      end
    end
    
    node = builder.doc.xpath("/metadata").first
    
    Dir.glob("public/metadata/*").each do |path|
      file = File.new(path)

      doc = Nokogiri::XML(file)
      result = nil
      if(field == "all")
        doc.xpath("//*").each do |node|
          if(node.content.downcase.include?(term))
            result = doc
          end
        end
      else
        doc.xpath("//#{field}").each do |node|
          if(node.content.downcase.include?(term))
            result = doc
          end
        end
      end
      result.xpath("/record").first.parent = node unless result.nil?
    end    

    builder.doc
  end
end
