// Defines a News class to represent the entire JSON response structure
class News {
  // Status of the response (e.g., "ok" or "error")
  String? status;

  // Total number of results returned in the response
  int? totalResults;

  // A list of articles, each represented by an Articles object
  List<Articles>? articles;

  // Constructor with named optional parameters
  News({this.status, this.totalResults, this.articles});

  // Constructor that creates a News object from a JSON map
  News.fromJson(Map<String, dynamic> json) {
    status = json['status']; // Assigns value from JSON 'status' key
    totalResults = json['totalResults']; // Assigns value from 'totalResults'
    
    // Checks if 'articles' is not null before parsing
    if (json['articles'] != null) {
      articles = <Articles>[]; // Initializes empty list of Articles
      
      // Loops through each article in the JSON list
      json['articles'].forEach((v) {
        // Converts each JSON map into an Articles object and adds it to the list
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  // Converts the News object back to JSON map format
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>(); // Create a new map
    data['status'] = this.status; // Adds status to map
    data['totalResults'] = this.totalResults; // Adds totalResults to map
    
    // Checks if articles list exists, then converts each Articles object to JSON
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
      // map() is used to convert each article object into a JSON map
      // toList() converts the result of map into a list
    }

    return data; // Returns the final map
  }
}

// Class representing each article in the list
class Articles {
  // The source of the article (another custom object)
  Source? source;

  // Article details, all fields are nullable to match possible null values in JSON
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  // Constructor with optional named parameters
  Articles(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  // Creates an Articles object from a JSON map
  Articles.fromJson(Map<String, dynamic> json) {
    // If source is not null, convert JSON source into a Source object
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;

    // Assigns each field from the JSON map
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  // Converts Articles object back to JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>(); // New map

    // Converts source object to JSON if it's not null
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }

    // Adds all article details to the JSON map
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;

    return data; // Returns the map
  }
}

// Class representing the source of an article
class Source {
  // Source ID and name, both nullable
  String? id;
  String? name;

  // Constructor with optional named parameters
  Source({this.id, this.name});

  // Creates a Source object from a JSON map
  Source.fromJson(Map<String, dynamic> json) {
    id = json['id']; // Assigns id from JSON
    name = json['name']; // Assigns name from JSON
  }

  // Converts Source object to JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>(); // New map
    data['id'] = this.id; // Adds id to map
    data['name'] = this.name; // Adds name to map
    return data; // Returns the map
  }
}
