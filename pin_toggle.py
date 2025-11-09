import RPi.GPIO as GPIO
import time

# --- Setup ---
RELAY_PIN = 17  # GPIO17 (Pin 11)
GPIO.setmode(GPIO.BCM)      # Use Broadcom pin numbering
GPIO.setup(RELAY_PIN, GPIO.OUT, initial=GPIO.LOW)

print("Relay toggle test (2-second interval). Press Ctrl+C to stop.")

try:
    while True:
        GPIO.output(RELAY_PIN, GPIO.HIGH)  # Turn relay ON
        print("Relay ON")
        time.sleep(2)

        GPIO.output(RELAY_PIN, GPIO.LOW)   # Turn relay OFF
        print("Relay OFF")
        time.sleep(2)

except KeyboardInterrupt:
    print("\nExiting program...")

finally:
    GPIO.output(RELAY_PIN, GPIO.LOW)
    GPIO.cleanup()
