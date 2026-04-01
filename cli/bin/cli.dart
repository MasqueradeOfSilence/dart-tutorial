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
  else if (arguments.first == 'search')
  {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1): null;
    searchWikipedia(inputArgs);
  }
  else
  {
    printUsage();
  }
}

void searchWikipedia(List<String>? arguments)
{
  final String articleTitle;

  // If the user didn't pass in arguments, request an article title.
  if (arguments == null || arguments.isEmpty)
  {
    print("Please provide an article title.");
    // Await input and provide a default empty string if the input is null.
    articleTitle = stdin.readLineSync() ?? '';
  }
  else
  {
    // Otherwise, join the arguments into a single string. 
    articleTitle = arguments.join(' ');
  }
  print("Looking up articles about '$articleTitle'. Please wait.");
  print("Here ya go!");
  print("(Pretend this is an article about '$articleTitle')");
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
}
// next step: https://dart.dev/learn/tutorial/async
// step 3: Make the HTTP request and handle the response
