require "kasen/version"

module Kernel
  def k
    Kasen.new
  end
  alias _ k
end

class Kasen
  # Disable all build-in methods
  verbose, $VERBOSE = $VERBOSE, nil
  begin
    instance_methods(true).each { |meth| undef_method(meth) }
    private_instance_methods(true).each { |meth| undef_method(meth) }
  ensure
    $VERBOSE = verbose
  end

  def initialize
    @_calling_methods = []
  end

  def to_proc
    Proc.new { |o|
      @_calling_methods.each do |calling_method|
        o = calling_method.call(o)
      end
      o
    }
  end

  def method_missing(name, *args, &block)
    @_calling_methods << Proc.new { |o|
      o.send(name, *args, &block)
    }
    self
  end
end
