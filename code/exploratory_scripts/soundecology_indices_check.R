<<<<<<< HEAD

library(tuneR)
library(seewave)
library(soundecology)


# directory for Deploy1 Creek 7
setwd("C:/Users/Becca/Documents/local_data/Sound_habitat_data/Deploy1_05_22/1074286637/")

# trimmed results index: 37
# pmHT index: 72

file1_index = 37+72
filename = "1074286637.190516220000.wav"

audio_file = readWave("1074286637.190516220000.wav")


bi_low = bioacoustic_index(audio_file, min_freq = 100, max_freq = 2000, fft_w = 1024)
=======

library(tuneR)
library(seewave)
library(soundecology)


# directory for Deploy1 Creek 7
setwd("C:/Users/Becca/Documents/local_data/Sound_habitat_data/Deploy1_05_22/1074286637/")

# trimmed results index: 37
# pmHT index: 72

file1_index = 37+72
filename = "1074286637.190516220000.wav"

audio_file = readWave("1074286637.190516220000.wav")


bi_low = bioacoustic_index(audio_file, min_freq = 100, max_freq = 2000, fft_w = 1024)
>>>>>>> d69924ce5234437194dd03e3a9ca0fe3c6728deb
