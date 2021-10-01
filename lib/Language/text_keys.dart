import 'package:flutter/material.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }
  // USER VIEW

  // Select Type Screen
  String get register;

  String get order;

  //Registration Screen
  String get registration;

  String get code;

  String get mobileNo;

  String get mobileError1;

  String get mobileError2;

  String get confirm;

  String get otp;

  String get mobileExistMsg;

  //Otp Verification Screen
  String get otpVerification;

  String get didntRecieve;

  String get resend;

  String get verify;

  // Dashboard Screen
  String get discover;

  String get experience;

  String get searchOnHome;

  String get topPick;

  String get viewAll;

  String get promoted;

  String get special;

  String get emptyList;

  String get service;

  //View Restaurant Screen
  String get browse;

  String get add;

  String get quantity;

  String get half;

  String get full;

  String get total;

  String get addItem;

  //Cart Screen
  String get emptyCart;

  String get coupon;

  String get detail;

  String get discount;

  String get delivery;

  String get toPay;

  String get selectAdd;

  String get chooseAdd;

  String get addNewAdd;

  String get proceed;

  String get delTo;

  String get incAllCharges;

  String get makePay;

  //Make Payment Screen
  String get wallets;

  String get pay;

  String get selectCard;

  String get cards;

  String get addNewCard;

  String get payOnDel;

  String get cod;

  String get payNow;

  //Order Confirm Screen
  String get ty;

  String get orderCon;

  String get foodProd;

  String get estTime;

  String get orderStat;

  String get con;

  //User Drawer
  String get entry1;

  String get entry2;

  String get entry3;

  String get entry4;

  String get entry5;

  String get oN;

  String get off;

  String get entry6;

  String get entry7;

  String get entry8;

  //Track Order Screen
  String get orderRes;

  String get foodPrep;

  String get outDel;

  String get delivered;

  String get writeRev;

  //Review Screen
  String get review;

  String get submit;

  //Settings Screen
  String get setting;

  String get aboutInfo;

  String get accSetting;

  //About Wify Screen
  String get aboutWify;

  //Manage Address
  String get manAdd;

  String get deleteAdd;

  String get cancel;

  String get delete;

  // Select Language Screen
  String get selectLanguage;

  String get language1;

  String get language2;

  String get language3;

  String get language4;

  String get language5;

  String get language6;

  String get language7;

  //KITCHEN VIEW

  //Signin Register Kitchen Screen
  String get signin;

  String get regKitchen;

  //Register Kicthen
  String get reg;

  String get name;

  String get dob;

  String get kitchenName;

  String get cuisine;

  String get veg;

  String get nonVeg;

  String get mixed;

  String get bakery;

  String get email;

  String get locPin;

  String get mobNo;

  String get createPass;

  String get addLogo;

  //Enter Otp Screen
  String get enterOTP;

  String get enterOtp;

  String get sec;

  String get resendOtp;

  //Add Kitchen Screen
  String get addKitName;

  String get wifyId;

  String get address;

  String get streetCity;

  String get kitLoc;

  String get aboutYou;

  String get writeAbYou;

  String get save;

  //Login Screen
  String get login;

  String get pass;

  String get forgotPass;

  //Kitchen Dashboard Screen
  String get dash;

  String get ord;

  String get rec;

  String get del;

  String get today;

  String get mon;

  String get earn;

  String get kit;

  String get online;

  String get offline;

  String get todayOrder;

  String get penOrder;

  String get bill;

  String get accept;

  String get reject;

  String get cook;

  String get comp;

  //Side Menu
  String get menu;

  String get disMenu;

  String get addMenu;

  String get offer;

  String get disOffer;

  String get addOffer;

  String get myAcc;

  String get sett;

  String get shareApp;

  String get rateUs;

  String get help;

  String get signOut;

  //Display Menu Screen
  String get menuItems;

  //Menu Details Screen
  String get maxQuan;

  String get images;

  //Add Menu Screen
  String get dishName;

  String get ex;

  String get des;

  String get enterDes;

  String get fullPrice;

  String get halfPrice;

  String get foodQuan;

  String get select;

  String get selectCat;

  String get upPic;

  String get addMenuSuccess;

  String get addMore;

  //Display Offers Screen
  String get current;

  String get closed;

  //Add Offer Screen
  String get newOffer;

  String get offerTitle;

  String get disUpto;

  String get offValid;

  String get selectProd;

  String get offerDes;

  String get enterDesOffer;

  String get uploadBackPic;

  //My Account Screen
  String get kitName;

  String get changePass;

  String get about;

  //Settings Screen
  String get nightMode;

  //Forgot Password Screen
  String get enterNewPass;

  String get enterPass;

  String get conNewPass;
}
