###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###
activate :dotenv

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'amplion.com'
  s3_sync.region                     = 'us-west-2'
  s3_sync.delete                     = false
  s3_sync.after_build                = false
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
end

activate :s3_redirect do |redirect|
  redirect.aws_access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  redirect.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  redirect.bucket                = 'amplion.com'
  redirect.region                = 'us-west-2'
end

redirect '/about.html', '/#about'
redirect '/news.html', '/#blog'
redirect '/contact.html', '/#contact'
redirect '/privacy.html', 'https://www.biomarkerbase.com/privacy'
redirect '/commercial-trends-for-biomarker-based-ivd-tests.html', 'https://www.biomarkerbase.com/report'

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'css'

set :js_dir, 'js'

set :images_dir, 'img'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  # Ignore less templates
  ignore 'less/*'
end
