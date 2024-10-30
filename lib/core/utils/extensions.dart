import 'package:flutter/cupertino.dart';

extension RoundedHelper on Widget {
  ClipRRect round(double value) => ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(value)),
        child: this,
      );

  ClipRRect customRound(double tR, double tL, double bL, double bR) =>
      ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(tR),
            topLeft: Radius.circular(tL),
            bottomLeft: Radius.circular(bL),
            bottomRight: Radius.circular(bR)),
        child: this,
      );
}

extension CenterHelper on Widget {
  Center center() => Center(
        child: this,
      );
}

extension PaddingHelper on Widget {
  Padding get p25 => Padding(padding: const EdgeInsets.all(25), child: this);

  Padding get p16 => Padding(padding: const EdgeInsets.all(16), child: this);

  Padding get p8 => Padding(padding: const EdgeInsets.all(8), child: this);

  Padding get p4 => Padding(padding: const EdgeInsets.all(4), child: this);

  /// Set padding according to `value`
  Padding p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Horizontal Padding 16
  Padding get hP4 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: this);

  Padding get hP8 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: this);

  Padding get hP16 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: this);

  Padding get hP20 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: this);

  Padding get hP25 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 25), child: this);

  Padding hp(double value) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);

  Padding get rP4 =>
      Padding(padding: const EdgeInsets.only(right: 4), child: this);

  Padding get rP8 =>
      Padding(padding: const EdgeInsets.only(right: 8), child: this);

  Padding get rP16 =>
      Padding(padding: const EdgeInsets.only(right: 16), child: this);

  Padding get rP25 =>
      Padding(padding: const EdgeInsets.only(right: 25), child: this);

  Padding rp(double value) =>
      Padding(padding: EdgeInsets.only(right: value), child: this);

  Padding get lP4 =>
      Padding(padding: const EdgeInsets.only(left: 4), child: this);

  Padding get lP8 =>
      Padding(padding: const EdgeInsets.only(left: 8), child: this);

  Padding get lP16 =>
      Padding(padding: const EdgeInsets.only(left: 16), child: this);

  Padding get lP25 =>
      Padding(padding: const EdgeInsets.only(left: 25), child: this);

  Padding lp(double value) =>
      Padding(padding: EdgeInsets.only(left: value), child: this);

  Padding bp(double value) =>
      Padding(padding: EdgeInsets.only(bottom: value), child: this);

  Padding get vP25 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 25), child: this);

  Padding get vP16 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: this);

  Padding get vP8 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: this);

  Padding get vP4 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: this);

  Padding vp(double value) =>
      Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);

  Padding setPadding(
          {double top = 0,
          double bottom = 0,
          double left = 0,
          double right = 0}) =>
      Padding(
          padding: EdgeInsets.only(
              top: top, bottom: bottom, right: right, left: left),
          child: this);
}

extension OnPressed on Widget {
  Widget ripple(Function onPressed,
      {BorderRadiusGeometry borderRadius =
      const BorderRadius.all(Radius.circular(5))}) =>
      GestureDetector(
        onTap: () {
          onPressed();
        },
        child: this,
      );
}
