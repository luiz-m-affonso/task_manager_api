##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [3.0.0](https://www.ruby-lang.org/en/downloads/)
- Rails [6.1.3](https://github.com/rails/rails)
- PostgreSQL [13.2](https://www.postgresql.org/download/)

##### 1. Check out the repository

```bash
git clone git@github.com:luiz-m-affonso/task_manager_api.git && cd task_manager_api
```

##### 2. Dependencies and Environment Variables

Project dependencies

```bash
bundle install && yarn install && touch .env && echo '.env*' >> .gitignore # if not already in .gitignore
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create && rails db:migrate
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails s
```

And now you can visit the site with the URL http://localhost:3000
