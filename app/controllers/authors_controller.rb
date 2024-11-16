class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show]

  def index
     @q = Author.ransack(params[:q])
     @authors = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    # @author = Author.all.with_attached_profile_picture.find(params[:id])
    # @author = Author.all.with_attached_profile_picture.find(params[:id])
    @author = Author.find(params[:id])
  end

  def create

  end

  private
  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :bio, :profile_picture)
  end

end