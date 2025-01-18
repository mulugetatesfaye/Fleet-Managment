import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  String id;
  String name;
  String status;
  double fuelLevel;
  double batteryLevel;
  Map<String, double>? lastKnownLocation;
  DateTime updatedAt;

  Vehicle({
    required this.id,
    required this.name,
    required this.status,
    required this.fuelLevel,
    required this.batteryLevel,
    this.lastKnownLocation,
    required this.updatedAt,
  });

  // Adding copyWith method to Vehicle model
  Vehicle copyWith({
    String? name,
    double? fuelLevel,
    String? status,
    DateTime? updatedAt,
  }) {
    return Vehicle(
      id: id,
      name: name ?? this.name,
      fuelLevel: fuelLevel ?? this.fuelLevel,
      status: status ?? this.status,
      batteryLevel: batteryLevel,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Vehicle.fromMap(String id, Map<String, dynamic> data) {
    return Vehicle(
      id: id,
      name: data['name'],
      status: data['status'],
      fuelLevel: data['fuelLevel']?.toDouble() ?? 0.0,
      batteryLevel: data['batteryLevel']?.toDouble() ?? 0.0,
      lastKnownLocation: data['lastKnownLocation'] != null
          ? Map<String, double>.from(data['lastKnownLocation'])
          : null,
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'status': status,
      'fuelLevel': fuelLevel,
      'batteryLevel': batteryLevel,
      'lastKnownLocation': lastKnownLocation,
      'updatedAt': updatedAt,
    };
  }
}
