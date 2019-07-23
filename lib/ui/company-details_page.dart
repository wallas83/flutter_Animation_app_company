import 'package:company_app/model/company.dart';
import 'package:company_app/ui/company_detail_intro_animation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:ui' as ui;

class CompanyDetailsPage extends StatelessWidget {

  CompanyDetailsPage({
    @required this.company, @required AnimationController controller})
      :animation = new CompanyDetailsIntroAnimation(controller);

  final Company company;
  final CompanyDetailsIntroAnimation animation;

  Widget _createAnimation( BuildContext context, Widget child) {

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Opacity(
          opacity: animation.bgdropOpacity.value,
          child: Image.asset(company.backdropPhoto, fit: BoxFit.cover,),
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: animation.bgdropBlur.value,
            sigmaY: animation.bgdropBlur.value,
          ),
          child: new Container(
            color: Colors.black.withOpacity(0.3),
            child: _createContent(),
          ),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new AnimatedBuilder(animation: animation.controller, builder: _createAnimation,),
    );
  }

  Widget _createContent() {
    return new SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createLogoAvatar()
        ],
      ),
    );
  }

  Widget _createLogoAvatar() {
    return new Transform(transform: new Matrix4.diagonal3Values(
        animation.avatarSize.value, animation.avatarSize.value, 1.0),
      alignment: Alignment.center,
      child: new Container(
        width: double.infinity, height: 110.0, margin: const EdgeInsets.only(top: 32.0, left: 19.0),
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              child: new Image.asset(company.logo, width: 100.0, height: 100.0,),

            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Build Apps with will',
            style: TextStyle(
              fontSize: 19 * animation.avatarSize.value + 2.0,
              color: Colors.white70
            ),),
          )
        ],
      ),),);
  }


}
