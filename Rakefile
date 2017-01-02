# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'xz'
require 'open-uri'
require 'json'
require 'oj'
require 'rake-progressbar'
require 'time'

require File.expand_path('../config/application', __FILE__)

require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

Rails.application.load_tasks