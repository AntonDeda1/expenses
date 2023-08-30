import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(title: "Burger", amount: 3.5, date: DateTime.now(), category: Category.food),
    Expense(title: "Cinema", amount: 5, date: DateTime.now(), category: Category.others)

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text("The chart goes here"),
        
      ]),
    );
  }
}