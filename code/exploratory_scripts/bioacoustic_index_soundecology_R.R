<<<<<<< HEAD

bioacoustic_index
function (soundfile, min_freq = 2000, max_freq = 8000, fft_w = 1024) 
{
  if (is.numeric(as.numeric(min_freq))) {
    min_freq <- as.numeric(min_freq)
  }
  else {
    stop(" min_freq is not a number.")
  }
  if (is.numeric(as.numeric(max_freq))) {
    max_freq <- as.numeric(max_freq)
  }
  else {
    stop(" max_freq is not a number.")
  }
  if (is.numeric(as.numeric(fft_w))) {
    fft_w <- as.numeric(fft_w)
  }
  else {
    stop(" fft_w is not a number.")
  }
  samplingrate <- soundfile@samp.rate
  freq_per_row = 10
  wlen= samplingrate/freq_per_row
  nyquist_freq <- samplingrate/2
  if (max_freq > nyquist_freq) {
    cat(paste("\n ERROR: The maximum acoustic frequency that this file can use is ", 
              nyquist_freq, "Hz. But the script was set to measure up to ", 
              max_freq, "Hz.\n\n", sep = ""))
  }

  else{  # This is the code that is relevant to me!
    cat("\n This is a mono file.\n")
    left <- channel(soundfile, which = c("left"))
    cat("\n Calculating index. Please wait... \n\n")
    spec_left <- spectro(left, f = samplingrate, wl = fft_w, 
                         plot = FALSE,dB = "max0")$amp   # not sure if max0 dB really matters, but
    rm(left)                                             # this is currently defaulting to dB ref of 20uPa not 1uPa
    specA_left <- apply(spec_left, 1, meandB)
    rows_width = length(specA_left)/nyquist_freq  # why?? isn't this the column width or temp resolution? 
    min_row = min_freq * rows_width  
    max_row = max_freq * rows_width
    specA_left_segment <- specA_left[min_row:max_row]
    freq_range <- max_freq - min_freq
    freqs <- seq(from = min_freq, to = max_freq, length.out = length(specA_left_segment))
    specA_left_segment_normalized <- specA_left_segment - 
      min(specA_left_segment)
    left_area <- sum(specA_left_segment_normalized * rows_width)
    cat("  Bioacoustic Index: ")
    cat(left_area)
    cat("\n\n")
    right_area <- NA
  }
  invisible(list(left_area = left_area, right_area = right_area))
}



spec <- spectro(left, f = samplingrate, wl = fft_w, 
                     plot = TRUE)
=======

bioacoustic_index
function (soundfile, min_freq = 2000, max_freq = 8000, fft_w = 1024) 
{
  if (is.numeric(as.numeric(min_freq))) {
    min_freq <- as.numeric(min_freq)
  }
  else {
    stop(" min_freq is not a number.")
  }
  if (is.numeric(as.numeric(max_freq))) {
    max_freq <- as.numeric(max_freq)
  }
  else {
    stop(" max_freq is not a number.")
  }
  if (is.numeric(as.numeric(fft_w))) {
    fft_w <- as.numeric(fft_w)
  }
  else {
    stop(" fft_w is not a number.")
  }
  samplingrate <- soundfile@samp.rate
  freq_per_row = 10
  wlen= samplingrate/freq_per_row
  nyquist_freq <- samplingrate/2
  if (max_freq > nyquist_freq) {
    cat(paste("\n ERROR: The maximum acoustic frequency that this file can use is ", 
              nyquist_freq, "Hz. But the script was set to measure up to ", 
              max_freq, "Hz.\n\n", sep = ""))
  }

  else{  # This is the code that is relevant to me!
    cat("\n This is a mono file.\n")
    left <- channel(soundfile, which = c("left"))
    cat("\n Calculating index. Please wait... \n\n")
    spec_left <- spectro(left, f = samplingrate, wl = fft_w, 
                         plot = FALSE,dB = "max0")$amp   # not sure if max0 dB really matters, but
    rm(left)                                             # this is currently defaulting to dB ref of 20uPa not 1uPa
    specA_left <- apply(spec_left, 1, meandB)
    rows_width = length(specA_left)/nyquist_freq  # why?? isn't this the column width or temp resolution? 
    min_row = min_freq * rows_width  
    max_row = max_freq * rows_width
    specA_left_segment <- specA_left[min_row:max_row]
    freq_range <- max_freq - min_freq
    freqs <- seq(from = min_freq, to = max_freq, length.out = length(specA_left_segment))
    specA_left_segment_normalized <- specA_left_segment - 
      min(specA_left_segment)
    left_area <- sum(specA_left_segment_normalized * rows_width)
    cat("  Bioacoustic Index: ")
    cat(left_area)
    cat("\n\n")
    right_area <- NA
  }
  invisible(list(left_area = left_area, right_area = right_area))
}



spec <- spectro(left, f = samplingrate, wl = fft_w, 
                     plot = TRUE)
>>>>>>> d69924ce5234437194dd03e3a9ca0fe3c6728deb
