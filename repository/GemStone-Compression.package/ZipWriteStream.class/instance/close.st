initialize-release
close
  self deflateBlock.
  self flushBlock: true.
  encoder close