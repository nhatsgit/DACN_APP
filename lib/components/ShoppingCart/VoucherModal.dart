import 'package:ecommerce_app/models/VoucherModel.dart';
import 'package:ecommerce_app/utils/MyFormat.dart';
import 'package:flutter/material.dart';

class VoucherModal extends StatelessWidget {
  final List<VoucherModel> vouchers;
  final double totalPrice;
  final Function(VoucherModel) onVoucherSelected;

  const VoucherModal({
    super.key,
    required this.vouchers,
    required this.totalPrice,
    required this.onVoucherSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chọn mã giảm giá',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  final voucher = vouchers[index];
                  final isValid = totalPrice >= (voucher.donToiThieu ?? -1);
                  return ListTile(
                    title: Text(
                      '${voucher.voucherCode}',
                      style: TextStyle(color: Colors.blue),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Giảm ${voucher.phanTramGiam}% ${voucher.giamToiDa != null && voucher.giamToiDa! > 0 ? "(tối đa ${MyFormat.formatCurrency(voucher.giamToiDa!)})" : ""}',
                          style: TextStyle(fontSize: 12, color: Colors.green),
                        ),
                        if (voucher.donToiThieu != null &&
                            voucher.donToiThieu! > 0)
                          Text(
                            'Đơn tối thiểu: ${MyFormat.formatCurrency(voucher.donToiThieu!)}',
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                      ],
                    ),
                    trailing: isValid
                        ? ElevatedButton(
                            onPressed: () => onVoucherSelected(voucher),
                            child: const Text('Chọn'),
                          )
                        : const Text('Không đủ điều kiện'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
