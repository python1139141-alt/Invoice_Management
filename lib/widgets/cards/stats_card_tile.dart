import 'package:flutter/material.dart';
import 'package:invoice_management/utils/app_colors.dart';
import '../../controller/dashboard_controller.dart';
import '../text/text_builder.dart';

class StatsCardTile extends StatelessWidget {
  final DashboardController? data;
  final int? index;
  const StatsCardTile({Key? key, this.index, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final item = data?.dashboardList[index ?? 0];
    final colors = [
      AppColors.primaryLight,
      AppColors.success,
      AppColors.danger,
      AppColors.warning,
    ];

    return Container(
      decoration: BoxDecoration(
        color: colors[index ?? 0].withOpacity(0.8),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(item?.icon ?? Icons.error, color: Colors.white, size: 40),
                TextBuilder(text: item?.subTitle ?? '', fontSize: 17.0, color: Colors.white),
              ],
            ),
            TextBuilder(
              text: item?.title ?? '',
              textOverflow: TextOverflow.clip,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
