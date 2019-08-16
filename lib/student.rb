class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    student = self.new
    student.id = row[0]
    student.name = row[1]
    student.grade = row[2]
    
    student
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    sql = "SELECT * FROM students"

    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end

  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    sql = "SELECT * FROM students WHERE name = ? LIMIT 1"
    
    returned_array_with_student_obj_in_it = DB[:conn].execute(sql,name).map do |row|
      self.new_from_db(row)
    end
    # puts returned_array_with_student_obj_in_it[0] => #<Student:0x00007fb488884de0 @grade="12", @id=1, @name="Pat">
    # puts returned_array_with_student_obj_in_it.flatten => [#<Student:0x00007fb488884de0 @grade="12", @id=1, @name="Pat">]
    # puts returned_array_with_student_obj_in_it.flatten[0] => #<Student:0x00007fb488884de0 @grade="12", @id=1, @name="Pat">
    # binding.pry

    returned_array_with_student_obj_in_it[0]
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT)"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  #This method should return an array of all the students in grade 9.
  def self.all_students_in_grade_9
    # METHOD 1
    # sql = "SELECT COUNT(students.name) FROM students WHERE students.grade = 9"
    # DB[:conn].execute(sql)

    #METHOD 2
    students = self.all
    students.select do |students_obj|
      students_obj.grade == "9"
    end
    
  end

  def self.students_below_12th_grade
    students = self.all
    students.select do |student|
      student.grade.to_i < 12
    end
  end

  def self.first_X_students_in_grade_10(xNumberOfStudents)
    students = self.all
    final = []
    
    students.select do |student|
      if student.grade.to_i == 10
        final.push(student)
      end
    end

    final.slice(0,xNumberOfStudents)
  end

  def self.first_student_in_grade_10
    sql = "SELECT * FROM students WHERE grade = 10 ORDER BY students.id LIMIT 1"
    
    studentInfo = DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
    studentInfo[0]
  end

  def self.all_students_in_grade_X(givenGrade)
    students = self.all
    returnData = []
    students.select do |student_obj|
      if student_obj.grade.to_i == givenGrade
        returnData.push(student_obj)
      end
    end
    returnData
  end



end
