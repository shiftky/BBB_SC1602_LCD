class DS18B20
  SLOTS_PATH = '/sys/devices/bone_capemgr.9/slots'

  def initialize
    slots = open(SLOTS_PATH, 'r').read
    system("echo BB-W1:00A0 > #{SLOTS_PATH}") unless slots.include?('BB-W1')

    device_name = open('/sys/bus/w1/devices/w1_bus_master1/w1_master_slaves', 'r').read.chomp
    @device_path = "/sys/bus/w1/devices/#{device_name}/w1_slave"
  end

  def celsius
    raw = open(@device_path, 'r').read
    celsius = raw.split('t=')[1].chomp.to_i
    celsius / 1000.0
  end
end
