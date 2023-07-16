defmodule LoraTranciever do
  # suppress warnings when compileing the VM
  # not needed or recommended for user apps.
  @compile {:no_warn_undefined, [GPIO, NETWORK, EXAVMLIB, ATOMVM]}

  def start() do
    Wifi.start_network()
    Mqtt.start_mqtt()
    lora_start(AppConfig.lora_mode())

  end

  defp lora_start(:gateway) do
    Lora.start_gateway()
  end

  defp lora_start(:client) do
    Lora.start_client()
  end
end
