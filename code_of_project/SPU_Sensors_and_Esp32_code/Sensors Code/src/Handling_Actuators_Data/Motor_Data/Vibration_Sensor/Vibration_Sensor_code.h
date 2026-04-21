
// | Vibration (g) | الحالة      |
// | ------------- | ----------- |
// | 0.0 – 0.2     | طبيعي جدًا  |
// | 0.2 – 1.0     | اهتزاز بسيط |
// | 1.0 – 3.0     | متوسط       |
// | > 3.0         | خطر ⚠️      |
// #include <Wire.h>
// #include <Adafruit_Sensor.h>
// #include <Adafruit_ADXL345_U.h>

// Adafruit_ADXL345_Unified accel(1);

// float sum = 0;
// int count = 0;

// void setup() {
//   Serial.begin(9600);

//   if (!accel.begin()) {
//     Serial.println("ADXL345 not found!");
//     while (1);
//   }
// }

// void loop() {
//   sensors_event_t event;
//   accel.getEvent(&event);

//   float x = event.acceleration.x;
//   float y = event.acceleration.y;
//   float z = event.acceleration.z;

//   // remove gravity
//   float vib = sqrt(x*x + y*y + z*z) - 9.8;

//   // RMS accumulation
//   sum += vib * vib;
//   count++;

//   if (count >= 20) {
//     float vrms = sqrt(sum / count);

//     Serial.print("Vibration RMS (g): ");
//     Serial.print(vrms);
//     Serial.print(" m/s²");
//    if (vrms < 0.5) {
//       Serial.println(" -> Good");
//     }
//     else if (vrms >= 0.5 && vrms < 1) {
//       Serial.println(" -> Normal");
//     }
//     else if (vrms >= 1 && vrms < 3) {
//       Serial.println(" -> Warning");
//     }
//     else {
//       Serial.println(" -> Dangerous");
//     }

//     sum = 0;
//     count = 0;
//   }

//   delay(50);
// }