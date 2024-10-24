import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// No description provided for @welcomeback.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back ...'**
  String get welcomeback;

  /// No description provided for @signupcontent.
  ///
  /// In en, this message translates to:
  /// **'You can create a new account to get all our services'**
  String get signupcontent;

  /// No description provided for @skiptosignup.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get skiptosignup;

  /// No description provided for @skiptologin.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get skiptologin;

  /// No description provided for @requiredfield.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get requiredfield;

  /// No description provided for @emailvalidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailvalidate;

  /// No description provided for @emailaddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailaddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @hw.
  ///
  /// In en, this message translates to:
  /// **'Home Work'**
  String get hw;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editprofile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editprofile;

  /// No description provided for @fullname.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullname;

  /// No description provided for @alertdialoglogintitle.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get alertdialoglogintitle;

  /// No description provided for @alertdialoglogincontent.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email and password'**
  String get alertdialoglogincontent;

  /// No description provided for @alertdialogloginbutton.
  ///
  /// In en, this message translates to:
  /// **'done'**
  String get alertdialogloginbutton;

  /// No description provided for @alertdialogsignuptitle.
  ///
  /// In en, this message translates to:
  /// **'Account Creation Failed'**
  String get alertdialogsignuptitle;

  /// No description provided for @alertdialogsignupcontent.
  ///
  /// In en, this message translates to:
  /// **'The email you entered already exists, please try again with another email'**
  String get alertdialogsignupcontent;

  /// No description provided for @alertdialogsignupbutton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get alertdialogsignupbutton;

  /// No description provided for @alertdialogsignuptitlesuccess.
  ///
  /// In en, this message translates to:
  /// **'The account has been created'**
  String get alertdialogsignuptitlesuccess;

  /// No description provided for @alertdialogsignupcontentsuccess.
  ///
  /// In en, this message translates to:
  /// **'You can now login'**
  String get alertdialogsignupcontentsuccess;

  /// No description provided for @alertdialogsignupbuttonsuccess.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get alertdialogsignupbuttonsuccess;

  /// No description provided for @homepage.
  ///
  /// In en, this message translates to:
  /// **'Home Page'**
  String get homepage;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @classroom.
  ///
  /// In en, this message translates to:
  /// **'Classroom'**
  String get classroom;

  /// No description provided for @weeklyprogram.
  ///
  /// In en, this message translates to:
  /// **'Weekly Program'**
  String get weeklyprogram;

  /// No description provided for @parents.
  ///
  /// In en, this message translates to:
  /// **'Parents'**
  String get parents;

  /// No description provided for @teachers.
  ///
  /// In en, this message translates to:
  /// **'Teachers'**
  String get teachers;

  /// No description provided for @examprogram.
  ///
  /// In en, this message translates to:
  /// **'Exam Program'**
  String get examprogram;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get notifications;

  /// No description provided for @schoolmanagement.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get schoolmanagement;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Students'**
  String get student;

  /// No description provided for @newclass.
  ///
  /// In en, this message translates to:
  /// **'New Class'**
  String get newclass;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleting.
  ///
  /// In en, this message translates to:
  /// **'Deleting...'**
  String get deleting;

  /// No description provided for @newroom.
  ///
  /// In en, this message translates to:
  /// **'New Room'**
  String get newroom;

  /// No description provided for @editroom.
  ///
  /// In en, this message translates to:
  /// **'Edit Room'**
  String get editroom;

  /// No description provided for @addnewclass.
  ///
  /// In en, this message translates to:
  /// **'Add New Class'**
  String get addnewclass;

  /// No description provided for @addstudenttoroom.
  ///
  /// In en, this message translates to:
  /// **'Add Student To Room'**
  String get addstudenttoroom;

  /// No description provided for @selectroom.
  ///
  /// In en, this message translates to:
  /// **'Select room'**
  String get selectroom;

  /// No description provided for @messageaddstudenttoroom.
  ///
  /// In en, this message translates to:
  /// **'Student addes successfully to room'**
  String get messageaddstudenttoroom;

  /// No description provided for @classname.
  ///
  /// In en, this message translates to:
  /// **'Class name'**
  String get classname;

  /// No description provided for @joinStudentToGroup.
  ///
  /// In en, this message translates to:
  /// **'Activate receiving notifications'**
  String get joinStudentToGroup;

  /// No description provided for @addnewroom.
  ///
  /// In en, this message translates to:
  /// **'Add New Room'**
  String get addnewroom;

  /// No description provided for @selectclass.
  ///
  /// In en, this message translates to:
  /// **'Select Class'**
  String get selectclass;

  /// No description provided for @roomname.
  ///
  /// In en, this message translates to:
  /// **'Room name'**
  String get roomname;

  /// No description provided for @addnewteacher.
  ///
  /// In en, this message translates to:
  /// **'Add New Teacher'**
  String get addnewteacher;

  /// No description provided for @teachername.
  ///
  /// In en, this message translates to:
  /// **'Teacher name'**
  String get teachername;

  /// No description provided for @teacherphone.
  ///
  /// In en, this message translates to:
  /// **'Teacher number'**
  String get teacherphone;

  /// No description provided for @addnewstudent.
  ///
  /// In en, this message translates to:
  /// **'Add New Student'**
  String get addnewstudent;

  /// No description provided for @addtoroom.
  ///
  /// In en, this message translates to:
  /// **'Add to room'**
  String get addtoroom;

  /// No description provided for @studentname.
  ///
  /// In en, this message translates to:
  /// **'Student name'**
  String get studentname;

  /// No description provided for @studentphone.
  ///
  /// In en, this message translates to:
  /// **'Student number'**
  String get studentphone;

  /// No description provided for @messageaddclass.
  ///
  /// In en, this message translates to:
  /// **'Class added successfully'**
  String get messageaddclass;

  /// No description provided for @messageaddstudent.
  ///
  /// In en, this message translates to:
  /// **'Student added successfully'**
  String get messageaddstudent;

  /// No description provided for @messageaddteacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher added successfully'**
  String get messageaddteacher;

  /// No description provided for @messagesendmessage.
  ///
  /// In en, this message translates to:
  /// **'Sent successfully'**
  String get messagesendmessage;

  /// No description provided for @messageaddroom.
  ///
  /// In en, this message translates to:
  /// **'Room added successfully'**
  String get messageaddroom;

  /// No description provided for @messageeditprofile.
  ///
  /// In en, this message translates to:
  /// **'Profile edit successfully'**
  String get messageeditprofile;

  /// No description provided for @messagedelete.
  ///
  /// In en, this message translates to:
  /// **'Delete successfully'**
  String get messagedelete;

  /// No description provided for @changepassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changepassword;

  /// No description provided for @editclass.
  ///
  /// In en, this message translates to:
  /// **'Edit Class'**
  String get editclass;

  /// No description provided for @messageeditroom.
  ///
  /// In en, this message translates to:
  /// **'Room edit successfully'**
  String get messageeditroom;

  /// No description provided for @messageeditclass.
  ///
  /// In en, this message translates to:
  /// **'Class edit successfully'**
  String get messageeditclass;

  /// No description provided for @areyousudedelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areyousudedelete;

  /// No description provided for @allclasses.
  ///
  /// In en, this message translates to:
  /// **'All Classes'**
  String get allclasses;

  /// No description provided for @messagechangepassword.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get messagechangepassword;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @titleerrordialog.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get titleerrordialog;

  /// No description provided for @messageerrordialog.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again later'**
  String get messageerrordialog;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @adding.
  ///
  /// In en, this message translates to:
  /// **'Adding...'**
  String get adding;

  /// No description provided for @sendhomework.
  ///
  /// In en, this message translates to:
  /// **'Send Homework'**
  String get sendhomework;

  /// No description provided for @homeworkimage.
  ///
  /// In en, this message translates to:
  /// **'Homework Image'**
  String get homeworkimage;

  /// No description provided for @examprogramimage.
  ///
  /// In en, this message translates to:
  /// **'Exam Program Image'**
  String get examprogramimage;

  /// No description provided for @weeklyprogramimage.
  ///
  /// In en, this message translates to:
  /// **'Week Program Image'**
  String get weeklyprogramimage;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @idmessage.
  ///
  /// In en, this message translates to:
  /// **'ID Message'**
  String get idmessage;

  /// No description provided for @idhomework.
  ///
  /// In en, this message translates to:
  /// **'ID Homework'**
  String get idhomework;

  /// No description provided for @editing.
  ///
  /// In en, this message translates to:
  /// **'Editing...'**
  String get editing;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// No description provided for @sendnotifications.
  ///
  /// In en, this message translates to:
  /// **'Send a notification to room'**
  String get sendnotifications;

  /// No description provided for @textnotifications.
  ///
  /// In en, this message translates to:
  /// **'Notification text'**
  String get textnotifications;

  /// No description provided for @texthomework.
  ///
  /// In en, this message translates to:
  /// **'Homework text'**
  String get texthomework;

  /// No description provided for @messageeditphone.
  ///
  /// In en, this message translates to:
  /// **'The school numbers have been modified successfully'**
  String get messageeditphone;

  /// No description provided for @lastnews.
  ///
  /// In en, this message translates to:
  /// **'Last News'**
  String get lastnews;

  /// No description provided for @lasthomework.
  ///
  /// In en, this message translates to:
  /// **'Last Homework'**
  String get lasthomework;

  /// No description provided for @noexamprogram.
  ///
  /// In en, this message translates to:
  /// **'No exam program has been attached yet'**
  String get noexamprogram;

  /// No description provided for @noweekprogram.
  ///
  /// In en, this message translates to:
  /// **'No weekly program has been attached yet'**
  String get noweekprogram;

  /// No description provided for @messagejoinStudentToGroup.
  ///
  /// In en, this message translates to:
  /// **'The student has been activated successfully'**
  String get messagejoinStudentToGroup;

  /// No description provided for @activating.
  ///
  /// In en, this message translates to:
  /// **'Activating...'**
  String get activating;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'Whatsapp'**
  String get whatsapp;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @joining.
  ///
  /// In en, this message translates to:
  /// **'Joining...'**
  String get joining;

  /// No description provided for @selectyourroom.
  ///
  /// In en, this message translates to:
  /// **'Select your room'**
  String get selectyourroom;

  /// No description provided for @phone1.
  ///
  /// In en, this message translates to:
  /// **'Phone 1'**
  String get phone1;

  /// No description provided for @phone2.
  ///
  /// In en, this message translates to:
  /// **'Phone 2'**
  String get phone2;

  /// No description provided for @phonepage.
  ///
  /// In en, this message translates to:
  /// **'School Numbers'**
  String get phonepage;

  /// No description provided for @pleaseactive.
  ///
  /// In en, this message translates to:
  /// **'Sorry, you cannot use the application before the teacher adds you to your group'**
  String get pleaseactive;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
