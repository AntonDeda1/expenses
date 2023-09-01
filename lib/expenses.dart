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
    showModalBottomSheet(isScrollControlled: true, context: context, builder: ((context) => NewExpense(onAddExpense: _addExpense)));
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      action: SnackBarAction(label: 'Undo', onPressed: (){
        setState(() {
          _registeredExpenses.insert(expenseIndex, expense);
        });
      },),
      content: const Text('Expense deleted')));
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent = Center(child: Text("No expenses, you should try adding some."),);

    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _openAddExpenseOverlay),
      appBar: AppBar(
          title: Text("Expenses"),
          actions: [IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))]),
      body: Column(children: [
        const Text("The chart goes here"),
        Expanded(child: mainContent)
      ]),
    );
  }
}
