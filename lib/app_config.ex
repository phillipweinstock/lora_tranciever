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
    ~c"mqtt://test.mosquitto.org"
  end

  #MQTT publication options

  #LoRa Configuration
  defmacrop erlconst_DEVICE_NAME() do
    quote do
      :Gateway
    end
  end
  #change here to determine the Application behaviour type
  def lora_mode() do
    :gateway
    #:client
  end

  @spec lora_config(:sx127x | :sx126x) :: map()

  def lora_config(device) do
    %{
      spi: :spi.open(spi_config(device)),
      device_name: erlconst_DEVICE_NAME(),
      device: device,
      irq: 26,
      #busy: 22,
      reset: 14
    }
  end

  def spi_config(device) do
    %{
      bus_config: %{miso_io_num: 19, mosi_io_num: 27, sclk_io_num: 18},
      device_config: %{
        erlconst_DEVICE_NAME() => %{
          address_len_bits:
            case(device) do
              :sx127x ->
                8

              _ ->
                0
            end,
          spi_clock_hz: 1_000_000,
          mode: 0,
          spi_cs_io_num: 33
        }
      }
    }
  end
end
