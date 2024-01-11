import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form/broadcast/httpclient.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

Future<void> fetchDataWithClient() async{
  final client = RetryClient(
    HttpClient('', http.Client()),
    retries: 3,
    when: (response) => response.statusCode != 200,
    onRetry: (request, response, retryCount) => {
      if (retryCount == 0 && response?.statusCode == 401){
        //refresh and update the token
      }
    },
    //delay: Duration(seconds: 5)
  );
  
  try{
    debugPrint(await client.read(Uri.http('example.com', 'some.txt')));
  } finally{
    client.close();
  }
}

Future<void> fetchData() async{
  final response = await http.get(Uri.parse('https://api.example.com/data'));
  if (response.statusCode == 200){
    debugPrint('GET Request Response: ${response.body}');
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    debugPrint(decodedResponse['uri'] as String);
  }
  else{
    debugPrint('Error: ${response.reasonPhrase}');
  }
}

Future<void> postData() async{
  final response = await http.post(
    Uri.parse('uri'),
    body: {
      'key': 'value'
    }
  );

  if (response.statusCode == 200){
    debugPrint('POST Request Response: ${response.body}');
  }
  else{
    debugPrint('Error: ${response.reasonPhrase}');
  }
}