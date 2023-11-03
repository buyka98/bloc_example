import 'package:bloc_example/screens/test_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "my name";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(children: [
        // app bar
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.asset("assets/logo/logo_1.png"),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Node',
                          style: TextStyle(
                            color: Color(0xFF22262E),
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0.08,
                          ),
                        ),
                        TextSpan(
                          text: '.',
                          style: TextStyle(
                            color: Color(0xFFF67051),
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0.08,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Icon(Icons.menu),
          ],
        ),
        SizedBox(height: 30),

        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              // Best Sellers
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Best sellers',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF22262E),
                      fontSize: 32,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.04,
                      letterSpacing: -0.32,
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          Row(
                            children: [
                              Image.asset("assets/avatars/avatar_1.png"),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jailyn Crona',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF22262E),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 1.12,
                                    ),
                                  ),
                                  Text(
                                    '\$23,102.27',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF777E90),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 1.14,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 50),
                            ],
                          )
                      ],
                    ),
                  )
                ],
              ),
              // Best Sellers bottom
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  setState(() {
                    name += "kk ";
                  });
                },
                child: Container(padding: EdgeInsets.all(20), color: Colors.deepOrange, child: TestWidget(name: name)),
              )
              // Image.asset("assets/images/home_img_1.png")
            ],
          ),
        ))
      ]),
    );
  }
}
