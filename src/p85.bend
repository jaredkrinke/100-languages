# Rectangles are just choosing 2 lines in each dimension, so total number of
# rectangles, using "n choose r" is: R = w * (w + 1) * h * (h + 1) / 4

# Utility functions
# N.B. to_f24 and to_u24 are built-ins, but I couldn't get them to work without copy-pasting in here
hvm to_f24:
  ($([f24] ret) ret)

hvm to_u24:
  ($([u24] ret) ret)

def floor(x):
  return to_u24(x)

# Problem-specific logic
def countRectangles(w, h):
  return w * (w + 1) * h * (h + 1) / 4

def delta(w, h, goal):
  c = countRectangles(w, h)
  if c > goal:
    return c - goal
  else:
    return goal - c

def findClosestHeight(w, goal):
  # Defining k = w * (w + 1) / 4, need to solve k * h^2 + k * h = 2,000,000
  # N.B. Need to be careful not to overflow the default u24 type!
  k = w * (w + 1) / 4
  h = (0.0 - to_f24(k) + Math/sqrt(to_f24(k * k) + 4.0 * to_f24(goal) * to_f24(k))) / to_f24(2 * k)
  less = floor(h)
  more = less + 1
  if delta(w, less, goal) < delta(w, more, goal):
    return less
  else:
    return more

def computeBest(w):
  goal = 2_000_000
  h = findClosestHeight(w, goal)
  return (w, h, delta(w, h, goal))

def takeBest(a, b):
  aw, ah, ad = a
  bw, bh, bd = b
  if ad < bd:
    return a
  else:
    return b

def main():
  # Upper limit of 2^12 determined by noting 4096*4097*1*2/4 is already too big
  bend d = 0, i = 0:
    when d < 12:
      best = takeBest(fork(d+1, i*2+0), fork(d+1, i*2+1))
    else:
      best = computeBest(i + 1)
  width, height, delta = best
  return width * height

