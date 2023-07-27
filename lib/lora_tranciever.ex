defmodule LoraTranciever do
  # suppress warnings when compileing the VM
  # not needed or recommended for user apps.
  @compile {:no_warn_undefined, [GPIO, NETWORK, EXAVMLIB, ATOMVM]}

  def start() do
    Wifi.start_network()
    #:io.format("Starting application")
    #lora_start()
    :timer.sleep(2000)
    Mqtt.start_mqtt()


  end

  defp lora_start() do
    Lora.start_transmitter()
     #Lora.start_gateway()
     #lora_Device = Lora.start_client()
    # Lora.start_reciever()
     #payload = "123"
    # Lora.send_lora(lora_Device, payload)
  end
end
