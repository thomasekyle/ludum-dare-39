tool
extends Node

export(bool) var reset = false setget onReset

#config
var tileSize = 16
var tileCount = 30
var spritesheet = preload("res://data/tileset/castle_night2.png")


func _ready():
    pass


func onReset(isTriggered):
    if(isTriggered):
        reset = false

        for y in range(tileCount):
            for x in range(tileCount):
                var tile = Sprite.new()
                add_child(tile)
                tile.set_owner(self)
                tile.set_name(str(x+y*tileCount))
                tile.set_texture(spritesheet)
                tile.set_region(true)
                tile.set_region_rect(Rect2(x*tileSize, y*tileSize, tileSize, tileSize))
                tile.set_pos(Vector2(x*tileSize+tileSize/2, y*tileSize+tileSize/2))