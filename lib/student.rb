class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    t = Student.new
    t.id = row[0]
    t.name = row[1]
    t.grade = row[2]
    t
  end
  def self.all_students_in_grade_9
    sql = "select * from students where students.grade = 9"
    DB[:conn].execute(sql)
  end
  def self.students_below_12th_grade
    sql = "select * from students where students.grade < 12"
    ne = DB[:conn].execute(sql)
    ne.map {|n| Student.new_from_db(n)}

  end

  def self.all
    sql = "select * from students"
    w = DB[:conn].execute(sql)
    w.map {|n| Student.new_from_db(n)}
    # binding.pry
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
  end
  def self.first_X_students_in_grade_10(num)
    sql = "select * from students where students.grade = 10"
    DB[:conn].execute(sql).map {|n| Student.new_from_db(n)}.first(num)
  end
  def self.first_student_in_grade_10
    first_X_students_in_grade_10(1)[0]
  end
  def self.all_students_in_grade_X(num)
    sql = "select * from students where grade = ?"
    DB[:conn].execute(sql, num)
  end
  def self.find_by_name(name)
    sql = "select * from students where students.name = ?"
    # binding.pry
    ne = DB[:conn].execute(sql, name).flatten
    self.new_from_db(ne)
    # find the student in the database given a name
    # return a new instance of the Student class
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
