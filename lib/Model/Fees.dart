import 'package:flutter/material.dart';

class Fees {
  int? delivaryFees;
  int? outTimeFees;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int? floorFee;

  Fees({
    this.delivaryFees,
    this.outTimeFees,
    this.startTime,
    this.endTime,
    this.floorFee,
  });

  Fees.fromJson(Map<String, dynamic> json) {
    delivaryFees = json['delivary_fees'];
    outTimeFees = json['out_time_fees'];
    startTime = parseTime(json['start_time']);
    endTime = parseTime(json['end_time']);
    floorFee = json['floor_fee'];
  }

  TimeOfDay? parseTime(String? time) {
    if (time == null) return null;
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
