module Madmin
  class ToolsController < Madmin::ResourceController
    skip_before_action :set_record, only: [ :import, :process_import ]

    def import
      # GET /madmin/tools/import - shows the upload form
    end

    def process_import
      if params[:file].blank?
        redirect_to main_app.import_madmin_tools_path, alert: "Please select a CSV file to import"
        return
      end

      file = params[:file]
      success_count = 0
      error_count = 0
      errors = []

      ::CSV.foreach(file.path, headers: true) do |row|
        begin
          Tool.create!(
            name: row["name"],
            url: row["url"],
            description: row["description"],
            collection_id: row["collection_id"]
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
        flash[:notice] = "Successfully imported #{success_count} tools"
      end

      redirect_to main_app.madmin_tools_path
    end
  end
end
