class Person {
  String email;
  String name;
  String image;

  Person({required this.email, required this.name, required this.image});

  // Metode fromJson untuk parsing dari JSON ke objek Person
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      email: json['email'],
      name: json['name'],
      image: json['image'],
    );
  }

  // Metode toJson jika Anda ingin mengubah objek ke JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'image': image,
    };
  }
}

class TeamMember {
  final String name;
  final String image;

  TeamMember({required this.name, required this.image});

  // Metode fromJson untuk parsing dari JSON ke objek TeamMember
  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      name: json['name'],
      image: json['image'],
    );
  }

  // Metode toJson jika Anda ingin mengubah objek ke JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}

class Schedule {
  String title;
  String datetimeStart;  // Ini harus sesuai dengan JSON dari server
  String datetimeEnd;
  String timeStart;
  String timeEnd;
  List<Person> teams;
  String office;

  Schedule({
    required this.title,
    required this.datetimeStart,
    required this.datetimeEnd,
    required this.timeStart,
    required this.timeEnd,
    required this.teams,
    required this.office,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'datetime_start': datetimeStart,  // Perbaiki nama field di sini
    'datetime_end': datetimeEnd,
    'time_start': timeStart,
    'time_end': timeEnd,
    'teams': teams.map((team) => team.toJson()).toList(),
    'office': office,
  };

  static Schedule fromJson(Map<String, dynamic> json) => Schedule(
  title: json['title'] ?? 'No Title',
  datetimeStart: json['datetime_start'] ?? '',  // Sesuaikan dengan JSON dari server
  datetimeEnd: json['datetime_end'] ?? '',
  timeStart: json['time_start'] ?? '',
  timeEnd: json['time_end'] ?? '',
  teams: (json['teams'] as List<dynamic>?)
        ?.map((teamJson) => Person.fromJson(teamJson))
        .toList() ?? [],  // Tambahkan handling jika teams null
  office: json['office'] ?? 'Unknown Office',
);
}