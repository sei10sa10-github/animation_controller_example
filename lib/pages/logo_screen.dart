import 'package:animation_tutorial/widgets/logo.dart';
import 'package:flutter/material.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  CurvedAnimation _curvedAnimation;
  bool _isForward = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 200), vsync: this);
    _curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _animation = Tween<double>(begin: 0, end: 300).animate(_curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status){
        setState(() {
          if (status == AnimationStatus.completed) {
            _isForward = false;
          } else if (status == AnimationStatus.dismissed) {
            _isForward = true;
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Controller'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _animation.value,
          width: _animation.value,
          child: Logo(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Center(child: Image(image: AssetImage('assets/images/twitter.png'), color: Colors.white,)),
        onPressed: () {
          _isForward ? _controller.forward() : _controller.reverse();
        }
      ),
    );
  }
}
