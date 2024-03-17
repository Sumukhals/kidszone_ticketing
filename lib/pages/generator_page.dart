import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrgenscan/model/app_constants.dart';

class GenerateQrCodePage extends StatefulWidget {
  const GenerateQrCodePage({Key? key}) : super(key: key);

  @override
  State<GenerateQrCodePage> createState() => _GenerateQrCodePageState();
}

class _GenerateQrCodePageState extends State<GenerateQrCodePage> {
  String qrData = 'https://www.github.com/kamranhccp';
  String qrGenErrorText = "";
  String phoneNumberErrorText = "";
  String ticketCountErrorText = "";
  final qrTextPhoneNumberController = TextEditingController();
  final qrTextTicketCountController = TextEditingController();
  bool isQrVisible = false;

  bool isValidPhoneNumber = false;
  bool isValidTicketCount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'QR Code Generator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: qrTextPhoneNumberController,
                decoration: InputDecoration(
                  errorText: phoneNumberErrorText,
                  hintText: "Enter phone number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        16.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 14.0,
              ),
              TextField(
                controller: qrTextTicketCountController,
                decoration: InputDecoration(
                  errorText: ticketCountErrorText,
                  hintText: "Ticket count",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        16.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 14.0,
              ),
              const Text("Generated QR Code",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 10.0,
              ),
              Visibility(
                visible: isQrVisible,
                child: Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 250,
                    child: QrImage(
                      data: qrData,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Divider(
                height: 20.0,
                thickness: 1.0,
                color: Colors.black,
                endIndent: 42.0,
                indent: 42.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.only(left: 55.0, right: 55.0),
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(
                        32.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    bool isValidPress = CheckIfValuesAreValid();
                    if (!isValidPress) {
                      this.isQrVisible = false;
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              qrGenErrorText,
                              style: TextStyle(fontSize: 17.0),
                            ),
                          ),
                        );
                      });
                    } else {
                      setState(() {
                        this.isQrVisible = true;
                        qrData = qrTextPhoneNumberController.text;
                      });
                    }
                  },
                  child: const Text(
                    "Generate QR Code",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool CheckIfValuesAreValid() {
    bool isValidValues = false;

    qrGenErrorText = "";

    isValidValues = ValidatePhoneNumber();
    isValidValues = ValidateTicketCount();

    return isValidValues;
  }

  bool ValidatePhoneNumber() {
    bool isValidPhoneNumber = false;
    String phoneNumber = qrTextPhoneNumberController.text;

    if (phoneNumber.length == GeneratorConstants.phoneNumberLength) {
      isValidPhoneNumber = true;
    } else {
      phoneNumberErrorText = "Phone number has to be 10 Digits";
      qrGenErrorText = "Enter valid phone number";
    }

    return isValidPhoneNumber;
  }

  bool ValidateTicketCount() {
    bool isValidTicketCount = false;

    String ticketCount = qrTextTicketCountController.text;

    if (ticketCount.length <= GeneratorConstants.maxTicketCount) {
      isValidTicketCount = true;
    } else {
      ticketCountErrorText = "Enter valid ticket count";
      qrGenErrorText += "Ticket count cannot be more than " +
          GeneratorConstants.maxTicketCount.toString();
    }

    return isValidTicketCount;
  }
}
