import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateConverter {
  DateTime? toDateTime(dynamic data) {
    if (data == null || data is! Timestamp) {
      return null;
    }
    final Timestamp ts = data;
     return DateTime.fromMillisecondsSinceEpoch(ts.millisecondsSinceEpoch);
    //return DateTime.utc(2001, 12, 30);

  }

  String? dateToString({required DateTime? dateTime}) {
    return dateTime == null ? null : DateFormat.yMd().format(dateTime);
  }
}

