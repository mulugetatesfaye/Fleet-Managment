import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicle_management/models/vehicle.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<Vehicle>> getVehicles() {
    return _firestore
        .collection('vehicles')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Vehicle.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<void> addVehicle(Vehicle vehicle) async {
    await _firestore.collection('vehicles').add(vehicle.toMap());
  }

  Future<void> updateVehicle(String id, Map<String, dynamic> updates) async {
    await _firestore.collection('vehicles').doc(id).update(updates);
  }
}
