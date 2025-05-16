import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Using flutter_svg for SVG rendering

class UnidocLogo extends StatelessWidget {
  final double size;
  final Color lightColor;
  final Color darkColor;

  const UnidocLogo({
    super.key,
    this.size = 40,
    this.lightColor = Colors.blue, // Default light color
    this.darkColor = Colors.blueAccent, // Default dark color
  });

  @override
  Widget build(BuildContext context) {
    // Helper to convert Color to hex string FFxxxxxx -> xxxxxx
    String colorToHex(Color color) {
      return color.value.toRadixString(16).padLeft(8, '0').substring(2);
    }

    String svgString = '''
    <svg width="${size}px" height="${size}px" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M20 3.33337C10.8 3.33337 3.33337 10.8 3.33337 20C3.33337 29.2 10.8 36.6667 20 36.6667C29.2 36.6667 36.6667 29.2 36.6667 20C36.6667 10.8 29.2 3.33337 20 3.33337Z" fill="url(#paint0_linear_splash_logo_${key.toString()})")/>
      <path d="M20 3.33337C10.8 3.33337 3.33337 10.8 3.33337 20C3.33337 29.2 10.8 36.6667 20 36.6667C29.2 36.6667 36.6667 29.2 36.6667 20C36.6667 10.8 29.2 3.33337 20 3.33337Z" fill="url(#paint1_linear_splash_logo_${key.toString()})")/>
      <path d="M15.0984 25.0312H13.332V15.1797H15.0984V17.2656C15.5404 16.4792 16.1791 15.9167 17.0143 15.5781C17.8495 15.2344 18.7734 15.0625 19.7858 15.0625C20.8685 15.0625 21.8138 15.2639 22.6211 15.6658C23.4283 16.0677 24.0436 16.6736 24.4667 17.4832C24.8898 18.2927 25.1014 19.2514 25.1014 20.3594C25.1014 21.4674 24.8898 22.4261 24.4667 23.2357C24.0436 24.0452 23.4283 24.6511 22.6211 25.053C21.8138 25.4549 20.8685 25.6563 19.7858 25.6563C18.7734 25.6563 17.8495 25.4844 17.0143 25.1395C16.1791 24.7947 15.5404 24.2322 15.0984 23.4458V25.0312ZM21.4303 23.0078C21.7747 22.6302 21.9471 22.125 21.9471 21.4922C21.9471 20.7813 21.7957 20.2045 21.4931 19.7617C21.1905 19.3135 20.7747 19.0905 20.2461 19.0905C19.6133 19.0905 19.1305 19.3229 18.7975 19.7891C18.4694 20.2552 18.3053 20.8321 18.3053 21.5196C18.3053 22.2071 18.4694 22.7799 18.7975 23.2383C19.1305 23.6967 19.6133 23.9258 20.2461 23.9258C20.7747 23.9258 21.1905 23.7028 21.4931 23.2547L21.4303 23.0078Z" fill="white"/>
      <defs>
        <linearGradient id="paint0_linear_splash_logo_${key.toString()}" x1="20" y1="3.33337" x2="20" y2="36.6667" gradientUnits="userSpaceOnUse">
          <stop stop-color="#${colorToHex(lightColor)}"/>
          <stop offset="1" stop-color="#${colorToHex(darkColor)}"/>
        </linearGradient>
        <linearGradient id="paint1_linear_splash_logo_${key.toString()}" x1="20" y1="3.33337" x2="20" y2="36.6667" gradientUnits="userSpaceOnUse">
          <stop stop-color="#${colorToHex(lightColor)}" stop-opacity="0.1"/>
          <stop offset="1" stop-color="#${colorToHex(darkColor)}" stop-opacity="0"/>
        </linearGradient>
      </defs>
    </svg>
    ''';

    return SvgPicture.string(
      svgString,
      width: size,
      height: size,
    );
  }
} 