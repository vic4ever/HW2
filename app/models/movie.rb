class Movie < ActiveRecord::Base
  def self.get_all_ratings
    find(:all, :select => 'rating').map{ |x|
      x.rating
    }.uniq
  end
end
