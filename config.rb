require "susy"

::Compass.configuration.sass_options = { :quiet => true }

activate :directory_indexes

set :relative_links, true
activate :livereload

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'www.stephenson.dk' # The name of the S3 bucket you are targetting. This is globally unique.
  s3_sync.region                     = 'eu-west-1'     # The AWS region for your bucket.
  s3_sync.delete                     = true # We delete stray files by default.
  s3_sync.after_build                = false # We do not chain after the build step by default. 
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
end

# Blogging

activate :blog do |blog|
  blog.name = "blog"
  blog.prefix = "blog"
  blog.layout = "blog"

  blog.permalink = "{year}/{title}"

  blog.summary_separator = /SPLIT_SUMMARY_BEFORE_THIS/

  blog.sources = "{year}-{month}-{day}-{title}.html"
end

activate :blog do |blog|
  blog.name = "adventures"
  blog.prefix = "adventures"
  blog.layout = "blog"

  blog.permalink = "{year}/{title}"

  blog.summary_separator = /SPLIT_SUMMARY_BEFORE_THIS/

  blog.sources = "{year}-{month}-{day}-{title}.html"
end

# Assets

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
default_caching_policy max_age:(60 * 60 * 24 * 365)

configure :build do
  default_caching_policy max_age:(60 * 60 * 24 * 365)
  
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  #Gzip text
  activate :gzip

  # Minify HTMl
  activate :minify_html
end
