# encoding: utf-8
class DepartmentsController < ApplicationController

def index
   @genders = Gender.includes(:categories).all
    @categories = Category.includes(:subcategories).all
end

end
