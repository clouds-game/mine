extends Node2D

var row = 10
var col = 10
var tile = preload("tile.tscn")

var generated = false
var map = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
  for r in row:
    for c in col:
      var t = tile.instantiate()
      t.position = Vector2(r, c) * 50
      t.y = r + 1
      t.x = (r+1) * (col+2) + c+1
      t.map = self
      add_child(t)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  if not generated:
    map = Array()
    for c in col+2:
      map.append(0)
    for r in row:
      map.append(0)
      for c in col:
        var i = 0
        if randf_range(0, 1) < 0.1:
          i = -1
        map.append(i)
      map.append(0)
    for c in col+2:
      map.append(0)
    for r in row:
      for c in col:
        var x = (r+1) * (col+2) + c+1
        if map[x] != 0:
          continue
        for t in [-1, +1, -col-1, -col-2, -col-3, col+1, col+2, col+3]:
          if map[x+t] == -1:
            map[x] += 1
    generated = true
    print(len(map), map)

