import 'package:bears_palace_app/screens/spa/spa_service_booking_confirm_screen.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpaBookingFormScreen extends StatefulWidget {
  @override
  _SpaBookingFormScreenState createState() => _SpaBookingFormScreenState();
}

class _SpaBookingFormScreenState extends State<SpaBookingFormScreen> {
  bool loading = true;
  final dateFormat = DateFormat("dd MMM yyyy");
  final timeFormat = DateFormat("HH:mm");

  String _strService;
  String _strBookingDate;
  String _strStartTime;
  String _strEndTime;
  String _dblFee;
  String _numberOfGuests;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Spa Service Booking'),
      ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBookingDate(context),
                _buildBookingStartTime(context),
                _buildBookingEndTime(context),
                SizedBox(height: 15,),
                Text('Number of people'),
                SizedBox(
                    width: 120,
                    child: TextField()),
                SizedBox(height: 15,),
                Text('Booking terms and conditions goes here', style: TextStyle(
                  fontSize: 12
                ),),
                SizedBox(height: 15,),
                _buildContinueButton(context)
              ],
            ),
          ),
        ));
  }

  Widget _buildBookingDate(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0) ,
        child: DateTimeField(
          format: dateFormat ,
          onChanged: (value) {
            _strBookingDate = dateFormat.format(value);
          } ,
          decoration: InputDecoration(
            hintText: 'Tap to select date of booking' ,
          ) ,
          onShowPicker: (context , currentValue) {
            return showDatePicker(
                context: context ,
                firstDate: DateTime(2021) ,
                initialDate: currentValue ?? DateTime.now() ,
                lastDate: DateTime(2100));
          } ,
        ) ,
      ) ,
    );
  }

  Widget _buildBookingStartTime(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DateTimeField(
          format: timeFormat,
          onChanged: (value) {
            _strStartTime = timeFormat.format(value);
          },
          decoration:
          InputDecoration(hintText: 'Tap to select start time'),
          onShowPicker: (context, currentValue) async {
            final time = await showTimePicker(
              context: context,
              initialTime:
              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.convert(time);
          },
        ),
      ),
    );
  }

  Widget _buildBookingEndTime(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DateTimeField(
          format: timeFormat,
          onChanged: (value) {
            _strEndTime = timeFormat.format(value);
          },
          decoration:
          InputDecoration(hintText: 'Tap to select finish time'),
          onShowPicker: (context, currentValue) async {
            final time = await showTimePicker(
              context: context,
              initialTime:
              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.convert(time);
          },
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpaServiceBookingConfirmScreen()),
          );
        },
        child: Text(
          "Continue",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
