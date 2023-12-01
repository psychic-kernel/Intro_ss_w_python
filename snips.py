import sounddevice as sd
import numpy as np

def record_audio(duration, sample_rate=44100):
    recording = sd.rec(int(duration * sample_rate), samplerate=sample_rate, channels=1, dtype=np.int16)
    sd.wait()
    return recording.flatten()

def save_audio(file_path, data, sample_rate=44100):
    sd.write(file_path, data, sample_rate)

# Example usage:
duration = 5  # seconds
audio_data = record_audio(duration)
save_audio("output.wav", audio_data)