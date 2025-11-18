# Configure Active Storage to serve files with proper cache headers
# This enables aggressive CDN and browser caching for uploaded images

Rails.application.config.after_initialize do
  # Set cache headers for Active Storage blob responses
  ActiveSupport.on_load(:action_controller_base) do
    # Add cache headers to Active Storage proxy responses
    ActiveStorage::Blobs::ProxyController.class_eval do
      before_action :set_cache_headers

      private

      def set_cache_headers
        # Cache for 1 year (images are content-addressed and immutable)
        # public: Can be cached by CDN and browsers
        # immutable: File will never change (safe to cache permanently)
        response.headers["Cache-Control"] = "public, max-age=31536000, immutable"
      end
    end

    # Add cache headers for variant/representation responses
    ActiveStorage::Representations::ProxyController.class_eval do
      before_action :set_cache_headers

      private

      def set_cache_headers
        response.headers["Cache-Control"] = "public, max-age=31536000, immutable"
      end
    end
  end
end
