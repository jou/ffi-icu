module ICU
  module Conversion
    class Converter
      def self.all_names
        enum_ptr = Lib.check_error do |err|
          Lib.ucnv_openAllNames(err)
        end

        result = Lib.enum_ptr_to_array(enum_ptr)
        Lib.uenum_close(enum_ptr)

        result
      end

      def initialize(name)
        ptr = Lib.check_error { |err| Lib.ucnv_open(name.to_s, err) }
        @converter = FFI::AutoPointer.new(ptr, Lib.method(:ucnv_close))
        @given_name = name
      end

      def name
        Lib.check_error { |err| Lib.ucnv_getName(@converter, err) }
      end

      def standard_name(standard = :iana)
        standard = standard.to_s.upcase
        Lib.check_error { |err| Lib.ucnv_getStandardName(@given_name, standard, err) }
      end
    end
  end
end
