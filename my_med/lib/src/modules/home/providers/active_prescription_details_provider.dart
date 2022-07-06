import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/calendar_popup.dart';
import 'package:my_med/src/components/utils/snack_bar.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/home/apis/Pharmaceutical_api.dart';
import 'package:my_med/src/modules/home/dbs/prescriptions_db.dart';
import 'package:my_med/src/modules/home/models/active_prescription_model.dart';
import 'package:my_med/src/modules/home/models/prescription_detail_model.dart';
import 'package:my_med/src/modules/home/models/reminder_model.dart';
import 'package:my_med/src/utils/local_notification.dart';
import 'package:shamsi_date/shamsi_date.dart';

class ActivePrescriptionDetailsProvider extends ChangeNotifier {
  final BuildContext context;
  final ActivePrescriptionModel activePrescriptionModel;
  PrescriptionModel? activePrescriptionDetailModel;
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
    'Jan',
    'Feb'
  ];

  String _selectedTimeLocalized = '';
  String _selectedTimeNonLocalized = '';

  ActivePrescriptionDetailsProvider(
      {required this.context, required this.activePrescriptionModel}) {
    var activePrescriptionDetailFromDB = PrescriptionDB.instance
        .getActivePrescriptionDetailModel(activePrescriptionModel.id);
    if (activePrescriptionDetailFromDB != null) {
      isReminderOn = activePrescriptionDetailFromDB.isReminderOn;
    }

    getActivePrescriptionDetail();
    isReminderONOldState = isReminderOn;
  }

  int getTotalDayUse(ActivePrescriptionModel model) {
    var consumptionDue = model.consumptionDuration;
    int hourDuration = 0;
    if (consumptionDue.contains(' ')) {
      hourDuration = int.parse(consumptionDue.split(' ')[0]) * 24;
      consumptionDue = consumptionDue.split(' ')[1];
    }
    hourDuration += int.parse(consumptionDue.split(':')[0]);
    final minDuration = int.parse(consumptionDue.split(':')[1]);
    final secDuration = int.parse(consumptionDue.split(':')[2]);
    final totalSecDuration =
        hourDuration * 3600 + minDuration * 60 + secDuration;
    final totalDayUse =
        (model.consumptionTimes * totalSecDuration / 86400).ceil();
    return totalDayUse;
  }

  void getActivePrescriptionDetail() async {
    isLoading = true;
    notifyListeners();
    activePrescriptionDetailModel = await Pharmaceutical()
        .getActivePrescriptionDetail(activePrescriptionModel.id);
    if (activePrescriptionDetailModel == null) {
      context.router.pop();
    }
    totalDayUse = getTotalDayUse(activePrescriptionModel);
    //TODO Reminder toggleSwitch value for synchronization with server - Has not been decided
    var activePrescriptionDetailFromDB = PrescriptionDB.instance
        .getActivePrescriptionDetailModel(activePrescriptionModel.id);
    if (activePrescriptionDetailFromDB != null) {
      bool? isReminderOnFromDB = activePrescriptionDetailFromDB.isReminderOn;
      isReminderOn = isReminderOnFromDB;
      activePrescriptionDetailModel!.isReminderOn = isReminderOn;
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
    final date = await showDialog<Date>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CalendarPopUp();
      },
    );
    if (date != null) {
      savedCalendarDialogData = true;
      daySelectedNew = date.day;
      monthSelectedNew = date.month;
      yearSelectedNew = date.year;
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

    activePrescriptionDetailModel!.isReminderOn = value;
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

    //TODO isReminder should be send for server for synchronization
    isLoadingButton = true;
    notifyListeners();

    if (activePrescriptionModel.reminders.isEmpty) {
      String convertedTime =
          convertTimeToISOFormat(selectedTimeNonLocalized.split(' ')[0]);
      String hours = convertedTime.split(':')[0];
      String minutes = convertedTime.split(':')[1];
      String convertedDateTime = Jalali(
        yearSelectedNew,
        monthSelectedNew,
        daySelectedNew,
        int.parse(hours),
        int.parse(minutes),
        0,
      ).toGregorian().toDateTime().toString().substring(0, 19);
      activePrescriptionModel.reminders =
          await Pharmaceutical().startPrescription(
        activePrescriptionModel: activePrescriptionModel,
        dateTime: convertedDateTime,
        context: context,
      );

      if (activePrescriptionModel.reminders.isNotEmpty) {
        if (isDisposed == false) {
          ScaffoldMessenger.of(context).showSnackBar(
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
        if (isReminderOn) {
          for (final rem in activePrescriptionModel.reminders) {
            final reminderDate = DateTime(
              rem.timeToTake.year,
              rem.timeToTake.month,
              rem.timeToTake.day,
              rem.timeToTake.hour,
              rem.timeToTake.minute,
              rem.timeToTake.second,
            );
            if (reminderDate.isAfter(DateTime.now())) {
              await LocalNotificationAPI().showScheduledNotification(
                id: rem.id.hashCode,
                dateTime: reminderDate,
                title: rem.name,
                body: context.localizations.timeToTakeMedicine,
                payload: 'Saramad - ${rem.timeToTake}',
              );
            }
          }
        }
      }
    } else {
      if (isReminderONOldState == isReminderOn) {
        showRestartMedicineError();
      } else {
        final isAPIDoneSuccessfully =
            await Pharmaceutical().setReminderNotificationStatus(
          activePrescriptionModel.id,
          isReminderOn,
        );
        if (isAPIDoneSuccessfully) {
          //TODO sync hive with response when back get the damnnnnnn is_reminder_on
          isReminderONOldState = isReminderOn;
          if (isReminderOn) {
            await createLocalNotification();
          } else {
            removeLocalNotification();
          }
        }
      }
    }

    isLoadingButton = false;

    if (isDisposed) return;

    context.router.pop();
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
        rem.timeToTake.year,
        rem.timeToTake.month,
        rem.timeToTake.day,
        rem.timeToTake.hour,
        rem.timeToTake.minute,
        rem.timeToTake.second,
      );
      if (reminderDate.isAfter(DateTime.now())) {
        await LocalNotificationAPI().showScheduledNotification(
          id: rem.id.hashCode,
          dateTime: reminderDate,
          title: rem.name,
          body: context.localizations.timeToTakeMedicine,
          payload: 'Saramad - ${rem.timeToTake}',
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
