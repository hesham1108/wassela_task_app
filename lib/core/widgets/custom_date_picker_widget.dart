import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wassela_task_app/core/helpers/spacing.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:wassela_task_app/core/theming/styles.dart';

// ignore: must_be_immutable
class CustomDatePickerWidget<
  cubit extends Cubit<states>,
  states,
  state1 extends states
>
    extends StatelessWidget {
  final Function(DateTime?)? saveDate;
  DateTime? monthYearDate;
  final bool isMonth;
  final DateTime? initDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color? color;
  final bool? showDayText;
  final String? title;
  final TextStyle? titleStyle;
  CustomDatePickerWidget({
    super.key,
    required this.saveDate,
    this.monthYearDate,
    this.isMonth = false,
    this.color,
    this.initDate,
    this.lastDate,
    this.firstDate,
    this.showDayText = false,
    this.title,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cubit, states>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(title ?? "Select Date", style:titleStyle?? TextStyles.font15BlackBold),
              verticalSpace(1),
            ],
            InkWell(
              onTap: () async {
                DateTime? dateSelected;
                dateSelected = await showDatePicker(
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  currentDate: monthYearDate ?? dateSelected,
                  context: context,
                  initialDate: initDate ?? DateTime.now(),
                  firstDate: firstDate ?? DateTime(1800),
                  lastDate: lastDate ?? DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        datePickerTheme: DatePickerThemeData(
                          weekdayStyle: Theme.of(context).textTheme.bodyLarge,
                          headerHeadlineStyle: Theme.of(
                            context,
                          ).textTheme.bodyLarge,
                        ),
                        splashColor: Colors.white,
                        colorScheme: const ColorScheme.light(
                          primary: ColorsManager.mainColor,
                          onPrimary: Colors.white,
                          surface: Colors.white,
                        ),
                        dialogTheme: DialogThemeData(
                          backgroundColor: Colors.white,
                        ),
                      ),
                      child: child!,
                    );
                  },
                  confirmText: 'ok',
                  cancelText: 'cancel',
                );
                monthYearDate = dateSelected;
                if (saveDate != null) {
                  saveDate!(dateSelected);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2.w),
                  border: Border.all(
                    width: 0.4,
                    color: ColorsManager.lightGray,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // if (state is state1 || monthYearDate != null)
                    Text(
                      monthYearDate != null
                          ? monthYearDate.toString().split(' ')[0].toString()
                          : title ?? "Select Date",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    // SvgPicture.asset(
                    //   'assets/svg/calendar.svg',
                    //   colorFilter: const ColorFilter.mode(
                    //     ColorsManager.mainColor1,
                    //     BlendMode.srcIn,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
