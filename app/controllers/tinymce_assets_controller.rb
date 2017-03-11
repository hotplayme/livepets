class TinymceAssetsController < ApplicationController

  def create
    image = ArticleAttachment.create(file: params[:file])

    render json: {
               image: {
                   url: view_context.image_url(image.file.url(:thumb))
               }
           }, content_type: "text/html"
  end

end
