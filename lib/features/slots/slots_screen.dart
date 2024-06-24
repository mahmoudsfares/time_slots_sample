import 'package:flutter/material.dart';
import 'package:time_slots_sample/data/reservation_slot.dart';
import 'package:time_slots_sample/features/slots/fragments/reservation_list_item.dart';
import 'package:time_slots_sample/features/slots/slots_viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SlotsScreen extends StatefulWidget {

  const SlotsScreen({super.key});

  @override
  State<SlotsScreen> createState() => _SlotsScreenState();
}

class _SlotsScreenState extends State<SlotsScreen> {

  final SlotsViewModel _viewModel = SlotsViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.convertTimeRangeToSlots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Available slots",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    crossAxisCount: 2,
                    mainAxisExtent: 60,
                  ),
                  itemCount: _viewModel.timeSlots.length,
                  itemBuilder: (context, index) {
                    return ReservationTimeListItem(
                      reservationSlot: _viewModel.timeSlots[index],
                      index: index,
                      onClick: (ReservationSlot slot, int index, bool isSelected) {
                        if (!isSelected) {
                          _viewModel.selectedSlots[index] = slot.time;
                        } else {
                          _viewModel.selectedSlots.remove(index);
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  child: const Text('SUBMIT RESERVATION'),
                  onPressed: () {
                    String reservationValidation = _viewModel.validateReservation();
                    Fluttertoast.showToast(msg: reservationValidation);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
