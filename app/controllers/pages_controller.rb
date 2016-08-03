class PagesController < ApplicationController
  def index
    @articles = Article.last(2)
  end
  
  def contact
    @contact = Contact.new
  end
  
  def about
  end
end