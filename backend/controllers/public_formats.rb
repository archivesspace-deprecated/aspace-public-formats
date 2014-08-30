class ArchivesSpaceService < Sinatra::Base

  Endpoint.get('/plugins/public_formats/repository/:repo_id/:type/:format/:id.xml')
    .description("Get an archival object by format without permissions")
    .params(["repo_id", :repo_id],
            ["type", String, "The type of object, resource or digital_object"],
            ["format", String, "The format to return the object as"],
            ["id", :id])
    .permissions([])
    .returns([200, "Archival Object"]) \
  do
    handle params[:format], params[:id]
  end

  # html requires the ead
  def format_tree
    {
      ead: [:stream_response, :generate_ead, true, false, false],
      html: [:stream_response, :generate_ead, true, false, false],
      marcxml: [:xml_response, :generate_marc],
      dc: [:xml_response, :generate_dc],
      mets: [:xml_response, :generate_mets],
      mods: [:xml_response, :generate_mods],
    }
  end

  def handle(format, id)
    responder, generater, *args = format_tree[format.intern]
    data = args.any? ? self.send(generater, id, *args) :  self.send(generater, id)
    self.send(responder, data)    
  end

end
