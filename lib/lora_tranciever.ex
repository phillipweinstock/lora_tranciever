
defmodule LoraTranciever do
  # suppress warnings when compileing the VM
  # not needed or recommended for user apps.
  @compile {:no_warn_undefined, [GPIO,NETWORK,EXAVMLIB,ATOMVM,NETWORK,WIFI]}
  @pin 2 #the inbuilt led

  def start() do
    :wifi.start_network()
    GPIO.set_pin_mode(@pin, :output_od)
    GPIO.open()

    loop(@pin, :low)


  end

  defp loop(pin, level) do
    #GPIO.digital_write(pin, level)
    Process.sleep(1500)
    #:erlang.display("We have toggled the GPIO")
    :erlang.display(level)
    #:erlang.display(:atomvm.platform())
    loop(pin, toggle(level))
  end

  defp toggle(state) do
   case state do
    :high -> :low
    :low -> :high
   end
  end

end
