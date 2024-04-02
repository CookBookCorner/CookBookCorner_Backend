# Cookbook Corner Backend

This project is the backend for the Cookbook Corner app, developed with Ruby on Rails. It features user authentication using Devise and JWT for a secure API experience.

## Technologies Used

- Ruby on Rails
- PostgreSQL
- Devise for authentication
- JWT for token-based authentication
- Rack-CORS for handling Cross-Origin Resource Sharing (CORS)

## Setup and Configuration

### Requirements

To run this project, you will need:

- Ruby (version as per `.ruby-version` file)
- Rails
- PostgreSQL

### Steps

1. **Creating the Rails Application**
 $ rails new cookbook-corner-backend -d postgresql -T

2. **Database Creation and Setup**
  $ rails db:create

3. **Adding RSpec for Testing**
  $ bundle add rspec-rails
  $ rails generate rspec:install

4. **Adding Devise for Authentication**
  $ bundle add devise
  $ rails generate devise:install
  $ rails generate devise User
  $ rails db:migrate

5. **JWT and CORS Setup**

Add `devise-jwt` and `rack-cors` to your Gemfile for JWT authentication and configuring CORS for secure cross-origin requests.

```ruby
gem 'devise-jwt'
gem 'rack-cors'

