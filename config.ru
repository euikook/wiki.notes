#!/usr/bin/env ruby
require 'rubygems'
require 'gollum/app'
require 'omnigollum'
require 'omniauth-google-oauth2'

gollum_path = File.expand_path(File.dirname(__FILE__)) # CHANGE THIS TO POINT TO YOUR OWN WIKI REPO


wiki_options = {}
wiki_options = {:universal_toc => false}

wiki_options[:css] = true # Equivalent to --css
#wiki_options[:js] = true # Equivalent to --js
#wiki_options[:template_dir] = path # Equivalent to --template-dir
wiki_options[:page_file_dir] = "posts" # Equivalent to --page-file-dir
#wiki_options[:gollum_path] = path # Equivalent to ARGV
#wiki_options[:ref] = ref ## Equivalent to --ref
#wiki_options[:repo_is_bare] = true # Equivalent to --bare
#wiki_options[:allow_editing] = false # # Equivalent to --no-edit
#wiki_options[:live_preview] = true # Equivalent to --live-preview
#wiki_options[:allow_uploads] = true # Equivalent to --allow-uploads
#wiki_options[:per_page_uploads] = true # When :allow_uploads is set, store uploads under a directory named after the page, as when using --allow-uploads page
#wiki_options[:mathjax] = true # Equivalent to --mathjax
#wiki_options[:mathjax_config] = source # Equivalent to --mathjax-config
#wiki_options[:user_icons] = source # Equivalent to --user-icons
wiki_options[:show_all] = true # Equivalent to --show-all
#wiki_options[:collapse_tree] = true # Equivalent to --collapse-tree
wiki_options[:h1_title] = true # Equivalent to --h1-title

options = {
  :providers => Proc.new do
    provider :google_oauth2, '608777204830-ee160jjajsl7bfq108feng163cgdjeom.apps.googleusercontent.com','HtgY4AEriAnCOD2PU6t6blK_',provider_ignores_state: true
  end,
  :dummy_auth => false,
  :protected_routes => [
    '/gollum/revert/*',
    '/gollum/revert',
    '/gollum/create/*',
    '/gollum//create',
    '/gollum/edit/*',
    '/gollum/edit',
    '/gollum/rename/*',
    '/gollum/rename',
    '/gollum/delete/*',
    '/gollum/delete'
  ],
  :authorized_users => [
      "euikook@gmail.com",
      "euikook@harues.com"
  ]
}

#Precious::App.set(:omnigollum, options)
#Precious::App.register Omnigollum::Sinatra

Precious::App.set(:gollum_path, gollum_path)
Precious::App.set(:default_markup, :markdown) # set your favorite markup language
Precious::App.set(:wiki_options, wiki_options)
run Precious::App
