defmodule AppConfig do
  # Wifi configuration
  def wifi() do
    %{
      sta: [
        ssid: ~c"Silence of the LAN_2G",
        psk: ~c"invitehimoverfordinner",
        dhcp_hostname: ~c"Lora_gateway"
      ]
    }
  end

  # MQTT end point
  def mqtt_endpoint() do
    #~c"mqtt://test.mosquitto.org"
    ~c"mqtt://rule28.i4t.swin.edu.au"
  end

  # change here to determine the Application behaviour type
  def lora_mode() do
    :gateway
    # :client
  end

end
