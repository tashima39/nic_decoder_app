import 'package:intl/intl.dart';

class NICDecoder {
  final String nic;
  late String nicType, dateOfBirth, gender, weekday;
  late int age;

  NICDecoder(this.nic) {
    _decode();
  }

  void _decode() {
    int year, dayOfYear;
    if (nic.length == 10) {
      // Old NIC number Format
      nicType = "Old NIC Number Format";
      year = 1900 + int.parse(nic.substring(0, 2));
      dayOfYear = int.parse(nic.substring(2, 5));
    } else if (nic.length == 12) {
      // New NIC number Format
      nicType = "New NIC Number Format";
      year = int.parse(nic.substring(0, 4));
      dayOfYear = int.parse(nic.substring(4, 7));
    } else {
      throw Exception("Invalid NIC Format");
    }

    gender = (dayOfYear < 500) ? "Male" : "Female";
    if (dayOfYear > 500) dayOfYear -= 500;

    // Convert dayOfYear to actual date
    DateTime dob = DateTime(year).add(Duration(days: dayOfYear - 1));
    dateOfBirth = DateFormat('yyyy-MM-dd').format(dob);
    weekday = DateFormat('EEEE').format(dob);

    // Calculate age
    DateTime today = DateTime.now();
    age = today.year - year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
  }
}