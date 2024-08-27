defmodule Sounds.Spawn do
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

  play_note = fn -> MIDISynth.Keyboard.play(synth, 60, 80, 100) end

  pid = spawn(play_note)

  Process.alive?(pid)

  Enum.each(notes, fn note ->
    spawn(MIDISynth.Keyboard, :play, note)
    Process.sleep(1000)
  end)
end
