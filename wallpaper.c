#include <stdio.h>
#include <stdint.h>

void wallpaper(uint32_t ans[],
               int width, int height,
               int cx, int cy,
               double scale,
               int ncolors,
               uint32_t colors[]) {
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      double i = cx + x * scale;
      double j = cy + y * scale;
      int c = (int)(i*i + j*j);
      int k = (x + width*y);
      ans[k] = colors[c % ncolors];
    }
  }
}

