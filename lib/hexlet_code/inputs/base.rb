module HexletCode
  module Inputs
  # A parent of all inputs here
    class Base
      def to_s
        if @text.nil?
          HexletCode::Tag.build(@tag_name, **@kwargs)
        else
          HexletCode::Tag.build(@tag_name, **@kwargs) { @text }
        end
      end
    end
  end
end
