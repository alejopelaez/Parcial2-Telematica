class MetadataController < ApplicationController
  def query
    results = Metadata.query(params[:field], params[:term])
    render :xml => results.to_xml
  end

end
