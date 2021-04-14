import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bears_palace_app/models/service_model.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddBookingScreen extends StatefulWidget {
  @override
  _AddBookingScreenState createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {

  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Service>> key = new GlobalKey();
  static List<Service> services = new List<Service>();
  bool loading = true;
  final dateFormat = DateFormat("dd MMM yyyy");
  final timeFormat = DateFormat("HH:mm");
  
  String _strService;
  String _strBookingDate;
  String _strStartTime;
  String _strEndTime;
  String _dblFee;
  String _numberOfGuests;

  void getServices() async {
    try {
      final response =
      await http.get(

          "http://10.0.2.2:3000/api/v1/services/get_services.php");
      if (response.statusCode == 200) {
        services = loadUsers(response.body);
        print('Services: ${services.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting services.");
      }
    } catch (e) {
      print("Error getting services.\n" + e.toString());
    }
  }

  static List<Service> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String , dynamic>>();
    return parsed.map<Service>((json) => Service.fromJson(json)).toList();
  }

  void addToCart(BuildContext context) async{

    String referenceNumber = "TBP" + (DateTime.now().millisecondsSinceEpoch).toString();

    try{
      final response = await http.post(
          "http://10.0.0.15/api/v1/bookings/create_booking.php",
          body: {
            "reference_number": referenceNumber,
            "service": _strService,
            "bookingDate": _strBookingDate,
            "bookingStartTime": _strStartTime,
            "bookingEndTime": _strEndTime,
            "uid": 'FirebaseAuth.instance.currentUser.uid',
            "guests": _numberOfGuests,
            "status": 'UNPAID',
            "fee": _dblFee,
          });

      print(response.body);

      if (response.body == 'success') {
        setState(() {
          //_isBusy = false;
        });

        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Booking added to cart!",
            confirmBtnText: 'Continue',
            onConfirmBtnTap: (){
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => RootLayoutScreen()),
              // );
              Navigator.pop((context));
              Navigator.pop((context));
            }
        );
      }
    }catch (e) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: e.toString(),
          confirmBtnText: 'Dismiss',
          onConfirmBtnTap: (){
            Navigator.pop(context);
          }
      );
    }
  }

  @override
  void initState() {
    getServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Reference Number') ,
      ) ,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Service'),
                _buildServiceTextField(context) ,
                SizedBox(height: 15,),
                Text('Date of Booking'),
                _buildBookingDate(context),
                SizedBox(height: 15,),
                Text('Start Time'),
                _buildBookingStartTime(context),
                SizedBox(height: 15,),
                Text('Finish Time'),
                _buildBookingEndTime(context),
                SizedBox(height: 15,),
                Text('Number of Guests/Visitors'),
                _buildNumberOfGuestsField(context),
                SizedBox(height: 15,),
                _buildBookingFeeTextField(context),
                SizedBox(height: 15,),
                _buildAddToCartButton(context)
              ] ,
            ) ,
          ),
        ),
      ) ,
    );
  }

  Widget _buildServiceTextField(BuildContext context) {
    return loading
        ? CircularProgressIndicator() : searchTextField = AutoCompleteTextField<Service>(
      key: key ,
      clearOnSubmit: false ,
      suggestions: services ,
      style: TextStyle(color: Colors.grey , fontSize: 16.0) ,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0 , 30.0 , 10.0 , 20.0) ,
        hintText: "Search Service" ,
        hintStyle: TextStyle(color: Colors.grey) ,
      ) ,
      itemFilter: (service , query) {
        return service.serviceName
            .toLowerCase()
            .startsWith(query.toLowerCase());
      } ,
      itemSorter: (a , b) {
        return a.serviceName.compareTo(b.serviceName);
      } ,
      itemSubmitted: (service) {
        setState(() {
          searchTextField.textField.controller.text = service.serviceName;

        });

        _strService = service.serviceName;
        _dblFee = service.fee;
      } ,
      itemBuilder: (context , service) {
        // ui for the autocomplete row
        return row(service);
      } ,
    );
  }

  Widget row(Service service) {
    return Text(
      service.serviceName ,
      style: TextStyle(fontSize: 16.0) ,
    );
  }

  Widget _buildNumberOfGuestsField(BuildContext context) {
    return SizedBox(
      width: 100,
      child: TextFormField(
        onChanged: (value){
          setState(() {
            _numberOfGuests = value;
          });
        },
      ),
    );
  }

  Widget _buildBookingFeeTextField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Service Cost'),
        Text(
          _dblFee !=null? 'R ' + _dblFee.toString() : 'R 0.00'  ,
          style: TextStyle(fontSize: 28.0) ,
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            color: Colors.grey,
            padding: EdgeInsets.all(10.0),
            onPressed: () {
              addToCart(context);
              print(_strBookingDate);
              print(_strStartTime);
              print(_strEndTime);
              print(_strService);
              print(_numberOfGuests);
            },
            child: Text(
              "ADD TO CART",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
    );
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
}
