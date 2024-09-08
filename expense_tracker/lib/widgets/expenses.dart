import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpanses = [
  // dummy data
    Expense(
        title: 'Kotlin Course',
        amount: 12000,
        date: DateTime.now(),
        category: Category.work
    ),
    Expense(
        title: 'LifePool 3',
        amount: 13000,
        date: DateTime.now(),
        category: Category.leisure
    ),
  ];

  void _openAddExpenseOverlay () {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  // buat nambah item expense
  void _addExpense (Expense expense) {
    setState(() {
      _registeredExpanses.add(expense);
    });
  }

  // buat menghapus Expense
  void _removeExpense (Expense expense) {
    final expenseIndex = _registeredExpanses.indexOf(expense);

    setState(() {
      _registeredExpanses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(   // buat pop up kecil di bawah untuk undo
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'undo', 
          onPressed: () {
            setState(() {
              _registeredExpanses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expense Found. Coba tambah'),
    );

    if (_registeredExpanses.isNotEmpty) {
      mainContent = ExpensesList(
              expenses: _registeredExpanses,
              onRemoveExpense: _removeExpense,
            );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, 
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          // toolbar taro di sini
          Chart(expenses: _registeredExpanses), 
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
