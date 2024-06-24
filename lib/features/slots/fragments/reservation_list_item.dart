import 'package:flutter/material.dart';
import 'package:time_slots_sample/data/reservation_slot.dart';

class ReservationTimeListItem extends StatefulWidget {
  final ReservationSlot reservationSlot;
  final int index;
  final Function onClick;

  const ReservationTimeListItem({super.key, required this.reservationSlot, required this.index, required this.onClick});

  @override
  State<ReservationTimeListItem> createState() => _ReservationTimeListItemState();
}

class _ReservationTimeListItemState extends State<ReservationTimeListItem> {
  // indicates whether the slot is currently selected by the user or not
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.reservationSlot.isReserved) {
          widget.onClick(widget.reservationSlot, widget.index, isSelected);
          setState(() => isSelected = !isSelected);
        }
      },
      child: Card(
        color: widget.reservationSlot.isReserved
            ? Colors.grey
            : isSelected
                ? Colors.green
                : Colors.amber,
        child: Center(
          child: Text(
            widget.reservationSlot.time,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
