# Enable HTML escaping in cells-slim.
#
# See https://github.com/trailblazer/cells-slim
module Cell
  module Slim
    def template_options_for(options)
      {
        buffer: '@output_buffer',
        suffix: 'slim',
        template_class: ::Slim::Template,
        use_html_safe: true,
      }
    end
  end
end
