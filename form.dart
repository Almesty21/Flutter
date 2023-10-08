import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_inspiration/details.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _travelNameController = TextEditingController();
  final _travelDescriptionController = TextEditingController();
  final _travelAttractionsController = TextEditingController();

  @override
  void dispose() {
    _travelNameController.dispose();
    _travelDescriptionController.dispose();
    _travelAttractionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text("Travel Inspiration Form"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            MyTextField(
              myController: _travelNameController,
              fieldName: "Please Enter Name",
              myIcon: Icons.account_balance,
              prefixIconColor: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 10.0),
            MyTextField(
              myController: _travelDescriptionController,
              fieldName: "Please Enter Description",
              myIcon: Icons.person,
              prefixIconColor: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 10.0),
            MyTextField(
              myController: _travelAttractionsController,
              fieldName: "Attractions",
              prefixIconColor: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 10.0),
            const ImageUploadForm(),
            const SizedBox(height: 20.0),
            myBtn(context),
          ],
        ),
      ),
    );
  }

  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Details(
              destinationAttractions: _travelNameController.text,
              destinationDescription: _travelDescriptionController.text,
              destinationName: _travelAttractionsController.text,
            );
          }),
        );
      },
      child: Text(
        "Submit Form".toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController myController;
  final String fieldName;
  final IconData? myIcon;
  final Color? prefixIconColor;

  const MyTextField({
    Key? key,
    required this.myController,
    required this.fieldName,
    this.myIcon,
    this.prefixIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      decoration: InputDecoration(
        labelText: fieldName,
        prefixIcon:
            myIcon != null ? Icon(myIcon, color: prefixIconColor) : null,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class ImageUploadForm extends StatefulWidget {
  const ImageUploadForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageUploadFormState createState() => _ImageUploadFormState();
}

class _ImageUploadFormState extends State<ImageUploadForm> {
  late Future<File?> _imageFile;

  @override
  void initState() {
    super.initState();
    _imageFile = getImageFile();
  }

  Future<File?> getImageFile() async {
    // Code to get image file from device storage or camera goes here
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _imageFile = getImageFile();
            });
          },
          child: const Text('Choose Image'),
        ),
        FutureBuilder<File?>(
          future: _imageFile,
          builder: (BuildContext context, AsyncSnapshot<File?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return Image.file(snapshot.data!);
            } else if (snapshot.error != null) {
              return const Text('Error choosing image.');
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
