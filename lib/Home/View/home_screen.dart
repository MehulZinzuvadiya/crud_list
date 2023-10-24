import 'package:crud_list/Home/Provider/home_provider.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeProvider? homeProviderT;
    HomeProvider? homeProviderF;

    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    GlobalKey<FormState> updateformkey = GlobalKey<FormState>();
    homeProviderT = context.watch<HomeProvider>();
    homeProviderF = context.read<HomeProvider>();

    // TextEditingController txtDate = TextEditingController(
    //     text:
    //         '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Simple Crud",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                homeProviderT!.sort();
                setState(() {});
              },
              icon: Icon(Icons.sort))
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.green,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(20),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Insert Data",
                            style: GoogleFonts.lato(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: homeProviderT!.txt_title,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter title';
                              }
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'enter title',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: homeProviderT!.txt_sub,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter subtitle';
                              }
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'enter subtitle',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DateTimeFormField(
                            onDateSelected: (value) {
                              homeProviderT!.selectedDate = value;
                              homeProviderT!.age = homeProviderT!
                                  .calculateAge(homeProviderT!.selectedDate);
                            },
                            mode: DateTimeFieldPickerMode.date,
                            decoration:
                                InputDecoration(hintText: 'Select Date'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  homeProviderT!.addData();
                                  Navigator.of(context).pop();
                                  homeProviderT!.txt_title.clear();
                                  homeProviderT!.txt_sub.clear();
                                  homeProviderT!.sort();
                                }
                              },
                              child: Text(
                                'Add',
                                style: GoogleFonts.poppins(),
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: ListView.builder(
        itemCount: homeProviderT!.data.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey.shade300,
            child: ListTile(
              leading: Text("${homeProviderT!.data[index]['age']}"),
              title: Text("${homeProviderT!.data[index]['title']}"),
              subtitle: Text("${homeProviderT!.data[index]['subtitle']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      homeProviderT!.up_title = TextEditingController(
                          text: homeProviderT!.data[index]['title']);
                      homeProviderT!.up_sub = TextEditingController(
                          text: homeProviderT!.data[index]['subtitle']);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Container(
                              height: 400,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: const EdgeInsets.all(20),
                              child: Form(
                                key: updateformkey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Update Data",
                                      style: GoogleFonts.lato(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: homeProviderT!.up_title,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'enter title';
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'enter title',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: homeProviderT!.up_sub,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'enter subtitle';
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'enter subtitle',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    DateTimeFormField(
                                      initialValue: homeProviderT!.selectedDate,
                                      onDateSelected: (value) {
                                        homeProviderT!.selectedDate = value;
                                        homeProviderT!.age = homeProviderT!
                                            .calculateAge(
                                                homeProviderT!.selectedDate);
                                      },
                                      mode: DateTimeFieldPickerMode.date,
                                      decoration: InputDecoration(
                                          hintText: 'Select Date'),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (updateformkey.currentState!
                                              .validate()) {
                                            homeProviderT!.updateData(index);
                                            Navigator.of(context).pop();
                                            homeProviderT!.up_title.clear();
                                            homeProviderT!.up_sub.clear();
                                            homeProviderT!.sort();
                                          }
                                        },
                                        child: Text(
                                          'Update',
                                          style: GoogleFonts.poppins(),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      homeProviderT!.deleteData(index);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
