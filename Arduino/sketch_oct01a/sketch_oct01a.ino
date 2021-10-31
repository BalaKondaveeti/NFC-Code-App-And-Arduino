#include <WiFi.h>
#include <ESPmDNS.h>
#include <ESPAsyncWebServer.h>

AsyncWebServer server(80);
//ESPAsyncWebServer is async web server which can have more connections at a single time
//here we are initialising the variable server with port 80, here port 80 means http connection

char* serviceSetIdentifier = "";
char* password = "";
bool softAp = true;

int value = 0; int value2 = 0;

const char index_html[] PROGMEM = R"rawliteral(
<!DOCTYPE HTML><html><head>
  <title>ESP Input Form</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  </head><body>
  <form action="/get">
    Enter your Code here: <input type="password" name="aut">
    <input type="submit" value="Authenticate">
  </form><br>

</body></html>)rawliteral";

void notFound(AsyncWebServerRequest *request) {
  request->send(404, "text/plain", "Not found");
}


void turnOn(int num) {
  digitalWrite(num, HIGH);
}

void turnOff(int num) {
  digitalWrite(num, LOW);
}

void setup() {
  // put your setup code here, to run once:


  Serial.begin(115200);
  pinMode(15, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(23, OUTPUT);
  turnOn(12);
  turnOn(15);


  if (softAp) {
    WiFi.softAP("NFC Project Access Point", "");
    Serial.print("Soft Access Point Started\nIP Address : ");
    Serial.println(WiFi.softAPIP());
  }
  else {
    WiFi.begin(serviceSetIdentifier, password);
    Serial.print("Connecting to ");
    Serial.print(serviceSetIdentifier);
    while (WiFi.status() != WL_CONNECTED) {
      Serial.print(".");
      delay(1000);
    }
    Serial.println();
  }

  if (MDNS.begin("ESP")) {
    Serial.println("DNS Service started use nfs.local for quicker access");
  }

  turnOn(23);


  server.on("/lock", HTTP_GET, [](AsyncWebServerRequest * request) {
    request->send_P(200, "text/html", index_html);
  });


  server.on("/get", HTTP_GET, [] (AsyncWebServerRequest * request) {
    String inputMessage;
    String inputParam;
    // GET input1 value on <ESP_IP>/get?input1=<inputMessage>

    inputMessage = request->getParam("aut")->value();


    Serial.println(inputMessage);

    if (inputMessage == "uxWShmE7G5PuNNOym7lL" || inputMessage == "hello")
    {
      request->send(200, "text/html", "Authenticated");
      Serial.print("got a request : ");
      value = value + 1;
      if (value % 2 == 0) {
        turnOn(15);
        request->send(200, "text/html", "Led Turned On Success");
      }
      else {
        turnOff(15);
        request->send(200, "text/html", "Led Turned On Success");
      }
    }
    else
      request->send(200, "text/html", "UnAuthenticated");
  });

  server.on("/", [](AsyncWebServerRequest * request) {
    Serial.print("got a request : ");
    value = value + 1;
    if (value % 2 == 0) {
      turnOn(15);
      request->send(200, "text/html", "Led Turned On Success");
    }
    else {
      turnOff(15);
      request->send(200, "text/html", "Led Turned On Success");
    }
    Serial.println(value);
  });

  server.on("/1", [](AsyncWebServerRequest * request) {
    Serial.print("got a request : ");
    value = value + 1;
    if (value % 2 == 0) {
      turnOn(15);
      request->send(200, "text/html", "Led Turned On Success");
    }
    else {
      turnOff(15);
      request->send(200, "text/html", "Led Turned On Success");
    }
    Serial.println(value);
  });
  server.on("/button1", [](AsyncWebServerRequest * request) {
    Serial.print("got a request : ");
    value = value + 1;
    if (value % 2 == 0) {
      turnOn(15);
      request->send(200, "text/html", "Led Turned On Success");
    }
    else {
      turnOff(15);
      request->send(200, "text/html", "Led Turned On Success");
    }
    Serial.println(value);
  });
  server.on("/2", [](AsyncWebServerRequest * request) {
    Serial.print("got a request : ");
    value2 = value2 + 1;
    if (value2 % 2 == 0) {
      turnOn(23);
      request->send(200, "text/html", "Led Turned On Success");
    }
    else {
      turnOff(23);
      request->send(200, "text/html", "Led Turned Off Success");
    }
    Serial.println(value);
  });
  server.on("/button2", [](AsyncWebServerRequest * request) {
    Serial.print("got a request : ");
    value2 = value2 + 1;
    if (value2 % 2 == 0) {
      turnOn(23);
      request->send(200, "text/html", "Led Turned On Success");
    }
    else {
      turnOff(23);
      request->send(200, "text/html", "Led Turned Off Success");
    }
    Serial.println(value);
  });

  server.begin();
  //begin method will start web server on the esp
  Serial.println("Web Server Started");
  turnOff(12);
  delay(1000);
  turnOn(12);
}

void loop() {
  // put your main code here, to run repeatedly:

}
