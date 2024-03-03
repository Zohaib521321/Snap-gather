import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailUtils {
  static sendEmail(String email, String text,
      [String shortMessage = ""]) async {
    String username = 'your Email';
    String password = 'You Password';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Snap Gather')
      ..recipients.add(email)
      ..subject = 'Mail from Snap Gather'
      ..html = """
    <h1 style='font-family: sans-serif; color: #3498db;'>Hi, From Snap Gether</h1>
    <p style='color: #2c3e50;'>$text <br> $shortMessage</p>
  """;
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    var connection = PersistentConnection(smtpServer);
    // Send the first message
    await connection.send(message);
    // send the equivalent message
    // close the connection
    await connection.close();
  }
}
