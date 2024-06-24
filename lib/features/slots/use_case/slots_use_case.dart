import 'package:time_slots_sample/data/reservation_slot.dart';

class SlotsUseCase {

  /// convert the period between opening and closing hours to slots while considering the already reserved slots.
  /// used when we retrieve a list of the already reserved times and we want to distinguish them from the free times.
  List<ReservationSlot> convertReservationsToSlots(String openingHr, String closingHr, List<String> reservedTimes) {
    final List<ReservationSlot> slotsList = List<ReservationSlot>.empty(growable: true);
    ReservationSlot tempSlot = ReservationSlot(openingHr, reservedTimes.contains(openingHr));
    slotsList.add(tempSlot);
    while (true) {
      if (tempSlot.time == closingHr) {
        slotsList.removeLast();
        break;
      } else if (tempSlot.time == '11:30 PM') {
        tempSlot = ReservationSlot('12:00 AM', reservedTimes.contains('12:00 AM'));
      } else if (tempSlot.time == '11:30 AM') {
        tempSlot = ReservationSlot('12:00 PM', reservedTimes.contains('12:00 PM'));
      } else if (tempSlot.time.substring(3, 5) == '00') {
        tempSlot = ReservationSlot(
            '${tempSlot.time.substring(0, 3)}30 ${tempSlot.time.substring(6, 8)}',
            reservedTimes.contains(
                '${tempSlot.time.substring(0, 3)}30 ${tempSlot.time.substring(6, 8)}'));
      } else if (tempSlot.time.substring(3, 5) == '30') {
        if (tempSlot.time.substring(0, 2) == '12') {
          tempSlot = ReservationSlot('01:00 ${tempSlot.time.substring(6, 8)}',
              reservedTimes.contains('01:00 ${tempSlot.time.substring(6, 8)}'));
        } else {
          String hr = (int.parse(tempSlot.time.substring(0, 2)) + 1)
              .toString()
              .padLeft(2, '0');
          tempSlot = ReservationSlot('$hr:00 ${tempSlot.time.substring(6, 8)}',
              reservedTimes.contains('$hr:00 ${tempSlot.time.substring(6, 8)}'));
        }
      }
      slotsList.add(tempSlot);
    }
    return slotsList;
  }

  /// if the time slot is after 12 am, it'll be considered the next day
  bool isTomorrow(String time, String openingHour){
    String openHalf = openingHour.substring(6, 8);
    String timeHalf = time.substring(6, 8);
    if(timeHalf == 'PM') return false;
    if(timeHalf == 'AM' && openHalf == 'PM') return true;

    int openHr = int.parse(openingHour.substring(0, 2));
    int timeHr = int.parse(time.substring(0, 2));
    if(openHr > timeHr || timeHr == 12) return true;
    if(openHr < timeHr) return false;

    int openMin = int.parse(openingHour.substring(3, 5));
    int timeMin = int.parse(time.substring(3, 5));
    if(openMin > timeMin) return true;
    return false;
  }
}
