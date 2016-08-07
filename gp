if [ -z "$1" ]
  then
    echo "No comment supplied"
  else
    echo "Aggiungo commento $1"
    if [ -z "$2" ]
    then
      branch="master"
    else
      branch=$2
    fi
    echo "Commit su branch $branch"
    git add -A
    git commit -m "$1"
    git push origin "$branch"
    if [ "$3" == 'heroku' ]
      then
      echo "Commit su Heroku"
        git push heroku master
    fi
fi

