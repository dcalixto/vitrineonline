Opensearchkick::Configuration.configure do |config|
  # the most important thing, the url to the search, {searchTerms} is where the query will be.
  config.search_url = 'http://localhost/search?q={searchTerms}'

  # the title of the search
  # config.default_title = 'Opensearch'

  # The description shown in opensearch to describe your website/search
  # config.description = 'Opensearch to search in your browser.'

  # set contact email for people wanna contact you
  # config.contact_email = 'opensearch@test.org'
  
  # set a image you want to show for opensearch (like a logo)
  # config.image_path = '/public/logo.png'
end