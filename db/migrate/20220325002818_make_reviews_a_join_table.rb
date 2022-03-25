class MakeReviewsAJoinTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :name, :string
    # NOTE: ^^ the first thing you mention is which database you are altering (reviews)
    add_column :reviews, :user_id, :integer
    Review.delete_all
  end
end
