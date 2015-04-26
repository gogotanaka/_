require "kasen/version"

module Kernel
  def k
    Kasen::Context.new
  end
  alias _ k
end

module Kasen
  class EmptyObject
    verbose, $VERBOSE = $VERBOSE, nil
    begin
      instance_methods(true).each { |meth| undef_method(meth) }
      private_instance_methods(true).each { |meth| undef_method(meth) }
    ensure
      $VERBOSE = verbose
    end
  end

  class Context < EmptyObject
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

  class ContextGenerator < EmptyObject
    def initialize
    end

    def method_missing(name, *args, &block)
      Kasen::Context.new.send(name, *args, &block)
    end
  end
end

if defined?(IRB::Context)
  class IRB::Context
    def set_last_value(value)
      @last_value = value
      @workspace.evaluate self, "_ = Kasen::ContextGenerator.new"
    end
  end
end