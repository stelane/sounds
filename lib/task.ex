defmodule Sounds.Task do
  {:ok, synth} = MIDISynth.start_link([])

  notes =
    [
      [synth, 60, 800, 100],
      [synth, 60, 800, 100],
      [synth, 67, 800, 100],
      [synth, 67, 800, 100],
      [synth, 69, 800, 100],
      [synth, 69, 800, 100],
      [synth, 67, 1600, 100],
      [synth, 65, 800, 100],
      [synth, 65, 800, 100],
      [synth, 64, 800, 100],
      [synth, 64, 800, 100],
      [synth, 62, 800, 100],
      [synth, 62, 800, 100],
      [synth, 60, 1600, 100]
    ]

  ### ASYNC
  Task.async(MIDISynth.Keyboard, :play, [synth, 60, 800, 100])

  Enum.map(notes, fn note ->
    MIDISynth.Keyboard
    |> Task.async(:play, note)
    |> Task.await()
  end)

  Enum.map(notes, fn note ->
    Task.async(MIDISynth.Keyboard, :play, note)
  end)

  ### AWAIT MANY

  Task.await_many([
    Task.async(MIDISynth.Keyboard, :play, [synth, 60, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 60, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 67, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 67, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 69, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 69, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 67, 1600, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 65, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 65, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 64, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 64, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 62, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 62, 800, 100]),
    Task.async(MIDISynth.Keyboard, :play, [synth, 60, 1600, 100])
  ])

  ### ASYNC STREAM
  stream =
    Task.async_stream(notes, fn note ->
      apply(MIDISynth.Keyboard, :play, note)
    end)

  Enum.to_list(stream)

  ### TIMEOUTS
  # MIDISynth.Keyboard
  # |> Task.async(:play, [synth, 60, 800, 100])
  # |> Task.await(0)
end
