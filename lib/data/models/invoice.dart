import 'customer.dart';
import 'supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceProduct> products;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.products,
  });
}

class InvoiceInfo {
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceProduct {
  final String name;
  final String detail;
  final int quantity;
  final double unitPrice;

  const InvoiceProduct({
    required this.name,
    required this.detail,
    required this.quantity,
    required this.unitPrice,
  });
}
