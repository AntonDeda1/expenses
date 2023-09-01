import 'package:flutter/material.dart';
import 'package:expenses/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  var enteredTitle = '';
  void _saveTitleInput(String input) {
    enteredTitle = input;
  }

  void openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration:
              InputDecoration(label: Text("Write your description here.")),
          autofocus: true,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixText: '\$', label: Text("Enter your amount.")),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? 'No date selected'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: openDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 16,),
        Row(
          children: [
            DropdownButton(
              value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                          child: Text(
                        category.name.toUpperCase(),
                      )),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if(value == null){
                      return;
                    }
                    _selectedCategory = value;
                  });
                }
              ),
              const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            ElevatedButton(onPressed: null, child: const Text('Save expense'))
          ],
        )
      ]),
    );
  }
}