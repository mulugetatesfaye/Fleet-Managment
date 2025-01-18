import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_management/providers/fleet_provider.dart';
import 'package:vehicle_management/screens/add_vehicle.dart';
import 'package:vehicle_management/screens/vehicle_detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(vehicleProviderNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vehicle Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: vehicles.isEmpty
          ? const Center(
              child: Text(
                'No vehicles available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = vehicles[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        vehicle.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        'Status: ${vehicle.status}\nFuel: ${vehicle.fuelLevel}%\nLast Updated Location: ${vehicle.lastKnownLocation}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.deepPurpleAccent,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VehicleDetailsScreen(vehicle: vehicle),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddVehicleScreen(),
              ));
        },
        heroTag: 'addVehicle',
        tooltip: 'Add Vehicle',
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
