import 'package:cloud_firestore/cloud_firestore.dart';

class Streak {
  late String _id;
  DateTime? date;
  List<int> todoIds;
  String userEmail;
  int numberOfTodosUserHasToday;

  String get streakId => _id;

  Streak(
      {required String id,
      this.date,
      required this.todoIds,
      required this.userEmail,
      required this.numberOfTodosUserHasToday}) {
    _id = id;
    date ??= DateTime.now();
  }

  static Map<String, dynamic> toMap(Streak s) {
    var streakMap = Map<String, dynamic>();
    streakMap['id'] = s.streakId;
    streakMap['date'] = s.date;
    streakMap['todoIds'] = s.todoIds;
    streakMap['userEmail'] = s.userEmail;
    streakMap['numberOfTodosUserHasToday'] = s.numberOfTodosUserHasToday;

    return streakMap;
  }

  static Streak toObject(Map<String, dynamic> streakMap) {
    return Streak(
      id: streakMap['id'],
      date: _parseDate(streakMap['date']),
      todoIds: List<int>.from(streakMap['todoIds']),
      userEmail: streakMap['userEmail'],
      numberOfTodosUserHasToday: streakMap['numberOfTodosUserHasToday'],
    );
  }

// ✅ Helper function to correctly parse date field
  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else if (value is String) {
      return DateTime.tryParse(value);
    } else {
      throw Exception("Unexpected date type: ${value.runtimeType}");
    }
  }

}
