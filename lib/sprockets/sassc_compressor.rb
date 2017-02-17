# frozen_string_literal: true
#
# This file contains a asset compressor class using sassc engine
#
# Content is copied from sprockets 4.x
# But this doesn't exists in 3.x (yet?)
#
# Also with following modifications:
# - Replace `Autoload::SassC` => `::SassC` (since no need for autoload)
# - Comment source map related code and return rendered css only

# We do NOT want to override existing implementation (which exists in sprockets 4.x)

require "sprockets"
require "sassc"
require "base64"

if defined?(::Sprockets) && defined?(::Sprockets::SasscCompressor)
  raise "Existing implementation already exists!"
end

module Sprockets
  class SasscCompressor < SassCompressor
    def initialize(options = {})
      @options = {
        syntax: :scss,
        style: :compressed,
        source_map_contents: false,
        omit_source_map_url: true,
      }.merge(options).freeze
    end

    def call(input)
      # SassC requires the template to be modifiable
      input_data = input[:data].frozen? ? input[:data].dup : input[:data]
      engine = ::SassC::Engine.new(
        input_data,
        @options.merge(
          filename: input[:filename],
        # Source map unsupported in sprockets 3.x
        # source_map_file: "#{input[:filename]}.map",
        )
      )

      css = engine.render.sub(/^\n^\/\*# sourceMappingURL=.*\*\/$/m, '')

      # begin
      #   map = SourceMapUtils.format_source_map(JSON.parse(engine.source_map), input)
      #   map = SourceMapUtils.combine_source_maps(input[:metadata][:map], map)
      # rescue SassC::NotRenderedError
      #   map = input[:metadata][:map]
      # end
      #
      # { data: css, map: map }

      # Returning rendered css only,
      # the code above is for source map but unsupported in sprockets 3.x
      css
    end
  end
end
