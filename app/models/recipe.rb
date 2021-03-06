class Recipe < ActiveRecord::Base
    belongs_to :chef
    has_many :likes, dependent: :destroy
    has_many :recipe_styles, dependent: :destroy
    has_many :styles, through: :recipe_styles
    has_many :recipe_ingredients, dependent: :destroy
    has_many :ingredients, through: :recipe_ingredients
    has_many :comments, dependent: :destroy
    validates :chef_id, presence: true
    validates :name, presence: true, length: { minimum: 5, maximum: 100 }
    validates :summary, presence: true, length: { minimum: 10, maximum: 150 }
    validates :description, presence: true, length: { minimum: 20, maximum: 500 }
    mount_uploader :picture, PictureUploader
    validate :picture_size
    default_scope -> { order(updated_at: :desc) }
    scope :last_recipes, -> { order(updated_at: :desc).limit(3) }
    
    def thumbs_up_total
       self.likes.where(like: true).size 
    end
    
    def thumbs_down_total
        self.likes.where(like: false).size 
    end
    
    def self.search_by_name(name)
        names_array = name.split(" ")
        if names_array.size == 1
            where('name LIKE ? or summary LIKE ?', "%#{names_array[0]}%", "%#{names_array[0]}%").order(:name)
        else
            where('name LIKE ? or summary LIKE ? or name LIKE ? or summary LIKE ?',
            "%#{names_array[0]}%", "%#{names_array[1]}%", "%#{names_array[0]}%", "%#{names_array[1]}%").order(:name)
        end
    end

    private
        def picture_size
            if picture.size > 5.megabytes
                errors.add(:picture, "should be less than 5MB")
            end
        end
end