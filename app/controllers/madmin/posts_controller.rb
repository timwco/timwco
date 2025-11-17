module Madmin
  class PostsController < Madmin::ResourceController
    skip_before_action :set_record, only: [:import, :process_import]

    def import
      # GET /madmin/posts/import - shows the upload form
    end

    def process_import
      if params[:file].blank?
        redirect_to main_app.import_madmin_posts_path, alert: "Please select a CSV file to import"
        return
      end

      file = params[:file]
      success_count = 0
      error_count = 0
      errors = []

      ::CSV.foreach(file.path, headers: true) do |row|
        begin
          Post.create!(
            title: row['title'],
            slug: row['slug'],
            content: row['content'],
            abstract: row['abstract'],
            published_date: row['published_date'].present? ? Date.parse(row['published_date']) : nil,
            category_id: row['category_id'],
            featured_image_id: row['featured_image_id'].present? ? row['featured_image_id'] : nil
          )
          success_count += 1
        rescue => e
          error_count += 1
          errors << "Row #{success_count + error_count}: #{e.message}"
        end
      end

      if error_count > 0
        flash[:alert] = "Import completed with errors. #{success_count} imported, #{error_count} failed. Errors: #{errors.join('; ')}"
      else
        flash[:notice] = "Successfully imported #{success_count} posts"
      end

      redirect_to main_app.madmin_posts_path
    end
  end
end
