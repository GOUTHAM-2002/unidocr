import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_he.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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
/// To configure the locales supported by your app, you'll need to edit this
/// file.
///
/// First, open your project's ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project's Runner folder.
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
    Locale('en'),
    Locale('he')
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Unidoc'**
  String get appTitle;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @incomplete.
  ///
  /// In en, this message translates to:
  /// **'Incomplete'**
  String get incomplete;

  /// No description provided for @awaitingSignature.
  ///
  /// In en, this message translates to:
  /// **'Awaiting Signature'**
  String get awaitingSignature;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @customers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customers;

  /// No description provided for @documents.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @customerManagement.
  ///
  /// In en, this message translates to:
  /// **'Manage your customer information and quotes'**
  String get customerManagement;

  /// No description provided for @searchCustomers.
  ///
  /// In en, this message translates to:
  /// **'Search customers...'**
  String get searchCustomers;

  /// No description provided for @newCustomer.
  ///
  /// In en, this message translates to:
  /// **'New Customer'**
  String get newCustomer;

  /// No description provided for @editCustomer.
  ///
  /// In en, this message translates to:
  /// **'Edit Customer'**
  String get editCustomer;

  /// No description provided for @customerAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Customer Analytics'**
  String get customerAnalytics;

  /// No description provided for @exportCustomers.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportCustomers;

  /// No description provided for @filterCustomers.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterCustomers;

  /// No description provided for @customerNeedsAgreement.
  ///
  /// In en, this message translates to:
  /// **'Customers need a price agreement'**
  String get customerNeedsAgreement;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @noDisputesFound.
  ///
  /// In en, this message translates to:
  /// **'No disputes found'**
  String get noDisputesFound;

  /// No description provided for @noAgreementsFound.
  ///
  /// In en, this message translates to:
  /// **'No agreements found'**
  String get noAgreementsFound;

  /// No description provided for @reportNewIssue.
  ///
  /// In en, this message translates to:
  /// **'Report a New Issue'**
  String get reportNewIssue;

  /// No description provided for @createPriceAgreement.
  ///
  /// In en, this message translates to:
  /// **'Create a Price Agreement'**
  String get createPriceAgreement;

  /// No description provided for @newDispute.
  ///
  /// In en, this message translates to:
  /// **'New Dispute'**
  String get newDispute;

  /// No description provided for @newAgreement.
  ///
  /// In en, this message translates to:
  /// **'New Agreement'**
  String get newAgreement;

  /// No description provided for @uploadFiles.
  ///
  /// In en, this message translates to:
  /// **'Upload Files'**
  String get uploadFiles;

  /// No description provided for @allCustomers.
  ///
  /// In en, this message translates to:
  /// **'All Customers'**
  String get allCustomers;

  /// No description provided for @activeCustomers.
  ///
  /// In en, this message translates to:
  /// **'Active Customers'**
  String get activeCustomers;

  /// No description provided for @inactiveCustomers.
  ///
  /// In en, this message translates to:
  /// **'Inactive Customers'**
  String get inactiveCustomers;

  /// No description provided for @prospects.
  ///
  /// In en, this message translates to:
  /// **'Prospects'**
  String get prospects;

  /// No description provided for @customerTiers.
  ///
  /// In en, this message translates to:
  /// **'Customer Tiers'**
  String get customerTiers;

  /// No description provided for @standardTier.
  ///
  /// In en, this message translates to:
  /// **'Standard (10,000/mo)'**
  String get standardTier;

  /// No description provided for @premiumTier.
  ///
  /// In en, this message translates to:
  /// **'Premium (10,001-50,000/mo)'**
  String get premiumTier;

  /// No description provided for @eliteTier.
  ///
  /// In en, this message translates to:
  /// **'Elite (50,000+/mo)'**
  String get eliteTier;

  /// No description provided for @resetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset Filters'**
  String get resetFilters;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @individual.
  ///
  /// In en, this message translates to:
  /// **'Individual'**
  String get individual;

  /// No description provided for @government.
  ///
  /// In en, this message translates to:
  /// **'Government'**
  String get government;

  /// No description provided for @non_profit.
  ///
  /// In en, this message translates to:
  /// **'Non-Profit'**
  String get non_profit;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @activeProjects.
  ///
  /// In en, this message translates to:
  /// **'Active Projects'**
  String get activeProjects;

  /// No description provided for @completedProjects.
  ///
  /// In en, this message translates to:
  /// **'Completed Projects'**
  String get completedProjects;

  /// No description provided for @projectStatus.
  ///
  /// In en, this message translates to:
  /// **'Project Status'**
  String get projectStatus;

  /// No description provided for @allStatuses.
  ///
  /// In en, this message translates to:
  /// **'All Statuses'**
  String get allStatuses;

  /// No description provided for @serviceCallDetails.
  ///
  /// In en, this message translates to:
  /// **'Service Call Details'**
  String get serviceCallDetails;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @serviceType.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get serviceType;

  /// No description provided for @projectSite.
  ///
  /// In en, this message translates to:
  /// **'Project Site'**
  String get projectSite;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @pumpType.
  ///
  /// In en, this message translates to:
  /// **'Pump Type'**
  String get pumpType;

  /// No description provided for @operator.
  ///
  /// In en, this message translates to:
  /// **'Operator'**
  String get operator;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @serviceProgress.
  ///
  /// In en, this message translates to:
  /// **'Service Progress'**
  String get serviceProgress;

  /// No description provided for @getSignature.
  ///
  /// In en, this message translates to:
  /// **'Get Signature'**
  String get getSignature;

  /// No description provided for @withoutSignature.
  ///
  /// In en, this message translates to:
  /// **'Without Signature'**
  String get withoutSignature;

  /// No description provided for @markComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark Complete'**
  String get markComplete;

  /// No description provided for @markAsIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Mark as Incomplete'**
  String get markAsIncomplete;

  /// No description provided for @startService.
  ///
  /// In en, this message translates to:
  /// **'Start Service'**
  String get startService;

  /// No description provided for @viewDoc.
  ///
  /// In en, this message translates to:
  /// **'View Doc'**
  String get viewDoc;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contacts;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @customerInformation.
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get customerInformation;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @servicePersonnel.
  ///
  /// In en, this message translates to:
  /// **'Service Personnel'**
  String get servicePersonnel;

  /// No description provided for @projectManager.
  ///
  /// In en, this message translates to:
  /// **'Project Manager'**
  String get projectManager;

  /// No description provided for @fieldOperator.
  ///
  /// In en, this message translates to:
  /// **'Field Operator'**
  String get fieldOperator;

  /// No description provided for @operationsManager.
  ///
  /// In en, this message translates to:
  /// **'Operations Manager'**
  String get operationsManager;

  /// No description provided for @assigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get assigned;

  /// No description provided for @supervisor.
  ///
  /// In en, this message translates to:
  /// **'Supervisor'**
  String get supervisor;

  /// No description provided for @serviceCallChat.
  ///
  /// In en, this message translates to:
  /// **'Service Call Chat'**
  String get serviceCallChat;

  /// No description provided for @viewFullChat.
  ///
  /// In en, this message translates to:
  /// **'View Full Chat'**
  String get viewFullChat;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @startConversation.
  ///
  /// In en, this message translates to:
  /// **'Start a conversation about this service call to coordinate with the customer and team.'**
  String get startConversation;

  /// No description provided for @startConversationButton.
  ///
  /// In en, this message translates to:
  /// **'Start Conversation'**
  String get startConversationButton;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message here...'**
  String get typeMessage;

  /// No description provided for @serviceDocuments.
  ///
  /// In en, this message translates to:
  /// **'Service Documents'**
  String get serviceDocuments;

  /// No description provided for @serviceCallDocument.
  ///
  /// In en, this message translates to:
  /// **'Service Call Document'**
  String get serviceCallDocument;

  /// No description provided for @deliveryCertificate.
  ///
  /// In en, this message translates to:
  /// **'Delivery Certificate'**
  String get deliveryCertificate;

  /// No description provided for @serviceReport.
  ///
  /// In en, this message translates to:
  /// **'Service Report'**
  String get serviceReport;

  /// No description provided for @documentNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Document not available'**
  String get documentNotAvailable;

  /// No description provided for @documentGeneratedProgress.
  ///
  /// In en, this message translates to:
  /// **'This document will be generated as the service call progresses'**
  String get documentGeneratedProgress;

  /// No description provided for @discuss.
  ///
  /// In en, this message translates to:
  /// **'Discuss'**
  String get discuss;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @serviceCallTimeline.
  ///
  /// In en, this message translates to:
  /// **'Service Call Timeline'**
  String get serviceCallTimeline;

  /// No description provided for @serviceCallCreated.
  ///
  /// In en, this message translates to:
  /// **'Service Call Created'**
  String get serviceCallCreated;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created by'**
  String get createdBy;

  /// No description provided for @operatorAssigned.
  ///
  /// In en, this message translates to:
  /// **'Operator Assigned'**
  String get operatorAssigned;

  /// No description provided for @wasAssigned.
  ///
  /// In en, this message translates to:
  /// **'was assigned to this service call'**
  String get wasAssigned;

  /// No description provided for @scheduledFor.
  ///
  /// In en, this message translates to:
  /// **'Service call scheduled for'**
  String get scheduledFor;

  /// No description provided for @startedWorking.
  ///
  /// In en, this message translates to:
  /// **'started working on site'**
  String get startedWorking;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @hebrew.
  ///
  /// In en, this message translates to:
  /// **'Hebrew'**
  String get hebrew;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @site.
  ///
  /// In en, this message translates to:
  /// **'Site'**
  String get site;

  /// No description provided for @demolition.
  ///
  /// In en, this message translates to:
  /// **'Demolition'**
  String get demolition;

  /// No description provided for @excavation.
  ///
  /// In en, this message translates to:
  /// **'Excavation'**
  String get excavation;

  /// No description provided for @concreting.
  ///
  /// In en, this message translates to:
  /// **'Concreting'**
  String get concreting;

  /// No description provided for @trailerPump.
  ///
  /// In en, this message translates to:
  /// **'Trailer Pump'**
  String get trailerPump;

  /// No description provided for @boomPump.
  ///
  /// In en, this message translates to:
  /// **'Boom Pump'**
  String get boomPump;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @businessDetails.
  ///
  /// In en, this message translates to:
  /// **'Business Details'**
  String get businessDetails;

  /// No description provided for @files.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get files;

  /// No description provided for @agreements.
  ///
  /// In en, this message translates to:
  /// **'Agreements'**
  String get agreements;

  /// No description provided for @disputes.
  ///
  /// In en, this message translates to:
  /// **'Disputes'**
  String get disputes;

  /// No description provided for @companyInformation.
  ///
  /// In en, this message translates to:
  /// **'Company Information'**
  String get companyInformation;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyName;

  /// No description provided for @companyNickname.
  ///
  /// In en, this message translates to:
  /// **'Company Nickname'**
  String get companyNickname;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @officePhone.
  ///
  /// In en, this message translates to:
  /// **'Office Phone'**
  String get officePhone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressLine2.
  ///
  /// In en, this message translates to:
  /// **'Address Line 2'**
  String get addressLine2;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @zipCode.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zipCode;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @businessType.
  ///
  /// In en, this message translates to:
  /// **'Business Type'**
  String get businessType;

  /// No description provided for @taxId.
  ///
  /// In en, this message translates to:
  /// **'Tax ID'**
  String get taxId;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @customerSince.
  ///
  /// In en, this message translates to:
  /// **'Customer Since'**
  String get customerSince;

  /// No description provided for @paymentTerms.
  ///
  /// In en, this message translates to:
  /// **'Payment Terms'**
  String get paymentTerms;

  /// No description provided for @documentsRequired.
  ///
  /// In en, this message translates to:
  /// **'Documents Required'**
  String get documentsRequired;

  /// No description provided for @primaryContact.
  ///
  /// In en, this message translates to:
  /// **'Primary Contact'**
  String get primaryContact;

  /// No description provided for @contactName.
  ///
  /// In en, this message translates to:
  /// **'Contact Name'**
  String get contactName;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'Contact Email'**
  String get contactEmail;

  /// No description provided for @contactPhone.
  ///
  /// In en, this message translates to:
  /// **'Contact Phone'**
  String get contactPhone;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @additionalInformation.
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additionalInformation;

  /// No description provided for @issueTitle.
  ///
  /// In en, this message translates to:
  /// **'Issue Title'**
  String get issueTitle;

  /// No description provided for @detailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Detailed Description'**
  String get detailedDescription;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'he'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'he': return AppLocalizationsHe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
