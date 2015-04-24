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
    Proc.new do |o|
      @_calling_methods.inject(o) do |m, calling_method|
        calling_method.(m)
      end
    end
  end

  def method_missing(name, *args, &block)
    @_calling_methods << Proc.new { |o| o.send(name, *args, &block) }
    self
  end
end
