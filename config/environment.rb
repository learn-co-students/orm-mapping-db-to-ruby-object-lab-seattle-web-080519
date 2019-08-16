# require "Pry"

require 'sqlite3'
require_relative '../lib/student'

DB = {:conn => SQLite3::Database.new("db/students.db")}



### TEST DATA ###
Student.create_table

phil = Student.new
phil.grade = 12
phil.name = "Phil"

peter = Student.new
peter.grade = 12
peter.name = "Peter"

sara = Student.new
sara.grade = 11
sara.name = "Sara"

sophia = Student.new
sophia.grade = 11
sophia.name = "Sophia"

lana = Student.new
lana.grade = 10
lana.name = "Lana"

larry = Student.new
larry.grade = 10
larry.name = "Larry"

ellie = Student.new
ellie.grade = 9
ellie.name = "Ellie"

elliot = Student.new
elliot.grade = 9
elliot.name = "Elliot"

# Pry.start
# 0