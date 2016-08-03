class ContactsController < ApplicationController
  
  def new
	@contact = Contact.new
  end

  def create
  	@contact = Contact.new(contact_params)
  	
  	if @contact.save
  		redirect_to root_path
  		name = params[:contact][:name]
  		email = params[:contact][:email]
  		message = params[:contact][:message]
  		ContactMailer.contact_email(name, email, message).deliver
  		flash[:success] = "Grazie per il messaggio, ci sentiremo al più presto!"
  	else
  	  redirect_to pages_contact_path
  		flash[:danger] = "Opps, si è verificato un problema! Per piacere riempi la form in tutti i suoi campi."
  	end
  end

  private
  
  def contact_params
  	params.require(:contact).permit(:name, :email, :message)
  end
end
