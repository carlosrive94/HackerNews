DEPLOY A HEROKU

git push heroku
heroku pg:reset DATABASE
heroku run rake db:migrate



ACTUALITZAR DB LOCAL

bundle exec rake db:drop
bundle exec rake db:migrate



SOBREESCRIURE EL QUE TENS EN LOCAL PEL QUE HI HA AL REPO

git fetch origin
git reset --hard origin/master