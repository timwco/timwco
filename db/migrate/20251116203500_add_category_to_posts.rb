class AddCategoryToPosts < ActiveRecord::Migration[8.1]
  def change
    # Add category_id column without null constraint initially
    add_reference :posts, :category, null: true, foreign_key: true

    # Set all existing posts to the default 'Uncategorized' category
    reversible do |dir|
      dir.up do
        default_category = Category.find_by(slug: 'uncategorized')
        if default_category
          Post.unscoped.update_all(category_id: default_category.id)
        end
      end
    end

    # Now add the null constraint
    change_column_null :posts, :category_id, false
  end
end
