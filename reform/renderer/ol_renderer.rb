module Reform
  module Renderer
    class OlRenderer < Base
      def outer_form_open
        ""
      end

      def outer_form_close
        ""
      end

      def inner_form_open
        "<ol>"
      end

      def inner_form_close
        "</ol>"
      end

      def label_outer_open
        "<li>"
      end

      def label_outer_close
        ""
      end

      def field_outer_open
        ""
      end

      def field_outer_close
        "</li>"
      end

      def field_inner_open
        ""
      end

      def field_inner_close
        ""
      end
    end
  end
end
