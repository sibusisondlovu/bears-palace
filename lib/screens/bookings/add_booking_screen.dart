
import 'package:bears_palace_app/screens/spa/spa_services_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddBookingScreen extends StatefulWidget {
  @override
  _AddBookingScreenState createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {


  bool loading = true;
  final dateFormat = DateFormat("dd MMM yyyy");
  final timeFormat = DateFormat("HH:mm");
  String _myActivity;
  String _myActivityResult;
  
  String _strService;
  String _strBookingDate;
  String _strStartTime;
  String _strEndTime;
  String _dblFee;
  String _numberOfGuests;


  void addToCart(BuildContext context) async{

    String referenceNumber = "TBP" + (DateTime.now().millisecondsSinceEpoch).toString();

    // try{
    //   final response = await http.post(
    //       "http://10.0.0.15/api/v1/bookings/create_booking.php",
    //       body: {
    //         "reference_number": referenceNumber,
    //         "service": _strService,
    //         "bookingDate": _strBookingDate,
    //         "bookingStartTime": _strStartTime,
    //         "bookingEndTime": _strEndTime,
    //         "uid": 'FirebaseAuth.instance.currentUser.uid',
    //         "guests": _numberOfGuests,
    //         "status": 'UNPAID',
    //         "fee": _dblFee,
    //       });
    //
    //   print(response.body);
    //
    //   if (response.body == 'success') {
    //     setState(() {
    //       //_isBusy = false;
    //     });
    //
    //     CoolAlert.show(
    //         context: context,
    //         type: CoolAlertType.success,
    //         text: "Booking added to cart!",
    //         confirmBtnText: 'Continue',
    //         onConfirmBtnTap: (){
    //           // Navigator.pushReplacement(
    //           //   context,
    //           //   MaterialPageRoute(
    //           //       builder: (context) => RootLayoutScreen()),
    //           // );
    //           Navigator.pop((context));
    //           Navigator.pop((context));
    //         }
    //     );
    //   }
    // }catch (e) {
    //   CoolAlert.show(
    //       context: context,
    //       type: CoolAlertType.error,
    //       text: e.toString(),
    //       confirmBtnText: 'Dismiss',
    //       onConfirmBtnTap: (){
    //         Navigator.pop(context);
    //       }
    //   );
    // }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Reference Number') ,
      ) ,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Select service below you would like to make booking for'),
              SizedBox(height: 10,),
              _buildHorseRidingButton(context),
              SizedBox(height: 10,),
              _buildQuadBikingButton(context),
              SizedBox(height: 10,),
              _buildSpaServicesButton(context),
            ] ,
          ),
        ),
      ) ,
    );
  }


Widget _buildHorseRidingButton(BuildContext context) {
  return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 50,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.grey,
          padding: EdgeInsets.all(10.0),
          onPressed: () {
          },
          child: Text(
            "Horse Riding",
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
  );
}

  Widget _buildQuadBikingButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 50,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.grey,
        padding: EdgeInsets.all(10.0),
        onPressed: () {
        },
        child: Text(
          "Quad Biking",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  Widget _buildSpaServicesButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 50,
      child: ElevatedButton(

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpaServicesScreen()),
          );
        },
        child: Text(
          "Spa Services",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  // Widget _buildChooseServiceDropDown(BuildContext context) {
  //   return DropDownFormField(
  //     titleText: null,
  //     hintText: 'Please choose one',
  //     value: _myActivity,
  //     onSaved: (value) {
  //       setState(() {
  //         _myActivity = value;
  //       });
  //     },
  //     onChanged: (value) {
  //       setState(() {
  //         _myActivity = value;
  //       });
  //     },
  //     dataSource: [
  //       {
  //         "display": "SPA",
  //         "value": "Spa",
  //       },
  //       {
  //         "display": "Horse Riding",
  //         "value": "Horse Riding",
  //       },
  //       {
  //         "display": "Quad Biking",
  //         "value": "Quad Biking",
  //       }
  //     ],
  //     textField: 'display',
  //     valueField: 'value',
  //   );
  // }
  //
  // Widget _buildNumberOfGuestsField(BuildContext context) {
  //   return SizedBox(
  //     width: 100,
  //     child: TextFormField(
  //       onChanged: (value){
  //         setState(() {
  //           _numberOfGuests = value;
  //         });
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _buildBookingFeeTextField(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       Text('Service Cost'),
  //       Text(
  //         _dblFee !=null? 'R ' + _dblFee.toString() : 'R 0.00'  ,
  //         style: TextStyle(fontSize: 28.0) ,
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildAddToCartButton(BuildContext context) {
  //   return Container(
  //         width: MediaQuery.of(context).size.width * 0.9,
  //         height: 50,
  //         child: FlatButton(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(25.0),
  //           ),
  //           color: Colors.grey,
  //           padding: EdgeInsets.all(10.0),
  //           onPressed: () {
  //             addToCart(context);
  //             print(_strBookingDate);
  //             print(_strStartTime);
  //             print(_strEndTime);
  //             print(_strService);
  //             print(_numberOfGuests);
  //           },
  //           child: Text(
  //             "ADD TO CART",
  //             style: TextStyle(
  //               fontSize: 14.0,
  //             ),
  //           ),
  //         ),
  //   );
  // }
  //
  // Widget _buildBookingDate(BuildContext context) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0) ,
  //       child: DateTimeField(
  //         format: dateFormat ,
  //         onChanged: (value) {
  //           _strBookingDate = dateFormat.format(value);
  //         } ,
  //         decoration: InputDecoration(
  //           hintText: 'Tap to select date of booking' ,
  //         ) ,
  //         onShowPicker: (context , currentValue) {
  //           return showDatePicker(
  //               context: context ,
  //               firstDate: DateTime(2021) ,
  //               initialDate: currentValue ?? DateTime.now() ,
  //               lastDate: DateTime(2100));
  //         } ,
  //       ) ,
  //     ) ,
  //   );
  // }
  //
  // Widget _buildBookingStartTime(BuildContext context) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: DateTimeField(
  //         format: timeFormat,
  //         onChanged: (value) {
  //           _strStartTime = timeFormat.format(value);
  //         },
  //         decoration:
  //         InputDecoration(hintText: 'Tap to select start time'),
  //         onShowPicker: (context, currentValue) async {
  //           final time = await showTimePicker(
  //             context: context,
  //             initialTime:
  //             TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
  //           );
  //           return DateTimeField.convert(time);
  //         },
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildBookingEndTime(BuildContext context) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: DateTimeField(
  //         format: timeFormat,
  //         onChanged: (value) {
  //           _strEndTime = timeFormat.format(value);
  //         },
  //         decoration:
  //         InputDecoration(hintText: 'Tap to select finish time'),
  //         onShowPicker: (context, currentValue) async {
  //           final time = await showTimePicker(
  //             context: context,
  //             initialTime:
  //             TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
  //           );
  //           return DateTimeField.convert(time);
  //         },
  //       ),
  //     ),
  //   );
  // }
}
