defmodule Sounds.Monitor do
  def monitor do
    {:ok, synth} = MIDISynth.start_link([])

    {_pid, _monitor_ref} =
      spawn_monitor(fn ->
        MIDISynth.Keyboard.play(synth, 60, 800, 100)
        raise "RAISING HERE"
      end)
  end
end
