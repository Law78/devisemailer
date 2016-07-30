class PagesController < ApplicationController
  def index
    @articles = Article.last(2)
  end
  
  def contact
  end
  
  def about
  end
end