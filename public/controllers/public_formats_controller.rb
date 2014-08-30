class PublicFormatsController < ApplicationController

  def generate
    check_format params[:type], params[:format]
    handle params[:repo_id], params[:type], params[:format], params[:id]
  end

  private

  def handle(repo_id, type, format, id)
    uri      = URI.parse AppConfig[:backend_url]
    http     = Net::HTTP.new uri.host, uri.port
    request  = Net::HTTP::Get.new "/plugins/public_formats/repository/#{repo_id}/#{type}/#{format}/#{id}.xml"
    response = http.request request 
    if response.code == "200"
      content_type = format == "html" ? "html" : "xml"
      content = response.body

      if content_type == "html"
        # convert content to html
        html = "<h1>Placeholder</h1>"
        content = html
      end

      render text: content, :content_type => "text/#{content_type}"
    else
      raise RecordNotFound.new
    end
  end

  def check_format(type, format)
    formats = {
      resources: [ "ead", "html", "marcxml" ],
      digital_objects: ["dc", "mets", "mods"],
    }
    raise RecordNotFound.new unless formats[type.intern].include? format
  end

end
