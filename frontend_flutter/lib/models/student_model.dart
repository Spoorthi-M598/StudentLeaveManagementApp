class Student {

  final int id;

  final String name;

  final String email;

  final String mentorEmail;

  final String branch;

  final int semester;

  final String usn;

  final String course;

  final String section;

  final String bloodGroup;

  final String address;

  final String emergencyContact;

  Student({

    required this.id,

    required this.name,

    required this.email,

    required this.mentorEmail,

    required this.branch,

    required this.semester,

    required this.usn,

    required this.course,

    required this.section,

    required this.bloodGroup,

    required this.address,

    required this.emergencyContact,
  });

  factory Student.fromJson(
      Map<String, dynamic> json) {

    return Student(

      id:
          json["id"] ?? 0,

      name:
          json["name"] ?? "",

      email:
          json["email"] ?? "",

      mentorEmail:
          json["mentor_email"] ?? "",

      branch:
          json["branch"] ?? "",

      semester:
          json["semester"] ?? 0,

      usn:
          json["usn"] ?? "",

      course:
          json["course"] ?? "",

      section:
          json["section"] ?? "",

      bloodGroup:
          json["blood_group"] ?? "",

      address:
          json["address"] ?? "",

      emergencyContact:
          json["emergency_contact"] ?? "",
    );
  }
}