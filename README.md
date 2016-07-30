
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
lanciare da riga di comando (ad es. da cloud9): heroku run rake db:migrate

#Lezione 56
Prima di aggiornare il controller degli Articoli, assicurati di fare il login
altrimenti ti dice che il current_user è nil e quindi non può chiamare il metodo!
Questo lo spiega nella lezione 60, che risolve mettendo before_action :authenticate_user!
nel controller degli articoli, anzichè disabilitare l'opzione di inserire l'articolo
nel nav come avevo fatto!