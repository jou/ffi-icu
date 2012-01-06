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

      def self.standards
        standards_count = Lib.ucnv_countStandards

        (0..(standards_count-1)).map do |i|
          Lib.check_error { |err| Lib.ucnv_getStandard(i, err) }
        end
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
        Lib.check_error { |err| Lib.ucnv_getStandardName(name, standard, err) }
      end

      def canonical_name(standard = :iana)
        standard = standard.to_s.upcase
        Lib.check_error { |err| Lib.ucnv_getCanonicalName(name, standard, err) }
      end
    end
  end
end
