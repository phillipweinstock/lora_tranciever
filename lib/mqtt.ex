# Generated by erl2ex (http://github.com/dazuma/erl2ex)
# From Erlang source: c:/Users/pip43/Documents/Projects/lora_tranciever/lib/mqtt.erl
# At: 2023-07-16 16:05:31

defmodule Mqtt do
  @name :mqtt_client
  @pin 27
  def start_mqtt() do
    # config = %{url: AppConfig.mqtt_endpoint(),username: ~c"102101219",password: ~c"102101219", connected_handler: &handle_connected/1}
    config = %{url: AppConfig.mqtt_endpoint(), connected_handler: &handle_connected/1}
    {:ok, mQTT} = :mqtt_client.start(config)
    :io.format(~c"MQTT started.~n")
    :erlang.register(:mqtt_instance, mQTT)
    :timer.sleep(:infinity)
  end

  defp handle_connected(mQTT) do
    config = :mqtt_client.get_config(mQTT)
    topic = "102101219/TNE20003/command"
    GPIO.set_pin_mode(@pin,:output)
    :io.format(~c"Connected to ~p~n", [:maps.get(:url, config)])
    :io.format(~c"Subscribing to ~p...~n", [topic])

    :ok =
      :mqtt_client.subscribe(mQTT, topic, %{
        subscribed_handler: &handle_subscribed/2,
        data_handler: &handle_data/3
      })
  end

  defp handle_subscribed(mQTT, topic) do
    :io.format(~c"Subscribed to ~p.~n", [topic])
    # :io.format(~c"Spawning publish loop on topic ~p~n", [topic])
    # this will start a publishing loop, we do
    :erlang.spawn(fn -> Lora.start_reciever() end)
  end

  # defp handle_data(_mQTT, topic, data) do
  #   :io.format(~c"Received data on topic ~p: ~p ~n", [topic, data])
  #   #:io.format(~c"Binary to list ~p: ~p ~n", [:erlang.binary_to_list(data)])
  #   GPIO.digital_write(@pin,:high)

  #   :ok
  # end
  defp handle_data(_mQTT, topic, "off") do
    :io.format(~c"Turning Cooler off ~n")
    GPIO.digital_write(@pin,:low)

    :ok
  end
  defp handle_data(_mQTT, topic, "on") do
    :io.format(~c"Turning Cooler on ~n")
    GPIO.digital_write(@pin,:high)

    :ok
  end

  def publish(mQTT, topic, msg) do
    :io.format(~c"Publishing data on topic ~p~n", [topic])

    try do
      var_self = self()

      handlePublished = fn mQTT2, topic2, msgId ->
        send(var_self, :published)
        handle_published(mQTT2, topic2, msgId)
      end

      publishOptions = %{qos: :exactly_once, published_handler: handlePublished}
      _ = :mqtt_client.publish(mQTT, topic, msg, publishOptions)

      receive do
        :published ->
          :ok
      after
        10000 ->
          :io.format(~c"Timed out waiting for publish ack~n")
      end
    catch
      :c, :e ->
        :io.format(~c"Error in publish: ~p:~p~n", [:c, :e])
    end
  end

  defp handle_published(mQTT, topic, msgId) do
    :io.format(~c"MQTT ~p published to topic ~p msg_id=~p~n", [mQTT, topic, msgId])
  end
end
