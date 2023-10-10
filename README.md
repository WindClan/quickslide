# quickslide
WIP ad billboard for ComputerCraft. Many things don't work, but what DOES work is the ability to sequence through different files in the images directory.
If you are using an image exported from juroku (or similar), add the following line (or similar) to the end of the file (preferably before the `return` keyword!!):
```lua
image.draw(term.current())
```
