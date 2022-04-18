import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ditonton/common/constants.dart';

void main() {
  test('must properly return a specificed text theme', () {
    // arrange
    final TextStyle tkHeading5 =
        GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);
    final TextStyle tkHeading6 = GoogleFonts.poppins(
        fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
    final TextStyle tkSubtitle = GoogleFonts.poppins(
        fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
    final TextStyle tkBodyText = GoogleFonts.poppins(
        fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);

// act
    final tkTextTheme = TextTheme(
      headline5: tkHeading5,
      headline6: tkHeading6,
      subtitle1: tkSubtitle,
      bodyText2: tkBodyText,
    );

    // assert
    expect(kHeading5, tkHeading5);
    expect(kHeading6, tkHeading6);
    expect(kSubtitle, tkSubtitle);
    expect(kBodyText, tkBodyText);
    expect(kTextTheme, tkTextTheme);
  });
}
