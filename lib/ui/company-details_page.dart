import 'dart:ui' as ui;

import 'package:company_app/model/company.dart';
import 'package:company_app/ui/company_detail_intro_animation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CompanyDetailsPage extends StatelessWidget {
  CompanyDetailsPage(
      {@required this.company, @required AnimationController controller})
      : animation = new CompanyDetailsIntroAnimation(controller);

  final Company company;
  final CompanyDetailsIntroAnimation animation;

  Widget _createAnimation(BuildContext context, Widget child) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Opacity(
          opacity: animation.bgdropOpacity.value,
          child: Image.asset(
            company.backdropPhoto,
            fit: BoxFit.cover,
          ),
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
      body: new AnimatedBuilder(
        animation: animation.controller,
        builder: _createAnimation,
      ),
    );
  }

  Widget _createContent() {
    return new SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createLogoAvatar(),
          _createAboutCompany()
        ],
      ),
    );
  }

  Widget _createLogoAvatar() {
    return new Transform(
      transform: new Matrix4.diagonal3Values(
          animation.avatarSize.value, animation.avatarSize.value, 1.0),
      alignment: Alignment.center,
      child: new Container(
        width: double.infinity,
        height: 110.0,
        margin: const EdgeInsets.only(top: 32.0, left: 19.0),
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              child: new Image.asset(
                company.logo,
                width: 100.0,
                height: 100.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Build Apps with will',
                style: TextStyle(
                    fontSize: 19 * animation.avatarSize.value + 2.0,
                    color: Colors.white70),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createAboutCompany() {
    return new Padding(
      padding: const EdgeInsets.only(top: 14.0, left: 14.0, right: 14.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            company.name,
            style: new TextStyle(
                color: Colors.white.withOpacity(animation.nameOpacity.value),
                fontSize: 30.0 * animation.avatarSize.value + 2.0,
                fontWeight: FontWeight.bold),
          ),
          new Text(
            company.location,
            style: new TextStyle(
                color: Colors.white.withOpacity(animation.locationOpacity.value),
                fontWeight: FontWeight.w400),

          ),
          //line/Divider
           new Container(
             color: Colors.white.withOpacity(animation.locationOpacity.value),
             margin: const EdgeInsets.symmetric(vertical: 14.0),
             width: animation.dividerWidth.value,
             height: 1.0,
           )
        ],
      ),
    );
  }
}
