function Student(fName, lName) {
  this.fName = fName;
  this.lName = lName;
  this.courses = [];
}

Student.prototype = {
  name : function() {
    return this.fName + " " + this.lName;
  },

  enroll : function(course) {
    this.courses.push(course);
  },

  courseLoad : function() {
    var load = {};
    this.courses.forEach(function(course){
      if (load[course.dept] == undefined) {
        load[course.dept] = course.credits;
      } else {
        load[course.dept] += course.credits;
      }
    });
    return load;
  }
}


function Course(name, dept, credits) {
    this.name = name;
    this.dept = dept;
    this.credits = credits;
    this.students = [];
}

Course.prototype = {
  addStudent : function(student) {
    student.enroll(this);
    this.students.push(student);
  }
}

var a = new Student("Peter", "Parkour");
var b = new Student("Bruce", "Banner");
var c = new Student("Joey", "Jones");

var v = new Course("CrashCart", "Biology", 4);
var w = new Course("Surgery", "Biology", 4);
var x = new Course("Anatomy", "Biology", 4);
var y = new Course("Algebra", "Math", 4);
var z = new Course("Boxing", "Athletics", 3);

z.addStudent(a);
y.addStudent(a);
x.addStudent(a);
w.addStudent(a);
v.addStudent(a);


console.log(a.name());

console.log(a.courseLoad());

console.log(b.courseLoad());

console.log(c.courseLoad());

console.log(x.students);
