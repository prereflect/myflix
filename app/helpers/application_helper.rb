module ApplicationHelper
    def set_rating
      [5, 4, 3, 2, 1].map {|number| [pluralize(number, 'Star'), number]}
    end
end
