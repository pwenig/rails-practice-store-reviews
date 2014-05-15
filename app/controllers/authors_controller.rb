class AuthorsController < ApplicationController

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to author_path(@author), notice: "Author successfully added"
    else
      render new_author_path, notice: "Something went wrong."
    end
  end

  def show
    @author = Author.find(params[:id])
  end







  private

  def author_params
    params.require(:author).permit(:first_name, :last_name, :bio)
  end
end