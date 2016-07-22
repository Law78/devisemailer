
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