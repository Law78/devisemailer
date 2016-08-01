if [ -z "$1" ]
  then
    echo "No comment supplied"
  else
    git add -A
    git commit -m "$1"
    git push origin master
    git push heroku master
fi
