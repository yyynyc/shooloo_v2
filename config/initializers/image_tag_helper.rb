module ActionView
  module Helpers
    module AssetTagHelper
      def image_tag(source, options={})
        options[:src] = path_to_image(source)
        options[:alt] = "Shooloo Common Core Math" unless options.has_key?(:alt)
        options[:title] = "Shooloo Common Core Math" unless options.has_key?(:title)
        tag(:img, options)
      end
    end
  end
end