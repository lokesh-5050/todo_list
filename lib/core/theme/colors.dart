import 'package:flutter/material.dart';

// Colors used through out the application

//primary colors
const Color transparent = Colors.transparent;
const Color aquaGreenColor = Color(0xFF00CC4E);
const Color lavaRedColor = Color(0xFFD82F0E);
const Color unselectedFilterChip = Color.fromARGB(255, 241, 123, 69);

const Color whiteColor = Color(0xFFFFFFFF);
const Color shipGreyColor = Color.fromARGB(255, 23, 23, 24);
const Color lightGreyColor = Color.fromARGB(255, 235, 235, 235);
const Color shipGreyColor1 = Color(0xFF505462);
const Color limedAshColor = Color(0xFF71796E);
const Color ligthFaceBookColor = Colors.blueAccent;
const Color shadeBlueColor = Color(0XFF3C499A);
const Color backgroundAppBarColor = Color(0XFFE13761);
const Color backgroundBottomAppBarColor = Color.fromRGBO(240, 81, 82, 1);

const Color iconsColor = Color(0xffF05152);
const Color bottomNavColors = Color.fromARGB(62, 163, 160, 160);
const Color bottomNavColor = Color.fromARGB(137, 240, 81, 81);
const Color bottomNavColor2 = Color.fromARGB(136, 232, 24, 24);
const Color logoColorBtn = Color(0XFF9B2A4B);
const Color yellowGrad = Color.fromARGB(255, 241, 123, 69);

//more_color_from_color_schemes_start
const orangeBeige = Color(0XFFF5875F);
const yellowBeige = Color.fromARGB(255, 237, 175, 82);
const lightOffWhite = Color(0XFFF0DEC9);
const babyPink = Color.fromARGB(255, 228, 141, 143);
const babyPink2 = Color.fromARGB(255, 255, 180, 180);
//more_color_from_color_schemes_end

//admin_dashboard
const Color aquaLimeGreyGreenColor = Color.fromARGB(187, 16, 109, 109);

//splash screen
const Color splashMainColor = Color.fromARGB(172, 233, 59, 236);

// text Colors
const Color textFieldColor = Color(0x1AE4E4E4);
const Color darkBlackColor = Color(0xFF000000);

MaterialColor primarySwatchColor = MaterialColor(0xFFF05152, color);
const Color primaryTextColor = Color(0xFF33343B);
const Color bodyTextColor = Color(0xFF000000);
const Color textInputTitleColor = Color(0xFF808191);
// const Color createProfileButtonColor = Color(0xFF6C5DD3);
const Color activeBottomNavItemColor = Color(0xFFFFFFFF);
const Color defaultBottomNavItemColor = Color(0xFF000000);

const Color iconColor = Color.fromARGB(255, 22, 18, 18);
const Color veryLightCardGrey = Color.fromARGB(51, 182, 181, 181);

const Color isLoadingBackGroundColor = Color.fromARGB(113, 112, 112, 112);

const Color unratedStarFillColor = Color(0xFFA1A1A1);

const Color borderColor = Color.fromARGB(255, 234, 233, 233);

const LinearGradient gradientColorSchemeTopCenterToBottomRight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(225, 55, 95, 1),
      Color.fromRGBO(240, 81, 82, 1),
      Color.fromRGBO(252, 183, 108, 1),
    ]);

const LinearGradient gradientColorSchemeTopRightToBottomRight = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(225, 55, 95, 1),
      Color.fromRGBO(240, 81, 82, 1),
      Color.fromRGBO(252, 183, 108, 1),
    ]);

// final LinearGradient gradientColorSchemeTop = LinearGradient(colors: [
//   Color.fromRGBO(225, 55, 95, 1),
//   Color.fromRGBO(240, 81, 82, 1),
//   Color.fromRGBO(252, 183, 108, 1),
// ]);
// var gradientColorScheme = {
//   Color.fromRGBO(225, 55, 95, 1),
//   Color.fromRGBO(240, 81, 82, 1),
//   Color.fromRGBO(252, 183, 108, 1),
// };

Map<int, Color> color = {
  50: const Color.fromRGBO(252, 183, 108, 1),
  100: const Color.fromRGBO(240, 81, 82, 1),
  200: const Color.fromRGBO(240, 81, 82, 1),
  300: const Color.fromRGBO(240, 81, 82, 1),
  400: const Color.fromRGBO(252, 183, 108, 1),
  500: const Color.fromRGBO(252, 183, 108, 1),
  600: const Color.fromRGBO(252, 183, 108, 1),
  700: const Color.fromRGBO(252, 183, 108, 1),
  800: const Color.fromRGBO(240, 81, 82, 1),
  900: const Color.fromRGBO(252, 183, 108, 1),
};
