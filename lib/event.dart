import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:list_view_flutter/Expense.dart';

class EventScreenState extends StatefulWidget {
  const EventScreenState({Key? key}) : super(key: key);

  @override
  State<EventScreenState> createState() => _EventScreenStateState();
}

class _EventScreenStateState extends State<EventScreenState> {
  List<Expense> currentindex = [];

  void showDialogFunction(int i) {
    TextEditingController visiting = TextEditingController();
    TextEditingController Estimate = TextEditingController();
    if (i > -1) {
      visiting.text = currentindex[i].expense;
      Estimate.text = currentindex[i].amount.toString();
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(" ENTER DETAIL"),
            actions: [
              Column(
                children: [
                  Column(
                    children: [
                      const Text(
                        " Enter the name of Place",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: visiting,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.name,
                      ),
                      const Text(
                        " Enter the Total Price",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: Estimate,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            if (visiting.text.isEmpty) {
                              return;
                            }
                            if (Estimate.text.isEmpty) {
                              return;
                            }
                            var item = Expense(visiting.text.toString(),
                                double.parse(Estimate.text));
                            if (i > -1) {
                              currentindex[i] = item;
                            } else {
                              currentindex.add(item);
                            }
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                " Add",
                                style: TextStyle(color: Colors.black),
                              ),
                              Icon(
                                Icons.send_rounded,
                                color: Colors.black,
                              )
                            ],
                          ))
                    ],
                  )
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " EVENT BOOK ",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, inherit: true),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: currentindex.length,
          itemBuilder: (BuildContext, Index) {
            return Row(
              children: [
                Text(currentindex[Index].expense),
                Text(currentindex[Index].amount.toString()),
                IconButton(
                    onPressed: () {
                      setState(() {
                        showDialogFunction(Index);
                      });
                    },
                    icon: Icon(Icons.edit))
              ],
            );
          }),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogFunction(-1);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
