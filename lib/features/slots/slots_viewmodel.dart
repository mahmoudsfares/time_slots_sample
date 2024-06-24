import 'dart:collection';
import 'package:time_slots_sample/data/reservation_slot.dart';
import 'package:time_slots_sample/features/slots/slots_repo.dart';
import 'package:time_slots_sample/features/slots/use_case/slots_use_case.dart';

// time range in which reservations are available
const String _openingHour = "10:00 AM";
const String _closingHour = "05:00 AM";

class SlotsViewModel {

  final SlotsUseCase _useCase = SlotsUseCase();
  final SlotsRepo _repo = SlotsRepo();

  // all time slots regardless of whether previously reserved or not
  late final List<ReservationSlot> timeSlots;

  // slots that the user selected while making a reservation
  LinkedHashMap<int, String> selectedSlots = LinkedHashMap();

  /// convert the time range from opening hour to closing hour to slots
  void convertTimeRangeToSlots(){
    List<String> reservations = _repo.getReservations();
    List<ReservationSlot> slots = _useCase.convertReservationsToSlots(
      _openingHour,
      _closingHour,
      reservations,
    );
    timeSlots = slots;
  }

  /// check if a validation is for at least 1hr (2 slots) and for a continuous period
  String validateReservation() {
    if (selectedSlots.isEmpty) {
      return 'No selected slots';
    } else if (selectedSlots.length == 1) {
      return 'A reservation must be at least for an hour';
    }
    LinkedHashMap<int, String> sortedByKeyMap = LinkedHashMap.fromEntries(selectedSlots.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    selectedSlots = sortedByKeyMap;
    List<int> indexes = List<int>.empty(growable: true);
    for (var element in selectedSlots.keys) {
      indexes.add(element);
    }
    for (int i = 1; i < indexes.length; i++) {
      if ((indexes[i] - indexes[i - 1]) != 1) {
        return 'A reservation must be for a continuous period';
      }
    }
    return confirmReservation();
  }

  /// print out the reservation message
  String confirmReservation(){
    String startTime = selectedSlots.values.first;
    int endTimeSlotIndex = selectedSlots.keys.last + 1;
    String endTime;
    if(timeSlots.length == endTimeSlotIndex){
      endTime = _closingHour;
    } else {
      endTime = timeSlots[endTimeSlotIndex].time;
    }
    String startDate = _useCase.isTomorrow(startTime, _openingHour) ? 'tomorrow' : 'today';
    String endDate = _useCase.isTomorrow(endTime, _openingHour) ? 'tomorrow' : 'today';
    if (startDate == endDate) {
      return 'Your reservation is $startDate from $startTime to $endTime';
    }
    return 'Your reservation is from $startDate $startTime to $endDate $endTime';
  }
}