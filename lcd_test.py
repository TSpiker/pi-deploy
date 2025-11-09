from RPLCD.i2c import CharLCD
import time

# Initialize the LCD (address 0x27, adjust if different)
lcd = CharLCD('PCF8574', 0x27)

lcd.clear()
lcd.write_string("Hello Terry!")
time.sleep(2)

lcd.cursor_pos = (1, 0)  # second line, first column
lcd.write_string("Pi + LCD = :)")

time.sleep(5)
lcd.clear()
