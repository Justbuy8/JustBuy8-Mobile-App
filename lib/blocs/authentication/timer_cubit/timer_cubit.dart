// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_state.dart';

class OtpTimerCubit extends Cubit<OtpTimerState> {
  int i = 30; // Initialize the timer value to 30 seconds.
  late Timer timer; // Declare a Timer object for countdown.

  OtpTimerCubit() : super(const OtpTimerInitial());

  // Start the OTP timer countdown.
  startOtpIntervals() async {
    emit(OtpTimerRunning(secondsValue: i)); // Emit the initial timer state.
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(OtpTimerRunning(secondsValue: i)); // Update timer state.
      i--; // Decrement the timer value.
      if (i == 0) {
        i = 30; // Reset timer value.
        timer.cancel(); // Cancel the timer.
        emit(const OtpTimerStoppedShowButton()); // Emit timer stopped state.
      }
    });
  }

  // Pause the OTP timer.
  pauseTimer() {
    timer.cancel(); // Cancel the timer.
    emit(OtpTimerInitial()); // Emit the initial timer state.
  }

  // Stop and reset the OTP timer.
  stopTimer() {
    timer.cancel(); // Cancel the timer.
    i = 30; // Reset timer value.
    emit(const OtpTimerStoppedShowButton()); // Emit timer stopped state.
  }
}
