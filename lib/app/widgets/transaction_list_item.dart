import 'package:behalal/app/assets/images.dart';
import 'package:behalal/app/color/colors.dart';
import 'package:behalal/app/universal_utils/currency_util.dart';
import 'package:behalal/controller/transaction_controllers/transaction_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'components.dart';
import 'spacing.dart';

class TransactionListItem extends StatelessWidget {
  final dynamic transaction;

  const TransactionListItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateWithT = transaction.createdAt != null ? (transaction.createdAt).substring(0, 10).replaceAll(RegExp(r'[^\w\s]+'), '') : DateTime.now().toString();
    DateTime dateTime = DateTime.parse(dateWithT);
    String dateFormat = DateFormat('MMM dd').format(dateTime);
    return GetBuilder<TransactionController>(
      builder: (_controller) {
        return InkWell(
          splashColor: AppColors.primaryColor,
          onTap: () async {
            await _controller.getTransactionDetails(transactionID: transaction.id.toString());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        transaction.transactionType == 'Credit' ? SVGImages.buy : SVGImages.sell1,
                        height: 30,
                        width: 30,
                      ),
                      const Spacing.width(15),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    transaction.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xff003780),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      dateFormat.toString(),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacing.height(4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  transaction.tag.toString(),
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  transaction.transactionType == 'Credit'
                                      ? '#${CurrencyUtil.formatCurrency(double.parse(transaction.inflow.toString()))}'
                                      : '#${CurrencyUtil.formatCurrency(double.parse(transaction.outflow.toString()))}',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: transaction.transactionType == 'Credit' ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
