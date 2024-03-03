import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImagePathUtils {
  static const String assetImages = "assets/images/";
  static const String icon = "${assetImages}icons/";
  static const String json = "assets/json/";

  //icon
  static const String addIcon = "${icon}add.png";
  static const String verify = "${icon}verify.png";
  static const String darkIcon = "${icon}dark.png";
  static const String calendarBlack = "${icon}calendarBlack.png";
  static const String calenderPink = "${icon}calenderPink.png";
  static const String homeBlack = "${icon}homeBlack.png";
  static const String homePink = "${icon}homePink.png";
  static const String userBlack = "${icon}userBlack.png";
  static const String userPink = "${icon}userPink.png";
  static const String search = "${icon}search.png";
  static const String join = "${icon}join.png";
  static const String leave = "${icon}leave.png";
  static const String delete = "${icon}delete.png";
  static const String edit = "${icon}edit.png";
  static const String location = "${icon}location.png";
  static const String clock = "${icon}clock.png";
  static const String back = "${icon}back.png";
  static const String cancel = "${icon}cancel.png";
  static const String save = "${icon}save.png";
  static const String imageIcon = "${icon}image.png";
  static const String topEllipse = "${icon}topElipse.png";
  static const String seen = "${icon}see.png";
  static const String unSeen = "${icon}unseen.png";
  static const String light = "${icon}light.png";
  static const String logo = "${icon}logo.png";

  //json Animation
  static const String first = "${json}1.json";
  static const String empty = "${json}empty.json";
  static const String shimmer = "${json}shimmer.json";
  static const String splash = "${json}splash.json";

//.env
  String publishableKey = dotenv.get("PUB_KEY");
  String serverKey = dotenv.get("SERVER_KEY");
  String currencyApiKey = dotenv.get("CURRENCY_KEY");
  String email = dotenv.get("EMAIL");
  String password = dotenv.get("PASSWORD");
}
