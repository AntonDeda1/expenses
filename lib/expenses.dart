import 'package:expenses/widgets/expenses_list/expenses_list.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Burger",
        amount: 3.5,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Cinema",
        amount: 5,
        date: DateTime.now(),
        category: Category.others)
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(context: context, builder: ((context) => const NewExpense()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _openAddExpenseOverlay),
      appBar: AppBar(
          title: Text("Expenses"),
          actions: [IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))]),
      body: Column(children: [
        const Text("The chart goes here"),
        Expanded(child: ExpensesList(expenses: _registeredExpenses))
      ]),
    );
  }
}
