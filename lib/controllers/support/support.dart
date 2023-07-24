import 'dart:convert';

import 'package:http/http.dart';
import 'package:justbuyeight/constants/api_manager.dart';
import 'package:justbuyeight/constants/app_url.dart';

class SupportController {
  static getSupportData() async {
    Response response = await ApiManager.getRequest(
      SupportUrl.getSupport,
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }

  static contactUs(body) async {
    Response response = await ApiManager.postRequest(
      body,
      SupportUrl.postContact,
      headers: {
        "content-type": "application/json; charset=utf-8",
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOGRmMTEyMDkwYzFjZDdhMTNiNjFjMTlmMmYyODhiZTQ5NTE4ZGZhZjQ1YmQ5NDcxNzc0Y2E1MGY4ODNmZGE4ZjBjMDYwNTE5YzYxOTEzZmMiLCJpYXQiOjE2ODk5MzU5MzQuMzI1MTMsIm5iZiI6MTY4OTkzNTkzNC4zMjUxMzMsImV4cCI6MTcyMTU1ODMzNC4zMjI3ODcsInN1YiI6IjMxIiwic2NvcGVzIjpbXX0.IlC23QjW-vyyhP8m2ajBZUlJPSrp8TDGSi54G8vAQ1cveN5LAwHb6YB0HZElzesMOZp5MnCHphmDwxYvfZZIhr8Mn3C8PN0W2BlfSYlxGRysqoKNHvcAdgY_70TV5LGb16K7WUrhsWGa9ggJLLjYA_lKd5mdQVogjmL5eTdSe542dGuMvks79wIXZnu4TkapjZ7YVIxiBzYVUE6AoVXggJ9tID2e4HBPlCiYLWrJNe9Pu7TzOtTFR8BsygAe8eL4woyq436-1rhw-yAh4HBbn1CucfUP1iOMXjU-l6EagQtShzv8bF_soK8wNWsy1pOpwiAq_8EC7POliS6__TrGzSDCI8uX2yzwjHy3nZobRxBE7Jo1YKe33SZWiiX_fTW5KmJwWG1pPOYqHoAgLHqaKHLGLwVVtgQuLLhZlXICuPA7QHvhQ0Jld9PVl4mQet9h5P6QlWgqBxnRsYHb-pXJdwLMwhSCy4493S3lI3bcQ9Ix9CrdUFTVNP8t9VdFUV_2iG3lBUVDzAN3fVXr17BqDRKH_tA8HHtWOlR9uFWnDODbwEGb8oqJgInBwmh9LF2ELrx-aq64-3I6lZbl1OUTSU32nkdMQFps0JAXEyphExUGiQqK9LS5Cn130CLIMNX1ISGR2gjMf9Vkpz7ugMtmutiiVtc1noQlsHKUNV3fkrw',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      return result;
    }
  }
}
