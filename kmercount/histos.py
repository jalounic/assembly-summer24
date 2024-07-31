# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import matplotlib.pyplot as plt
import numpy as np

# Load k-mer histogram data
kmer_counts = []
with open('/home/james/Desktop/assembly/results/kmercount/ill_reads19.histo') as f:
    for line in f:
        if line.strip():
            count, freq = map(int, line.strip().split())
            kmer_counts.append((count, freq))
            
arr = np.array(kmer_counts)
print(arr)

# Unpack counts and frequencies
counts, freqs = zip(*kmer_counts)

# Plot the histogram
plt.plot(counts, freqs)
plt.xlabel('K-mer Coverage')
plt.ylabel('Frequency')
plt.title('K-mer Frequency Distribution')
plt.yscale('log')  # Log scale to better visualize the distribution
plt.xscale('log')
plt.show()
