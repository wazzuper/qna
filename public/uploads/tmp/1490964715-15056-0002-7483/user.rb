module Destructable
  def destroy(obj)
    puts "I'll destroy the object"
  end
end

class User
  attr_accessor :name, :email

  include Desctructable

  def self.identity
    puts "class method"
  end

  def initialize(name, email)
    @name = name
    @email = email
  end

  def run
    puts "Hey I'm running"
  end
end

class Buyer < User
  def run
    puts "Buyer class"
  end
end

class Seller < User

end

class Amdin < User

end

user = User.new("Artem", "example@com")