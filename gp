if [ -z "$1" ]
  then
    echo "No comment supplied"
  else
    echo "commento $1"
    if [ -z "$2" ]
    then
      bash="master"
    else
      bash=$2
    fi
    git add -A
    git commit -m "$1"
    git push origin "$bash"
    if [ "$3" == 'heroku' ]
      then
        git push heroku master
    fi
fi

