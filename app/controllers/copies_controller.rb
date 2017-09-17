class CopiesController < ApplicationController

  # POST /copies
  def create
    run Book::Copy::Create do |result|
      redirect_to book_url(result['book'])
      return
    end

    redirect_to root_url
  end

  # DELETE /copies
  def destroy
    run Book::Copy::Destroy do |result|
      redirect_to book_url(result['book'])
      return
    end

    redirect_to root_url
  end
end
