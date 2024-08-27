defmodule Sounds.SimpleGS do
  use GenServer

  def start_link(note) do
    case GenServer.start_link(__MODULE__, note, name: __MODULE__) do
      {:ok, pid} ->
        {:ok, synth} = MIDISynth.start_link([])
        spawn(MIDISynth.Keyboard, :play, [synth, 60, 800, 100])
        {:ok, pid}

      _error ->
        {:error, :init_error}
    end
  end

  @impl true
  def init(note) do
    {:ok, note}
  end

  @impl true
  def handle_call(:play_one, _from, note) do
    {:ok, synth} = MIDISynth.start_link([])
    note_arg = [synth, note, 800, 100]
    spawn(MIDISynth.Keyboard, :play, note_arg)
    # uncomment the next line for example of how Supervisor stays up and Genserver gets restarted
    # raise "OH NO SOMETHING WENT WRONG"
    {:reply, note, note}
  end
end
