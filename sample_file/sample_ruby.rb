# Ruby サンプル

require 'json'

# 外部ファイルの読み込み
config = JSON.parse(File.read('sample_external/config.json'))
puts "Config setting1: #{config['setting1']}"

# クラス定義
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def greet
    puts "Hello, my name is #{@name} and I am #{@age} years old."
  end
end

# ループ処理
people = [Person.new("Alice", 30), Person.new("Bob", 25)]
people.each(&:greet)
