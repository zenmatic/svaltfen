def newMap(name, w, h) {
    mapName := name;
    map := {
        "blocks": [],
        "width": w,
        "height": h,
        "npc": [],
        "monster": [],
        "loot": [],
        "secrets": {},
    };
    spaceIndex := getBlockIndexByName("space");
    x := 0;
    while(x < map.width) {
        map.blocks[x] := [];
        y := 0;
        while(y < map.height) {
            map.blocks[x][y] := { "block": spaceIndex, "rot": 0, "xflip": 0, "yflip": 0 };
            y := y + 1;
        }
        x := x + 1;
    }
}

def loadMap(name) {
    mapName := name;
    map := load(name);
    if(map = null) {
        trace(name + " map not found");
    } else {
        minimap := [];
        x := 0;
        while(x < map.width) {
            y := 0;
            minimap[x] := [];
            while(y < map.height) {
                b := map.blocks[x][y];
                if(b.xflip = null) {
                    b["xflip"] := 0;
                    b["yflip"] := 0;
                }
                minimap[x][y] := blocks[b.block].color;
                y := y + 1;
            }
            x := x + 1;
        }
        if(map["secrets"] = null) {
            map["secrets"] := {};
        }
        if(map["npc"] = null) {
            map["npc"] := [];
        }
        if(map["monster"] = null) {
            map["monster"] := [];
        }
        if(map["loot"] = null) {
            map["loot"] := [];
        }
        trace("Loaded map " + name);
    }
}

def saveMap() {
    save(mapName, map);
    trace("Saved map " + mapName);
}

def normalizeMapCoords(mx, my) {
    if(mx < 0) {
        mx := mx + map.width;
    }
    if(mx >= map.width) {
        mx := mx - map.width;
    }
    if(my < 0) {
        my := my + map.height;
    }
    if(my >= map.height) {
        my := my - map.height;
    }
    return { "x": mx, "y": my };
}

def getBlock(mx, my) {
    c := normalizeMapCoords(mx, my);
    return map.blocks[c.x][c.y];
}

def setBlock(mx, my, blockIndex, rot) {
    setBlockFlip(mx, my, blockIndex, rot, 0, 0);
}

def setBlockFlip(mx, my, blockIndex, rot, xflip, yflip) {
    c := normalizeMapCoords(mx, my);
    if(map.blocks[c.x][c.y] = null) {
        map.blocks[c.x][c.y] := { "block": blockIndex, "rot": rot, "xflip": xflip, "yflip": yflip };
    } else {
        if(map.blocks[c.x][c.y].block != blockIndex || map.blocks[c.x][c.y].rot != rot) {
            map.blocks[c.x][c.y].block := blockIndex;
            map.blocks[c.x][c.y].rot := rot;
            map.blocks[c.x][c.y].xflip := xflip;
            map.blocks[c.x][c.y].yflip := yflip;
        }
    }
    minimap[c.x][c.y] := blocks[map.blocks[c.x][c.y].block].color;
}

def initMaps() {
    events["almoc"] := events_almoc;
    events["bonefell"] := events_bonefell;
    events["redclaw"] := events_redclaw;
    events["redclaw2"] := events_redclaw2;
    events["world1"] := events_world1;
    events["beetlecave"] := events_beetlecave;
    events["fenvel"] := events_fenvel;
    events["untervalt"] := events_untervalt;
    events["ashnar"] := events_ashnar;
    events["ashnar2"] := events_ashnar2;
    events["van"] := events_van;
    events["skyforge"] := events_skyforge;
    events["world2"] := events_world2;
    events["xurcelt"] := events_xurcelt;
    events["Ardor"] := events_ardor;
    events["under1"] := events_under1;
    events["vamir"] := events_vamir;
    events["tristen"] := events_tristen;
}
