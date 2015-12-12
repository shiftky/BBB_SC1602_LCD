#!/usr/bin/env ruby
require_relative 'ds18b20'
require 'sc1602_for_bbb'
require 'socket'

def get_ipaddr
  Socket.getifaddrs.select { |x|
    x.name == 'eth0' && x.addr.ipv4?
  }.first.addr.ip_address
end

ports = {
  RS: :P8_8,
  EN: :P8_10,
  D4: :P8_18,
  D5: :P8_16,
  D6: :P8_14,
  D7: :P8_12
}
lcd = SC1602ForBBB::LCD.new(ports)
lcd.write(">#{get_ipaddr}")

ds18b20 = DS18B20.new
while true
  celsius = ds18b20.celsius
  lcd.set_cursor(1, 0)
  lcd.write("%02.3fc" % celsius)
  sleep 0.25
end
