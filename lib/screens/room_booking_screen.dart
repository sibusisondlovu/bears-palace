import 'package:bears_palace_app/screens/confirm_payment_screen.dart';
import 'package:flutter/material.dart';

class RoomBookingScreen extends StatefulWidget {
  const RoomBookingScreen({Key key}) : super(key: key);

  @override
  _RoomBookingScreenState createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen> {

  String _name= "";
  String _surname = "";
  String _contactNumber = "";
  String _emailAddress = "";
  DateTime _checkinDate;
  DateTime _checkOutDate;
  String _roomDescription = "";
  double _bookingCost = 0.00;
  String _bookingStatus = "PENDING";
  String _bookingType = "APP";
  String _bookingReferenceNumber = "";

  // break the guest name and surname
  void _breakNameAndSurname(String fullName){
    var splittedFullName =  fullName.split(" ");

    if (splittedFullName.length > 2){
      // Mari van Zyl
      _name = splittedFullName[0].toString().trim().toUpperCase();
      _surname = splittedFullName[1].toString().trim().toUpperCase() +
          splittedFullName[2].toString().trim().toUpperCase() ;
    }else{
      // Sibusiso Ndlovu
      _name = splittedFullName[0].toString().trim().toUpperCase();
      _surname = splittedFullName[1].toString().trim().toUpperCase() ;
    }
  }

  void _processBooking() {
    // pass variables to webview for payfast processing
    var currentTimeStamp = new DateTime.now().millisecondsSinceEpoch;

    // convert to string
    String buildReferenceNumber = currentTimeStamp.toString();
    _bookingReferenceNumber = new DateTime.now().year.toString()+"/" +
        new DateTime.now().month.toString()+"/" + buildReferenceNumber.substring(buildReferenceNumber.length - 6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Booking'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _personalDetailsCard(context),
                _checkinDatesCard(context),
                _roomDetailsCard(context),
                SizedBox(height: 20,),
                _paymentDetailsCard(context),
                _paymentButton(context)
              ],
            ),
          ),
        ));
  }
  Widget _personalDetailsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Personal Details', style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
              TextFormField(
                onChanged: (value){

                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Colors.blueAccent,
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Name and Surname',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                onChanged: (value){

                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.blueAccent,
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Contact Number',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                onChanged: (value){

                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.blueAccent,
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email Address',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _roomDetailsCard(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset('assets/images/search_room_bg.jpg'),
        title: Text('Standard Room'),
        subtitle: Text('R 850/night'),
        trailing: Text('View details'),
      ),
    );
  }
  Widget _paymentDetailsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Details', style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          ListTile(
            title: Text('Standard Room'),
            trailing: Text('R 200.00', style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
          ),
        ],
      ),
    );
  }
  Widget _checkinDatesCard(BuildContext context) {
    return Card(
        child:SizedBox(
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2019, 1),
                    lastDate: DateTime(2021, 12),
                  ).then((pickedDate) {
                    setState(() {
                      // _selectedCheckinDate = pickedDate;
                      // _checkInDate = DateFormat('dd MMM yyyy').format(pickedDate).toString();
                    });
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Check out',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                border: Border.all(
                                  color: Colors.blueAccent,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.event),
                                  Text('')
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Check out',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blueAccent),
                      ),
                      GestureDetector(
                        onTap: (){
                          showDatePicker(
                            context: context,
                            // initialDate: _selectedCheckinDate.add(Duration(days: 1)),
                            // firstDate: _selectedCheckinDate.add(Duration(days: 1)),
                            lastDate: DateTime(2021, 12),
                          ).then((pickedDate) {
                            setState(() {
                              //  _checkOutDate = DateFormat('dd MMM yyyy').format(pickedDate).toString();
                            });
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                border: Border.all(
                                  color: Colors.blueAccent,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(Icons.event),
                                  Expanded(child: Container()),
                                  Text('')
                                ],
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
  Widget _paymentButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        child: Text('PAY NOW(R $_bookingCost)'),
        onPressed: (){
          _processBooking();
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>ConfirmPaymentScreen(totalAmount:_bookingCost.toString(),
                                                      itemName: _roomDescription,
                                                      paymentId: _bookingReferenceNumber)
          ));
        },
      ),
    );
  }
}
