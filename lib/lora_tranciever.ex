defmodule LoraTranciever do
  # suppress warnings when compileing the VM
  # not needed or recommended for user apps.
  @compile {:no_warn_undefined, [GPIO, NETWORK, EXAVMLIB, ATOMVM]}

  def start() do
    Wifi.start_network()
    Mqtt.start_mqtt()
    #:timer.sleep(2000)
    lora_start()
  end

  defp lora_start() do
    :lora_sender.start()
    #  Lora.start_gateway()
     #lora_Device = Lora.start_client()
     #payload = "123"
    # Lora.send_lora(lora_Device, payload)
  end
end
