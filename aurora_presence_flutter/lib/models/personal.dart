// models/personal.dart

class Personal {
  final int id;
  final String name;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String address;
  final String emergencyNumber;
  final String employeeId;
  final String department;
  final String position;

  Personal({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.emergencyNumber,
    required this.employeeId,
    required this.department,
    required this.position,
  });

  factory Personal.fromJson(Map<String, dynamic> json) {
    return Personal(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      address: json['address'],
      emergencyNumber: json['emergency_number'],
      employeeId: json['employee_id'],
      department: json['department'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'address': address,
      'emergency_number': emergencyNumber,
      'employee_id': employeeId,
      'department': department,
      'position': position,
    };
  }
}
