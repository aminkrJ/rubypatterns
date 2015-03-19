require 'forwardable'
require 'pry'

module Sample
  class Base
    attr_accessor :title, :strategy
    def initialize(format = :happy, title)
      @title = title
      @strategy = Sample.const_get(format.to_s.capitalize).new self
    end

    def hello
      strategy.hello
    end
  end
end

module Sample
  class Happy
    extend Forwardable
    def_delegators :@context, :title
    attr_accessor :context
    def initialize(context)
      @context = context
    end

    def hello
      print title + " :)"
    end
  end
end

module Sample
  class Sad
    extend Forwardable
    def_delegators :@context, :title
    attr_accessor :context
    def initialize(context)
      @context = context
    end

    def hello
      print title + " :("
    end
  end
end

happy = Sample::Base.new(:happy, "Hi")
happy.hello

sad = Sample::Base.new(:sad, "Hi")
sad.hello
