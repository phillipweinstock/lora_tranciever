defmodule LoraTranciever do
  # suppress warnings when compileing the VM
  # not needed or recommended for user apps.
  #@compile {:no_warn_undefined, [GPIO, NETWORK, EXAVMLIB, ATOMVM,MQTT]}

  def start() do
    #Wifi.start_network()
    lora_start()
    :timer.sleep(2000)
    #Mqtt.start_mqtt()


  end

  defp lora_start() do
    Lora.start_transmitter()
  end
end
