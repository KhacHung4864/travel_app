import 'package:flutter/material.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  TripScreenState createState() => TripScreenState();
}

class TripScreenState extends State<TripScreen> {
  final _formKey = GlobalKey<FormState>();
  String _tripName = '';
  String _destination = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  _selectDate(BuildContext context, TextEditingController controller, bool isStartDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != _startDate) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
          _startDateController.text = selectedDate.toLocal().toString().split(' ')[0];
        } else {
          _endDate = selectedDate;
          _endDateController.text = selectedDate.toLocal().toString().split(' ')[0];
        }
      });
    }
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Trip Name'),
                onSaved: (value) {
                  _tripName = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a trip name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Destination'),
                onSaved: (value) {
                  _destination = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a destination';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(labelText: 'Start Date'),
                readOnly: true,
                onTap: () => _selectDate(context, _startDateController, true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a start date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(labelText: 'End Date'),
                readOnly: true,
                onTap: () => _selectDate(context, _endDateController, false),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select an end date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    // Handle form submission
                    print('Trip Name: $_tripName');
                    print('Destination: $_destination');
                    print('Start Date: $_startDate');
                    print('End Date: $_endDate');
                  }
                },
                child: Text('Create Trip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
