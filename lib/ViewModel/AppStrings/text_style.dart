import 'package:event_management/ViewModel/AppStrings/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleUtils {
  // Heading style
  static TextStyle get heading => GoogleFonts.poppins(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: ColorUtils.blackColor,
      );
  //Title heading
  static TextStyle get titleHeading => GoogleFonts.poppins(
        color: ColorUtils.blackColor,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      );
  //
  static TextStyle get subTitleHeading => GoogleFonts.poppins(
        color: ColorUtils.blackColor,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      );
  //brown Shadow

  static TextStyle get browShadow => GoogleFonts.poppins(
        color: ColorUtils.pinkShade,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );
  //description
  static TextStyle get description => GoogleFonts.poppins(
        color: ColorUtils.blackColor,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      );
  //description
  static TextStyle get descriptionForTitle => GoogleFonts.poppins(
        color: ColorUtils.blackColor,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      );
  // light style
  static TextStyle get lightW400 => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: ColorUtils.greyShade,
      );

  //whiteW400
  static TextStyle get whiteW400 => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: ColorUtils.whiteColor,
      );
  //white heading
  static TextStyle get whiteHeading24 => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: ColorUtils.whiteColor,
      );
  //brownHeading
  static TextStyle get brownHeading24 => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: ColorUtils.pinkShade,
      );
  //blueHeading
  static TextStyle get blueHeading => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: ColorUtils.blueShade,
      );
  //whiteW400
  static TextStyle get whiteHeading => GoogleFonts.poppins(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: ColorUtils.whiteColor,
      );
  //black
  static TextStyle get black12 => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ColorUtils.blackColor,
      );
}
