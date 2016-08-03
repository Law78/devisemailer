
     ,-----.,--.                  ,--. ,---.   ,--.,------.  ,------.
    '  .--./|  | ,---. ,--.,--. ,-|  || o   \  |  ||  .-.  \ |  .---'
    |  |    |  || .-. ||  ||  |' .-. |`..'  |  |  ||  |  \  :|  `--, 
    '  '--'\|  |' '-' ''  ''  '\ `-' | .'  /   |  ||  '--'  /|  `---.
     `-----'`--' `---'  `----'  `---'  `--'    `--'`-------' `------'
    ----------------------------------------------------------------- 

Avvio il server con:
rails s -b $IP -p $PORT

e lo fermo con CTRL-C

#Lezione 31

Ho cambiato il GEMFILE spostando la gemma sqlite3 nel gruppo dev in quanto crea
conflitto con Heroku.
Quindi ho rifatto il bundle, con il comando bundle. Dopodichè creato il DB
lanciando 'heroku run rake db:migrate'.
Posso avviare la Console Rails su Heroku con il comando: 'heroku run rails console'
e uscire con 'quit'.

#Lezione 53
Dopo aver fatto il commit su github, ho fatto il commit anche su heroku ma 
ho avuto problemi con un messaggio abbastanza generico. Dovevo semplicemente
lanciare da riga di comando (ad es. da cloud9): heroku run rake db:migrate.
Credo che potevo fare prima anche heroku run rake db:reset (resetta il db)

#Lezione 56
Prima di aggiornare il controller degli Articoli, assicurati di fare il login
altrimenti ti dice che il current_user è nil e quindi non può chiamare il metodo!
Questo lo spiega nella lezione 60, che risolve mettendo before_action :authenticate_user!
nel controller degli articoli, anzichè disabilitare l'opzione di inserire l'articolo
nel nav come avevo fatto!

#Lezione 67
In questa lezione vediamo il controller di contacts e ci accorgiamo che la form
di contatto è senza validazione. Inoltre a fine lezione, sempre dal controller
contacts, notiamo l'area di definizione privata, che definisce i parametri che
utilizziamo nel metodo di creazione del nuovo messaggio di contatto.
Nella parte else, prima del flash message, assicurati di avere questa istruzione:
redirect_to root_path
che probabilmente mi è sfuggita!

#Lezione 68
Vediamo che il models di contact è vuoto. Qui posso inserire delle validazioni
del mio modello. 
Vedi la guida http://guides.rubyonrails.org/active_record_validations.html
Mi basta però inserire questa istruzione:
validates_presence_of :name
per avere già nella form di contatto l'asterisco sul campo nome e ottenere un
messaggio di errore qual'ora non riempissi il campo obbligatorio.
Per lasciare il redirect sulla form in caso di errore cambio
redirect_to root_path
con
redirect_to pages_contact_path
prima del messaggio flash di errore.
Aggiungo le validazioni per gli altri campi

#Lezione 69
In questo video vediamo un fix da fare nel controller del contact:
ContactMailer.contact_email(name, email, message)
aggiungere il deliver:
ContactMailer.contact_email(name, email, message).deliver

L'altro errore è quel del nome file di contact_mail.html.erb in views che si
deve chiamare contact_email.html.erb

Ho fatto il push e heroku run rake db:migrate

#Lezione 70
Andiamo a ritoccare il footer