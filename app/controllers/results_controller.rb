class ResultsController < ApplicationController
  def index
    @search_res = Post.search_by_title_or_text(params[:query])
  end
end
