
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

Ricorda:
I controller e gli Helper li scrivi al plurale:

rails g controller Users index show
rails g herlpers Users

Ma a plurale anche le Migration e le Resource e le Table:
rails g mirgation AddEmailToUsers email:string
resources :users, :only => [:index, :show]
SELECT * FROM users;

Al singolare abbiamo il Mailer, Model, Observer e lo SCAFFOLD:
```
rails g mailer UserMailer
rails g model User name:string
rails g observer User
rails g scaffold User name:string
```

# Lezione 72

Andiamo a creare un branch per l'aggiunta dei commenti con:

```
git checkout -b comments
```

Creo il file di migrazione, il modello Comment e il test unit con il comando:

```
rails generate model Comment body:text user:references article:references
```

e successivamente il comando:

```
rake db:migrate
```

Ora vado ad aggiungere la relazione sia nel modello User che nel modello Article:

```ruby
has_many :comments
```

e verifico che Comments ha le seguenti relazioni:

```ruby
belongs_to :user
belongs_to :article
```

# Lezione 74 e 75

Siccome non sono passato per uno scaffold, devo aggiungere i routes ed un controller

I commenti saranno annidati agli articoli:

```ruby
resources :articles do
  resources :comments
end
```

ed il controller che vedo nel dettaglio nella lezione 75:

```ruby
class CommentsController < ApplicationController
  
  def create
  end
  
  def update
  end
  
  def edit
  end
  
  def destroy
  end
  
end
```

Il punto centrale è che essendo annidato, non ho bisogno di tutte le view.

# Lezione 76

Nella lezione 76 andiamo a creare il controller dei commenti. Creiamo la funzione
per creare un commento, quindi devo avere un meccanismo per trovare l'articolo
a cui associare il commento:

```ruby
@article = Article.find(params[:article_id])
```

Questa riga di comando mi permette, dato l'id dell'articolo, di avere un riferimento
all'articolo che sto visualizzando. Pertanto lo userò in tutte le altre def
del mio controller dei commenti.

Adesso creo il riferimento del commento nella def create:

```ruby
@comment = @article.comments.create(params[:comments].permit(:body))
```

Dove body è il corpo del testo del commento definito nello schema della tabella
dei commenti.
Adesso devo creare la relazione con l'utente e salvare il commento e fare il
redirect alla pagina dell'articolo corrente, usando un messaggio OPPURE fare
il redirect alla creazione del commento, utilizzando la parola chiave 'new':

```ruby
@comment.user_id = current_user.user_id if current_user

if @comment.save
  redirect_to article_path(@article), notice: "Il tuo commento è salvato."
else
  redirect_to 'new'
end
```

# Lezione 77

Andiamo a cancellare, dalle view di article, i file json.builder. In questo modo
ho una cartella article più pulita.
Torniamo al controller dei commenti e costruiamo la def update. Avrò sempre la prima
riga che mi restituisce l'articolo corrente per il commento corrente, dopodichè
creo un riferimento al mio commento che sto aggiornando, tramite l'uso del suo id:

```ruby
@article = Article.find(params[:article_id])
@comment = @article.comments.find(params[:id])

if @comment.update(params[:comment].permit(:body))
  redirect_to article_path(@article), notice: 'Il commento è aggiornato.'
else
  render 'edit'
end
```

# Lezione 78

Nella def edit, avrò sempre il riferimento al mio articolo e il mio commento:

```ruby
  @article = Article.find(params[:article_id])
  @comment = @article.comments.find(params[:id])
```

Nella def destroy, prendo l'articolo ed il commento come per l'edit e aggiungo
l'istruzione per fare il destroy e il redirect_to con un messaggio:

```ruby
  @article = Article.find(params[:article_id])
  @comment = @article.comments.find(params[:id])
  @comment.destroy
  redirect_to article_path(@article), notice: "Il tuo commento è stato eliminato"
```

Infine, in alto, andiamo ad inserire l'istruzione che ci permette di utilizzare
questo controller solamente se esistente un utente, cioè è autenticato:

```ruby
  before_action :authenticate_user!
```

# Lezione 79

Andiamo a creare una cartella comments sotto
views, con 3 files di cui 2 partial:
_comment.html.erb
_form.html.erb
edit.html.erb

Nel file _comment.html.erb inserisco:

```html
<div class="media">
  <div class="pull-left"></div>
  <div class="media-body">
    <p class="media-heading pull-right"></p>
  </div>
</div>
```

E se noti, questo codice è quello che già ho sotto pages/index.html.erb nella
sezione dei commenti.
La lezione finisce con un test di questa partial, nella index degli articoli:

<%= render 'comments/comment' %>

# Lezione 80

Andiamo a creare la form utilizzando la gem simple form che abbiamo installato
precedentemente. Per fare il test di questa form, devo farla per uno specifico
articolo, in quanto ho bisogno dell'ID dell'articolo, pertanto non posso mettere
il test nell'index ma nella show di article:
<%= render 'comments/form' %>

Mentre il file form sarà:

```html
<%= simple_form_for ([@article, @article.comments.build]) do |f| %>
  <%= f.input :body%>
  <%= f.submit "Invia commento" %>
<% end %>
```

# Lezione 81

Andiamo ad inserire, prima dei link Modifica e Torna Indietro, il link della form
dei commenti:

```ruby
<%= render 'comments/form' %>
```

nello show.html.erb dell'article.
E proviamo ad inserire un commento e successivamente fare la verifica dalla console
di rails con il comando 'rails c' da terminale. Ora scrivo 'Comment.last' e dovrei
avere il commento appena creato.
La lezione finisce col push su git.

# Lezione 82

In show di article vado ad inserire, sotto la render dei commenti:

```html
<div class="row">
  <!-- Blog Post Content Column -->
   <div class="col-lg-8">
    <!-- Blog Post -->
    <!-- Title -->
    <h1 style="font-size: 62.5px;">
<%= @article.title %>
</h1>
    <!-- Author -->
    <p class="lead">
      <%= @article.user.username %>
    </p>
    <hr>
    <!-- Date/Time -->
    <p><span class="glyphicon glyphicon-time"></span> Was Posted:

      <hr>
      <!-- Preview Image -->

      <hr>
      <!-- Post Content -->

      <hr>
      <!-- Blog Comments -->
      <%= @article.body %>
        <!-- Comments Form -->

        <%= render 'comments/form' %>
          <div class="well">

            <h4>blah blah</h4>
          </div>
          <hr>
          <!-- Posted Comments -->
          <!-- Comment -->
  </div>
  <!-- Blog Sidebar Widgets Column -->
  <div class="col-md-4">
    <!-- Blog Search Well -->

    <!-- Blog Categories Well -->

    <!-- Side Widget Well -->
    <div class="well">
      <h4>Recent Posts</h4>

    </div>
  </div>
</div>
```

Ora devo fare alcune modifiche in modo da poter utilizzare questo template ed 
usare i campi giusti.

Alla fine ho qualcosa di così fatto:

```
<div class="row">

  <!-- Blog Post Content Column -->
   <div class="col-lg-8">
    <!-- Blog Post -->
    <!-- Title -->
    <h1 style="font-size: 62.5px;">
      <%= @article.title %>
    </h1>
    <!-- Author -->
    <p class="lead">
      Autore: <%= @article.user.username %>
    </p>
    <!-- Date/Time -->
    <p><span class="glyphicon glyphicon-time"></span> Creato:
      <%= @article.created_at.strftime("%d-%m-%Y %H:%M") %>
    </p>
    <!-- Preview Image -->


    <!-- Post Content -->
    <%= @article.body %>
    <hr>
    <!-- Blog Comments -->

    <!-- Comments Form -->

    <%= render 'comments/form' %>
    <div class="well">

      <h4>blah blah</h4>
    </div>
    <hr>
    <!-- Posted Comments -->
    <!-- Comment -->
  </div>
  <!-- Blog Sidebar Widgets Column -->
  <div class="col-md-4">
    <!-- Blog Search Well -->

    <!-- Blog Categories Well -->

    <!-- Side Widget Well -->
    <div class="well">
      <h4>Recent Posts</h4>
    </div>
  </div>
  
  
</div>

<%= link_to 'Modifica', edit_article_path(@article) %> |
<%= link_to 'Torna indietro', articles_path %>
```

Ho un problema col resize, in cui il footer mi copre parte della parte finale!.