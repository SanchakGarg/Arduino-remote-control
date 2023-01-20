#include <SoftwareSerial.h>
String BT_data;

SoftwareSerial BTserial(12,13); // RX, TX
void setup() {
  BTserial.begin(9600);
  Serial.begin(9600);
  pinMode(13,OUTPUT);
  Serial.println("Connected");
  }

void loop() {
  // put your main code here, to run repeatedly:
  if (BTserial.available())
  {
    BT_data = BTserial.readString();
    digitalWrite(13,HIGH);
    delay(6);
    digitalWrite(13,LOW);
    Serial.println(BT_data);
    
  }
}
