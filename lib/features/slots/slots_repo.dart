import 'dart:convert';

// no reservations in this day
const String _jsonNoReservations = """
  {
  "data": {
      "reservations": []
    }
  }
  """;

// the day has reserved slots so the current user can't override them
const String _jsonWithReservations = """
  {
    "data": {
      "reservations": ["03:30 PM", "04:00 PM", "08:00 PM", "08:30 PM"]
    }
  }

  """;

class SlotsRepo {

  List<String> getReservations(){
    Map responseMap = jsonDecode(_jsonWithReservations) as Map<String, dynamic>;
    List<dynamic> reservationsJson = responseMap["data"]["reservations"];
    List<String> reservationsList = (reservationsJson.map((e) => e.toString()).toList());
    return reservationsList;
  }

}