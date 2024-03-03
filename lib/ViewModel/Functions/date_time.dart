import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class DateTimeStamp{
 static String timeAgoCustom(dynamic timestamp) {
   Duration diff = DateTime.now().difference(timestamp);

   if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return DateFormat.E().add_jm().format(timestamp);
    }
    if (diff.inHours > 0) {
      return "Today ${DateFormat('jm').format(timestamp)}";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    } else {
      return "just now";
    }
  }

 static String formatDateToDDMMYYYY(dynamic date) {
   if (date is DateTime) {
     String period = date.hour < 12 ? 'AM' : 'PM';
     int hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
     return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
   } else if (date is String) {
     DateTime parsedDate = DateTime.parse(date);
     String period = parsedDate.hour < 12 ? 'AM' : 'PM';
     int hour = parsedDate.hour % 12 == 0 ? 12 : parsedDate.hour % 12;
     return '${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year} ${hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')} $period';
   } else if (date is Timestamp) {
     // Assuming Timestamp has a toDate() method to convert to DateTime
     DateTime dateTime = date.toDate();
     String period = dateTime.hour < 12 ? 'AM' : 'PM';
     int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
     return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period';
   } else {
     throw ArgumentError('Invalid date format');
   }
 }

}