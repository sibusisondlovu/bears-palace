import 'package:bears_palace_app/screens/spa/spa_service_booking_confirm_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpaBookingFormScreen extends StatefulWidget {

  final service;

  SpaBookingFormScreen({Key key, @required this.service}):super(key: key);

  @override
  _SpaBookingFormScreenState createState() => _SpaBookingFormScreenState();
}

class _SpaBookingFormScreenState extends State<SpaBookingFormScreen> {
  bool loading = true;
  final dateFormat = DateFormat("dd MMM yyyy");
  final timeFormat = DateFormat("HH:mm");

  String _strBookingDate;
  String _strStartTime;
  int _numberOfGuests = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service['name']),
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
                SizedBox(height: 15,),
                Text('Number of people'),
                SizedBox(
                    width: 120,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value){
                        _numberOfGuests = int.parse(value);
                      },

                    )),
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
            hintText: 'Tap to select date' ,
          ) ,
          onShowPicker: (context , currentValue) {
            return showDatePicker(
                context: context ,
                firstDate: DateTime(2021) ,
                initialDate: currentValue ?? DateTime.now() ,
                lastDate: DateTime(2022));
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
          InputDecoration(hintText: 'Tap to select time'),
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
          if (_strBookingDate == null) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: "Field Required",
              text: "Please select booking date",
            );
            return;
          }

          if (_strStartTime == null) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: "Field Required",
              text: "Please select start time",
            );
            return;
          }

          if (_numberOfGuests == 0) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: "Field Required",
              text: "Please enter number of guests",
            );
            return;
          }

          var booking = {
            'service': widget.service['name'],
            'price' : widget.service['price'],
            'bookingDate': _strBookingDate,
            'startTime': _strStartTime,
            'numberOfGuests' : _numberOfGuests
          };


          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpaServiceBookingConfirmScreen(booking: booking)),
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
