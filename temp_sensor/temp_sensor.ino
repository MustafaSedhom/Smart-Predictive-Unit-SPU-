float sum = 0;
int count = 0;

void loop() {
  int raw = analogRead(A0);

  float voltage = (raw * 5.0) / 1023.0;
  float current = voltage * 100.0;

  sum += current * current;
  count++;

  if (count >= 100) {
    float Irms = sqrt(sum / count);

    Serial.print("Current RMS: ");
    Serial.println(Irms);

    sum = 0;
    count = 0;
  }

  delay(2);
}