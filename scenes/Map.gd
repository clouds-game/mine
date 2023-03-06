extends Node2D

var row = 10
var col = 10
var tile = preload("tile.tscn")
var direction = [-1, +1, -col-1, -col-2, -col-3, col+1, col+2, col+3]

var generated = false
var map = Array()
var cover = Array()

func uncover(x):
  if not generated:
    return
  if cover[x] != 0:
    return
  cover[x] = 1
  if map[x] == 0:
    for t in direction:
      uncover(x+t)


# Called when the node enters the scene tree for the first time.
func _ready():
  print(get_viewport().size)
  for r in row:
    for c in col:
      var t = tile.instantiate()
      t.position = Vector2(r, c) * 50
      t.y = r + 1
      t.x = (r+1) * (col+2) + c+1
      t.map = self
      add_child(t)


# Called every frame. 'delta' is the elapsed time since the previous frame.

func map_generate():
  map = Array()
  cover = Array()
  for c in col+2:
    map.append(-2)
    cover.append(-2)
  for r in row:
    map.append(-2)
    cover.append(-2)
    for c in col:
      var i = 0
      if randf_range(0, 1) < 0.1:
        i = -1  # -1 代表雷
      map.append(i)
      cover.append(0)
    map.append(-2)
    cover.append(-2)
  for c in col+2:
    map.append(-2)
    cover.append(-2)
  for r in row:
    for c in col:
      var x = (r+1) * (col+2) + c+1
      if map[x] != 0:
        continue
      for t in direction:
        if map[x+t] == -1:
          map[x] += 1
  generated = true
  print(len(map), map)


func show_left_boom():
  var total = 0
  for r in row:
    for c in col:
      var x = (r+1) * (col+2) + c+1
      if self.map[x] == -1 and self.cover[x]== 0:
        total +=1
  #print(total)
  get_node("%Label").set_text(str(total))

func _process(_delta):
  if not generated:
    map_generate()
  show_left_boom()





func _on_button_pressed():
  print("click")
  var children = self.get_children()
  print(len(children))
  for child in children:
    child.get_node("fg").hide()
    child.get_node("data").text = ""
  generated = false


