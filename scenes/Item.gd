extends Node2D

var x = 0
var y = 0
var map = null

# Called when the node enters the scene tree for the first time.
func _ready():
  pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  if self.map.generated:
    $fg.show()
    var d = self.map.map[self.x]
    if d == -1:
      $data.show()
    elif d != 0:
      $data.text = str(d)
      $data.show()
