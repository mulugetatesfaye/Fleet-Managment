import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_management/models/vehicle.dart';
import 'package:vehicle_management/providers/fleet_provider.dart';

class UpdateVehicleScreen extends ConsumerStatefulWidget {
  final Vehicle vehicle;

  const UpdateVehicleScreen({super.key, required this.vehicle});

  @override
  _UpdateVehicleScreenState createState() => _UpdateVehicleScreenState();
}

class _UpdateVehicleScreenState extends ConsumerState<UpdateVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _fuelController;
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.vehicle.name);
    _fuelController =
        TextEditingController(text: widget.vehicle.fuelLevel.toString());
    _statusController = TextEditingController(text: widget.vehicle.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Vehicle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Vehicle Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vehicle name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fuelController,
                decoration: const InputDecoration(
                  labelText: 'Fuel Level (%)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter fuel level';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) < 0 ||
                      double.parse(value) > 100) {
                    return 'Enter a valid fuel level between 0 and 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(
                  labelText: 'Status (e.g., Active, Inactive)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vehicle status';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final updatedVehicle = widget.vehicle.copyWith(
                      name: _nameController.text,
                      fuelLevel: double.parse(_fuelController.text),
                      status: _statusController.text,
                      updatedAt: DateTime.now(),
                    );
                    // Call the provider to update the vehicle
                    ref
                        .read(vehicleProviderNotifier.notifier)
                        .updateVehicle(updatedVehicle);
                    Navigator.pop(context); // Go back after updating
                  }
                },
                child: const Text('Update Vehicle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
