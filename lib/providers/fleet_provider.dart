import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_management/models/vehicle.dart';
import 'package:vehicle_management/services/fleet_service.dart';

class VehicleNotifier extends StateNotifier<List<Vehicle>> {
  final FirebaseService _firebaseService;

  VehicleNotifier(this._firebaseService) : super([]) {
    loadVehicles();
  }

  void loadVehicles() {
    _firebaseService.getVehicles().listen((vehicles) {
      state = vehicles;
    });
  }

  Future<void> addVehicle(Vehicle vehicle) async {
    await _firebaseService.addVehicle(vehicle);
    loadVehicles();
  }

  Future<void> updateVehicle(Vehicle updatedVehicle) async {
    try {
      final vehicleRef = FirebaseFirestore.instance
          .collection('vehicles')
          .doc(updatedVehicle.id);
      await vehicleRef.update({
        'name': updatedVehicle.name,
        'fuelLevel': updatedVehicle.fuelLevel,
        'status': updatedVehicle.status,
        'updatedAt': updatedVehicle.updatedAt,
      });

      // Update the local state after the Firestore update
      state = [
        for (final vehicle in state)
          if (vehicle.name == updatedVehicle.name) updatedVehicle else vehicle
      ];
    } catch (e) {
      // Handle error
      print('Failed to update vehicle: $e');
    }
  }
}

final vehicleProviderNotifier =
    StateNotifierProvider<VehicleNotifier, List<Vehicle>>((ref) {
  return VehicleNotifier(FirebaseService());
});
