// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/calendar_popup.dart';
import 'package:my_med/src/components/error_template.dart';
import 'package:my_med/src/components/utils/snack_bar.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/models/date.dart';
import 'package:my_med/src/modules/home/apis/Pharmaceutical_api.dart';
import 'package:my_med/src/modules/home/dbs/prescriptions_db.dart';
import 'package:my_med/src/modules/home/models/active_prescription_detail_model.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';
import 'package:my_med/src/modules/home/models/reminder_model.dart';
import 'package:my_med/src/utils/local_notification.dart';
import 'package:shamsi_date/shamsi_date.dart';

class ActivePrescriptionDetailsProvider extends ChangeNotifier {
  final BuildContext context;
  final ActivePrescriptionModel activePrescriptionModel;
  ActivePrescriptionDetailModel? activePrescriptionDetailModel;
  List<ActivePrescriptionReminderModel> remindersList = [];
  int indexAlarm = 0;
  int indexDay = 1;
  int totalDayUse = 0;
  int daySelectedNew = Jalali.now().day;
  int monthSelectedNew = Jalali.now().month;
  int yearSelectedNew = Jalali.now().year;

  bool savedCalendarDialogData = false;
  bool savedClockDialogData = false;
  bool isReminderOn = true;
  bool isLoading = true;
  bool isLoadingButton = false;
  bool isDisposed = false;
  bool isReminderONOldState = false;

  List<String> monthList = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند'
  ];

  List<String> monthListMiladi = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String _selectedTimeLocalized = '';
  String _selectedTimeNonLocalized = '';

  ActivePrescriptionDetailsProvider(
      {required this.context, required this.activePrescriptionModel}) {
    daySelectedNew = (context.localizations.localeName == 'en')
        ? DateTime.now().day
        : daySelectedNew;
    monthSelectedNew = (context.localizations.localeName == 'en')
        ? DateTime.now().month
        : monthSelectedNew;
    yearSelectedNew = (context.localizations.localeName == 'en')
        ? DateTime.now().year
        : yearSelectedNew;
    notifyListeners();
    var activePrescriptionDetailFromDB = PrescriptionDB.instance
        .getActivePrescriptionDetailModel(
            activePrescriptionModel.id.toString());
    if (activePrescriptionDetailFromDB != null) {
      isReminderOn = activePrescriptionDetailFromDB.notify;
    }

    getActivePrescriptionDetail();
    isReminderONOldState = isReminderOn;
  }

  int getTotalDayUse(ActivePrescriptionModel model) {
    return model.days;
  }

  void getActivePrescriptionDetail() async {
    isLoading = true;
    notifyListeners();
    activePrescriptionDetailModel =
        await Pharmaceutical().getActivePrescriptionDetail(
      onTimeout: () => APIErrorMessage().onTimeout(context),
      onDisconnect: () => APIErrorMessage().onDisconnect(context),
      onAPIError: () => APIErrorMessage().onDisconnect(context),
      activePrescriptionID: activePrescriptionModel.id,
    );
    if (activePrescriptionDetailModel == null) {
      context.router.pop();
      return;
    }
    totalDayUse = getTotalDayUse(activePrescriptionModel);
    var activePrescriptionDetailFromDB = PrescriptionDB.instance
        .getActivePrescriptionDetailModel(
            activePrescriptionModel.id.toString());
    if (activePrescriptionDetailFromDB != null) {
      bool? isReminderOnFromDB = activePrescriptionDetailFromDB.notify;
      isReminderOn = isReminderOnFromDB;
      activePrescriptionDetailModel!.notify = isReminderOn;
    }
    PrescriptionDB.instance
        .addActivePrescriptionsDetails(activePrescriptionDetailModel!);
    isLoading = false;
    if (isDisposed) return;
    notifyListeners();
  }

  String get selectedTime {
    return _selectedTimeLocalized = (_selectedTimeLocalized == "")
        ? TimeOfDay.now()
            .format(context)
            .replaceAll("PM", context.localizations.pmTime)
            .replaceAll("AM", context.localizations.amTime)
        : _selectedTimeLocalized;
  }

  String get selectedTimeNonLocalized {
    return _selectedTimeNonLocalized = (_selectedTimeNonLocalized == "")
        ? DateTime.now().toString().split(' ')[1]
        : _selectedTimeNonLocalized;
  }

  Future<void> openTimePicker() async {
    final TimeOfDay? t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        cancelText: context.localizations.cancel,
        confirmText: context.localizations.registerButtonText,
        errorInvalidText: context.localizations.invalidTime,
        helpText: context.localizations.enterTheTime,
        hourLabelText: context.localizations.hour,
        minuteLabelText: context.localizations.minute,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context),
            child: child!,
          );
        });
    if (t != null) {
      savedClockDialogData = true;
      _selectedTimeNonLocalized = '${t.hour}:${t.minute}';
      _selectedTimeLocalized = t.format(context);
      _selectedTimeLocalized =
          _selectedTimeLocalized.replaceAll("PM", context.localizations.pmTime);
      _selectedTimeLocalized =
          _selectedTimeLocalized.replaceAll("AM", context.localizations.amTime);
      notifyListeners();
    }
  }

  Future<void> showCalendarDialog() async {
    final date = await showDialog<MyDate>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CalendarPopUp();
      },
    );
    if (date != null) {
      if (DateTime(date.year, date.month, date.day)
          .isBefore(activePrescriptionModel.doctorStart)) {
        errorHandler(
            'You can not start your medicine before doctor release date (${activePrescriptionModel.doctorStart.toString().substring(0, 19)})');
      } else {
        savedCalendarDialogData = true;
        daySelectedNew = date.day;
        monthSelectedNew = date.month;
        yearSelectedNew = date.year;
      }

      notifyListeners();
    }
  }

  void onCustomButtonTap(String decisionPopup) {
    if (decisionPopup == "Calendar") {
      showCalendarDialog();
    } else if (decisionPopup == "Time") {
      openTimePicker();
    }
    notifyListeners();
  }

  void onReminderChange(bool value) {
    isReminderOn = value;
    notifyListeners();

    activePrescriptionDetailModel!.notify = value;
    PrescriptionDB.instance
        .addActivePrescriptionsDetails(activePrescriptionDetailModel!);
  }

  void onAlarmTimmingTap(int value) {
    indexAlarm = value;
    notifyListeners();
  }

  String convertTimeToISOFormat(String time) {
    var splittedTime = time.split(':');
    if (splittedTime[0].length == 1) {
      splittedTime[0] = '0${splittedTime[0]}';
    }
    if (splittedTime[1].length == 1) {
      splittedTime[1] = '0${splittedTime[1]}';
    }

    return '${splittedTime[0]}:${splittedTime[1]}';
  }

  void onEnterTap() async {
    if (isLoadingButton == true) return;

    isLoadingButton = true;
    notifyListeners();

    String convertedTime =
        convertTimeToISOFormat(selectedTimeNonLocalized.split(' ')[0]);
    String hours = convertedTime.split(':')[0];
    String minutes = convertedTime.split(':')[1];
    String convertedDateTime = '';
    if (context.localizations.localeName == 'fa') {
      convertedDateTime = Jalali(
        yearSelectedNew,
        monthSelectedNew,
        daySelectedNew,
        int.parse(hours),
        int.parse(minutes),
        0,
      ).toGregorian().toDateTime().toString().substring(0, 19);
    } else {
      convertedDateTime = DateTime(
        yearSelectedNew,
        monthSelectedNew,
        daySelectedNew,
        int.parse(hours),
        int.parse(minutes),
        0,
      ).toString();
    }
    activePrescriptionModel.reminders =
        await Pharmaceutical().startPrescription(
      onTimeout: () => APIErrorMessage().onTimeout(context),
      onDisconnect: () => APIErrorMessage().onDisconnect(context),
      onAPIError: () => APIErrorMessage().onDisconnect(context),
      activePrescriptionModel: activePrescriptionModel,
      dateTime: convertedDateTime,
      context: context,
    );

    if (activePrescriptionModel.reminders.isNotEmpty) {
      if (isDisposed == false) {
        getReminderAddedsuccessfullySnackBar();
      }
      if (isReminderOn) {
        for (final rem in activePrescriptionModel.reminders) {
          final reminderDate = DateTime(
            rem.dateTime.year,
            rem.dateTime.month,
            rem.dateTime.day,
            rem.dateTime.hour,
            rem.dateTime.minute,
            rem.dateTime.second,
          );
          if (reminderDate.isAfter(DateTime.now())) {
            await LocalNotificationAPI().showScheduledNotification(
              id: rem.id.hashCode,
              dateTime: reminderDate,
              title: rem.name,
              body: context.localizations.timeToTakeMedicine,
              payload: 'My Med - ${rem.dateTime}',
            );
          }
        }
      }
    }

    isLoadingButton = false;
    if (isDisposed) return;
    context.router.pop();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      getReminderAddedsuccessfullySnackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar().customShowMessage(
        message: context.localizations.reminderAddedSuccess,
        isAndroid: Platform.isAndroid,
        color: Colors.green,
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  void errorHandler(String errorMessage) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar().customShowMessage(
        message: errorMessage,
        isAndroid: Platform.isAndroid,
        color: Colors.red,
      ),
    );
  }

  void showRestartMedicineError() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar().customShowMessage(
        message: context.localizations.drugAlreadyStarted,
        isAndroid: Platform.isAndroid,
        color: Colors.red,
      ),
    );
  }

  void removeLocalNotification() async {
    for (final rem in activePrescriptionModel.reminders) {
      LocalNotificationAPI().removeNotification(rem.id.hashCode);
    }
  }

  Future<void> createLocalNotification() async {
    for (final rem in activePrescriptionModel.reminders) {
      final reminderDate = DateTime(
        rem.dateTime.year,
        rem.dateTime.month,
        rem.dateTime.day,
        rem.dateTime.hour,
        rem.dateTime.minute,
        rem.dateTime.second,
      );
      if (reminderDate.isAfter(DateTime.now())) {
        await LocalNotificationAPI().showScheduledNotification(
          id: rem.id.hashCode,
          dateTime: reminderDate,
          title: rem.name,
          body: context.localizations.timeToTakeMedicine,
          payload: 'Saramad - ${rem.dateTime}',
        );
      }
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
