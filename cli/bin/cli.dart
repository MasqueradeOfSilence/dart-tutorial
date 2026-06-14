import "dart:io";
import "package:http/http.dart" as http;
const version = '0.0.1';
void main(List<String> arguments) 
{
  if (arguments.isEmpty || arguments.first == 'help')
  {
    printUsage();
  }
  else if (arguments.first == 'version')
  {
    print('Dartpedia CLI version $version');
  }
  else if (arguments.first == 'wikipedia')
  {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1): null;
    searchWikipedia(inputArgs);
  }
  else
  {
    printUsage();
  }
}

void searchWikipedia(List<String>? arguments) async
{
  final String articleTitle;

  // If the user didn't pass in arguments, request an article title.
  if (arguments == null || arguments.isEmpty)
  {
    print("Please provide an article title.");
    final inputFromStdin = stdin.readLineSync();
    if (inputFromStdin == null || inputFromStdin.isEmpty)
    {
      print('No article title provided. Exiting.');
    }
    articleTitle = inputFromStdin; // Exit the function if no valid input
  }
  else
  {
    // Otherwise, join the arguments into a single string. 
    articleTitle = arguments.join(' ');
  }
  print("Looking up articles about '$articleTitle'. Please wait.");
  
  // Call the API and await the result
  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent); // Print the full article response (raw JSON for now)
}

void printUsage()
{
  print(
    "The following commands are valid: 'help', 'version, 'search <ARTICLE-TITLE>'"
  );
}

Future<String> getWikipediaArticle(String articleTitle) async 
{
  final url = Uri.https(
    "en.wikipedia.org", // Wikipedia API domain
    "/api/rest_v1/page/summary/$articleTitle" // API path for article summary
  )
  final response = await http.get(url);

  if (response.statusCode == 200)
  {
    return response.body;
  }
  // Return an error message if the request failed
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}
// next step: https://dart.dev/learn/tutorial/async
// Task 5: Update main to call searchWikipedia
// step: 2. also fix cli error
