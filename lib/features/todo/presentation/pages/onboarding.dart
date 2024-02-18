import 'package:flutter/material.dart';
import 'package:todoappwithcleanarchitecture/main.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFEE6F57)),
      child: Stack(
        children: [
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Image.asset('assets/images/painting.png'),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, TaskAppPageRoutes.taskList);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF0C8CE9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 16.0)
                  ),
                  child: const Text('Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 19)),
                )),
          )
        ],
      ),
    );
  }
}