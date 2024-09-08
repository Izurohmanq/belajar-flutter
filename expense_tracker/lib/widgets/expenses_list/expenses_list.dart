import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder( // kalau gak tau itemnya ada berapa + kalau mau scrollable, ya pake ListView
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible( // biar bisa ngeswipe item jadi ilang
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        key: ValueKey(expenses[index]), 
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal, 
          )
        ),
        child: ExpensesItem(expenses[index]),
      ),
    );
  }
}