defmodule Lora do
  @pin 27
  def start_transmitter() do
    # :io.format("Attempting to start client/sender")
    loraConfig = :config.lora_config(:sx127x)
    # :io.format("Configuration successfully retrived")
    {:ok, lora} = :lora.start(loraConfig)
    # :io.format(~c"Lora started.  Sending messages...~n")

    loop(lora, 0)
  end

  def start_reciever() do
    #:io.format("Attempting to start reciever")
    loraConfig = :config.lora_config(:sx127x)
    #:io.format("Configuration successfully retrived")
    {:ok, lora} = :lora.start(Map.merge(loraConfig, %{receive_handler: &handle_receive/3}))
    #:io.format(~c"Lora reciever started.  Waiting to receive messages...~n")
    GPIO.set_pin_mode(@pin,:output)
    :timer.sleep(:infinity)
  end

  defp handle_receive(lora, packet, qoS) do
    :io.format(~c"Received Packet: ~p; QoS: ~p~n", [packet, qoS])
    #GPIO.digital_write(@pin,:high)
    #:gpio.digital_write(@pin,:high)
    #:gpio.set_direction(Process.whereis(:gpio),@pin,:high)
    Mqtt.publish(Process.whereis(:mqtt_instance), "lora_transciever/status", packet)
    #:timer.sleep(1000)
    #:gpio.set_direction(Process.whereis(:gpio),@pin,:low)

    #GPIO.digital_write(@pin,:low)
  end

  def send_lora(Device, Payload) do
    try do
      case(:lora.broadcast(Device, Payload)) do
        :ok ->
          :io.format(~c"Sent ~p~n", [Payload])

        error ->
          :io.format(~c"Error sending: ~p~n", [error])
      end
    catch
      :exit, :timeout ->
        :io.format(~c"Timed out broadcasting ~p~n", [Payload])
    end
  end

  defp loop(lora, i) do
    payload = ["AtomVM ", :erlang.integer_to_list(i)]

    try do
      case(:lora.broadcast(lora, payload)) do
        :ok ->
          :io.format(~c"Sent ~p~n", [payload])

        error ->
          :io.format(~c"Error sending: ~p~n", [error])
      end
    catch
      :exit, :timeout ->
        :io.format(~c"Timed out broadcasting ~p~n", [payload])
    end

    :timer.sleep(1000)
    loop(lora, i + 1)
  end
end
