import 'dart:ffi';

class Course {
  String id;
  String name;
  String photo;
  double value;
  Course({this.id, this.name, this.value, this.photo});
  List<Course> getCourses() {
    List<Course> courses = [
      new Course(
          id: "dfdsfds",
          name: "SAT Math",
          value: 0.5,
          photo:
              "https://www.insidehighered.com/sites/default/server_files/media/SAT_2.jpg"),
      new Course(
          id: "aaaa",
          name: "SAT Writing",
          value: 0.30,
          photo:
              "https://sat.qc.ca/sites/all/themes/sat/assets/images/sat_facebook_v3.png"),
      new Course(
          id: "aadaa",
          name: "SAT Essay",
          value: 0.10,
          photo:
              "https://sat.qc.ca/sites/all/themes/sat/assets/images/sat_facebook_v3.png")
    ];
    return courses;
  }
}
