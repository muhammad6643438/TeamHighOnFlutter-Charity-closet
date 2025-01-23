import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Total Trips",
    numOfFiles: 1328,
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "56",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Total Spending",
    numOfFiles: 1328,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "450,000,00",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Total Diesel",
    numOfFiles: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "200,000,00",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Balance",
    numOfFiles: 5328,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "245,000",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];

List dieselFields = [
  "Date",
  "Truck No",
  "Voucher No",
  "HSD",
  "Rate",
  "Pump Station",
  "Amount",
];

List inCityFields = [
  "Date",
  "Truck No",
  "Billty No",
  "SECEMC Weight",
  "LEPCL Weight",
  "Rate",
  "Amount",
  "Difference",
];

List outCityFields = [
  "Date",
  "Truck No",
  "Billty No",
  "SECEMC Weight",
  "LEPCL Weight",
  "Which Ever Lowest",
  "Rate",
  "Amount",
  "Difference",
  "Waiver Allowed",
  "Deductible",
  "Shortage Rate",
  "Shortage Amount",
  "Advance",
  "Balance",
];

List vesselFields = [
  "Date",
  "Truck No",
  "Billty No",
  "SECEMC Weight",
  "LEPCL Weight",
  "Which Ever Lowest",
  "Rate",
  "Amount",
  "Difference",
  "Waiver Allowed",
  "Deductible",
  "Shortage Rate",
  "Shortage Amount",
  "Advance",
  "Balance",
  "Port",
];
