// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DateFormat {
//   final TextEditingController _controller = new TextEditingController();
//   Future _chooseDate(BuildContext context, String initialDateString) async {
//     var now = new DateTime.now();
//     var initialDate = convertToDate(initialDateString) ?? now;
//     initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now) ? initialDate : now);

//     var result = await showDatePicker(
//         context: context,
//         initialDate: initialDate,
//         firstDate: new DateTime(1900),
//         lastDate: new DateTime.now());

//     if (result == null) return;

//     setState(() {
//       _controller.text = new DateFormat.yMd().format(result);
//     });
//   }

//   DateTime convertToDate(String input) {
//     try 
//     {
//       var d = new DateFormat.yMd().parseStrict(input);
//       return d;
//     } catch (e) {
//       return null;
//     }    
//   }

// }