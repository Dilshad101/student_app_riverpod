import 'package:flutter/material.dart';


  popUpMessenger(
      {required BuildContext context,
      required String buttonText,
      required VoidCallback onPressed,
      required Color color,
      required String text}) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: const EdgeInsets.all(20),
        backgroundColor: Colors.black26,
        title: Text(
          'Warning',
          style: TextStyle(
            fontSize: 25,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          const SizedBox(height: 10),
          Text(text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              )),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.white),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(color
                          )),
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }