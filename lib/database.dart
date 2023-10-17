import 'package:flutter/material.dart';
import 'package:notes2_sqllite/services/db_helper.dart';
class DatabaseScreen extends StatelessWidget {
  const DatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: ()async{
              await DatabaseHelper.instance.insertRecord(
                {
                  DatabaseHelper.columnName: "Soubhagya"
                }
              );
            }, child: const Text("Insert")),
            ElevatedButton(onPressed: () async{

              var dbquery = await DatabaseHelper.instance.queryDatabase();
              print(dbquery);
            }, child: const Text("Read")),
            ElevatedButton(onPressed: () async{
              await DatabaseHelper.instance.updateRecord(
                {
                  DatabaseHelper.columnId:2,
                  DatabaseHelper.columnName: "aman"
                }
              );

            }, child: const Text("Update")),
            ElevatedButton(onPressed: ()async{
              await DatabaseHelper.instance.deleteRecord(3);
            }, child: const Text("Delete")),
          ],
        ),
      ),
    );
  }
}
