import 'package:flutter/material.dart';

void main() {
  runApp(FlashlightApp());
}

class FlashlightApp extends StatefulWidget {
  @override
  _FlashlightAppState createState() => _FlashlightAppState();
}

class _FlashlightAppState extends State<FlashlightApp> {
  bool _isOn = false; 

  void toggleTorch() {
    setState(() {
      _isOn = !_isOn; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
           
              Image.asset(
                _isOn
                    ? 'assets/Group 1-2.png'  //  on
                    : 'assets/Group 1.png', //  off
                width: 300,
                height: 535.90,
              ),
              SizedBox(height: 20),
              // Button to toggle 
              GestureDetector(
                onTap: toggleTorch,  
                child: Container(
                  width: 136,
                  height: 36,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Color(0xFFFF9736), 
                      width: 1,
                    ),
                    color: _isOn ? Color(0xFFFF9736) : Colors.transparent,
                  ),
                  child: Stack(
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              _isOn ? 'Off' : 'On',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              _isOn ? '' : 'Off',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                     
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        left: _isOn ? 57 : 0,  
                        child: Container(
                          width: 68,
                          height: 25,
                          decoration: BoxDecoration(
                            color: _isOn ? Color(0xFFFFCB9B) : Colors.white, 
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Text(
                              _isOn ? 'On' : 'On',
                              style: TextStyle(
                                color: _isOn ? Colors.black : Colors.black, 
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
