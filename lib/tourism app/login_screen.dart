import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_screen.dart';

void main(List<String> args) {
  runApp(MaterialApp(home :GofastLoginPage()));
}
class GofastLoginPage extends StatelessWidget {
  static String id = 'gofast_loginpage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            const Flexible(
              child: Center(
                child: Image(
                    width: 150,
                    image: AssetImage('assets/images/maldives.png')),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GofastHomeScreen(),
                      ));
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff2d8ab5)),
                  shape: MaterialStateProperty.all<StadiumBorder>(
                    const StadiumBorder(
                      side: BorderSide.none,
                    ),
                  ),
                ),
                child: const Text(
                  'Login In',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                '- or -',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff2d8ab5)),
                  shape: MaterialStateProperty.all<StadiumBorder>(
                    const StadiumBorder(
                      side: BorderSide.none,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Loginin with Facebook',
                      style: TextStyle(fontSize: 14),
                    ),
                    Icon(Icons.facebook)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff58a3c3)),
                  shape: MaterialStateProperty.all<StadiumBorder>(
                    const StadiumBorder(
                      side: BorderSide.none,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Loginin with Twitter',
                      style: TextStyle(fontSize: 14),
                    ),
                    FaIcon(FontAwesomeIcons.twitter)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xffbb507a)),
                  shape: MaterialStateProperty.all<StadiumBorder>(
                    const StadiumBorder(
                      side: BorderSide.none,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Loginin with Google  ',
                      style: TextStyle(fontSize: 14),
                    ),
                    FaIcon(FontAwesomeIcons.google)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}