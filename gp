if [ -z "$1" ]
  then
    echo "No comment supplied"
  else
    git status
    echo "************************************"
    echo "Aggiungo commento $1"
    echo "************************************"
    if [ -z "$2" ]
    then
      branch="master"
    else
      branch=$2
    fi
    echo "************************************"
    echo "Commit su branch $branch"
    echo "************************************"
    git add -A
    git commit -m "$1"
    git push origin "$branch"
    git status
    if [ "$3" == 'heroku' ]
      then
      echo "************************************"
      echo "Commit su Heroku"
      echo "************************************"
      git push heroku master
    fi
fi

