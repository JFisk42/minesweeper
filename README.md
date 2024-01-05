# README

This project is a simple minesweeper board generation project. It was generated with Rails 7 that uses Bootstrap and PostgreSQL.

Important versions this project uses:

* Rails 7.1.2

* Ruby 3.2.2

* PostgreSQL 14.10

* Boostrap 5.3.2

* yarn 1.22.21

* npm 10.2.4

* node 21.5.0

# Steps to deploy to Heroku:

Pull down the repo
`git clone https://github.com/JFisk42/minesweeper`

Login to heroku
`heroku login`

Create a heroku app
`heroku apps:create`

Provision the database
`heroku addons:create heroku-postgresql:mini`

Push code to heroku
`git push heroku main`

Migrate the db on heroku
`heroku run rake db:migrate`

Navigate to the index via the heroku app you created
`https://[your-app-name].herokuapp.com`

# Running locally:

Pull down the repo
`git clone https://github.com/JFisk42/minesweeper`

Run bundle install
`bundle install`

Build the css with yarn
`yarn build:css`

Building the css may require installing bootstrap through npm
`npm install bootstrap`

Start PostgreSQL
`brew services start postgresql`

Setting up info for PostgreSQL may be required
`psql -d postgres`

Run the Rails db migrations
`rake db:create`
`rake db:setup`
`rake db:migrate`

Navigate to project in your browser
`localhost:3000`