extends Node2D

var x = 0
var y = 0
var map = null

func _on_control_gui_input(event):
  if event is InputEventMouseButton:
    if event.is_pressed():
      self.map.uncover(self.x)

# Called when the node enters the scene tree for the first time.
func _ready():
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  if not self.map.generated:
    return
  if self.map.cover[self.x] == 1:
    $fg.show()
    var d = self.map.map[self.x]
    if d == -1:
      $data.show()
    elif d != 0:
      $data.text = str(d)
      $data.show()
    else:
      $data.text = ""
      pass
    self.map.cover[self.x] = 2
