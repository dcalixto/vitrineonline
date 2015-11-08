crumb :root do
  link 'Início', root_path
end

crumb :products do
  link 'Itens', products_path
end

crumb :product do |product|
  link product.name, product_path(product)
  parent :products
end

crumb :users do
  link 'Usuários', users_path
end

crumb :user do |user|
  link user.name, user_path(user)
  parent :users
end

crumb :vitrines do
  link 'Vitrines', vitrines_path
end

crumb :vitrine do |vitrine|
  link vitrine.name, vitrine_path(vitrine)
  parent :vitrines
end

crumb :gender do |gender|
  link gender.gender, gender_path(gender)
end

crumb :category do |category|
  link category.name, category_path(category)
end

crumb :subcategory do |subcategory|
  link subcategory.name, subcategory_path(subcategory)
end

crumb :boutique_kind do |boutique_kind|
  link boutique_kind.kind, boutique_kind_path(boutique_kind)
end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
