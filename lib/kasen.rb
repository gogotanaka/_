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
    @__kasen__ = Proc.new { |o| o }
  end

  def to_proc
    @__kasen__
  end

  def method_missing(name, *args, &block)
    __kasen__ = @__kasen__
    @__kasen__ = Proc.new { |o| (__kasen__.(o)).send(name, *args, &block) }
    self
  end
end
