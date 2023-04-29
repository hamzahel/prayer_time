import 'package:flutter/material.dart';

String getMonthString(int number) {
  switch (number) {
    case (1):
      return "January";
      break;
    case (2):
      return "February";
      break;
    case 3:
      return "March";
      break;
    case 4:
      return "April";
      break;
    case 5:
      return "May";
      break;
    case 6:
      return "June";
      break;
    case 7:
      return "July";
      break;
    case 8:
      return "August";
      break;
    case 9:
      return "September";
      break;
    case 10:
      return "October";
      break;
    case 11:
      return "November";
      break;
    case 12:
      return "December";
      break;
    default:
      return "";
      break;
  }
}

String getMonthArabicString(int number) {
  switch (number) {
    case (1):
      return "Muharram";
      break;
    case (2):
      return "Safar";
      break;
    case 3:
      return "Rabi I";
      break;
    case 4:
      return "Rabi II";
      break;
    case 5:
      return "Jumada I";
      break;
    case 6:
      return "Jumada II";
      break;
    case 7:
      return "Rajab";
      break;
    case 8:
      return "Shaaban";
      break;
    case 9:
      return "Ramadan";
      break;
    case 10:
      return "Shawwal";
      break;
    case 11:
      return "Dhu al-Qidah";
      break;
    case 12:
      return "Dhu al-Hijjah";
      break;
    default:
      return "";
      break;
  }
}

String add0ToInt(int number) {
  if (number < 10) {
    return ("0$number");
  } else {
    return number.toString();
  }
}

String add0ToString(String number) {
  if (number.length == 1) {
    return ("0" + number);
  } else {
    return number;
  }
}

