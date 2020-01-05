# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"

set :application, "book_app"

set :repo_url, "git@github.com:dtanakab/Books_crud.git"

set :branch, "master"

set :deploy_to, "/opt/book_app"

set :rbenv_ruby, "2.6.5"

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_files, "config/master.key"
