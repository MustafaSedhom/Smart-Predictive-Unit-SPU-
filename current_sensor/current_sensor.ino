

void setup() {
  Serial.begin(9600);
}


float sum = 0;
int count = 0;

float calibrationFactor = 100.0; // تحتاج تضبطه فعليًا

void loop() {
  int raw = analogRead(A0);

  float voltage = (raw * 5.0 / 1023.0) - 2.5; // bias removal

  sum += voltage * voltage;
  count++;

  if (count >= 1000) {
    float Vrms = sqrt(sum / count);

    float current = Vrms * calibrationFactor;

    Serial.print("Current RMS: ");
    Serial.println(current);

    sum = 0;
    count = 0;
  }

  delay(1);
}