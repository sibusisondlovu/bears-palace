import 'package:bears_palace_app/screens/activation/activate_profile.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  bool isActivated = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse(AppColors.primaryColor)),
        title: Text('Photos'),
      ),
      body: isActivated? Text('Photos Screen'): ActivateProfile(),
    );
  }
}
