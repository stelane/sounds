defmodule Sounds.GS do
  use GenServer

  def start_link(notes) do
    case GenServer.start_link(__MODULE__, notes, name: __MODULE__) do
      {:ok, pid} ->
        {:ok, synth} = MIDISynth.start_link([])
        spawn(MIDISynth.Keyboard, :play, [synth, 60, 800, 100])
        {:ok, pid}

      _error ->
        {:error, :init_error}
    end
  end

  @impl true
  def init(notes) do
    {:ok, notes}
  end

  @impl true
  def handle_call(:play_one, _from, [note | rest] = _state) do
    spawn(MIDISynth.Keyboard, :play, note)
    {:reply, note, rest}
  end

  @impl true
  def handle_cast({:play_cast, note}, state \\ []) do
    spawn(MIDISynth.Keyboard, :play, note)
    Process.sleep(500)
    {:noreply, [note | state]}
  end
end
