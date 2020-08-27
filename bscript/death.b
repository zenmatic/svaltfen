def initDeath() {
}

def renderDeath() {
    clearVideo();
    drawText(20, 30, COLOR_WHITE, COLOR_BLACK, "You have died.");
    drawText(20, 185, COLOR_DARK_GRAY, COLOR_BLACK, "Press SPACE to play again");
}

def deathInput() {
    if(isKeyDown(KeySpace)) {
        while(isKeyDown(KeySpace)) {
        }
        mode := "title";

        # delete savegame may be too harsh...
        #erase("savegame.dat");
        #erase("*.mut");
    }
    if(mode != "death") {
        MODES[mode].init();
        MODES[mode].render();
        updateVideo();
    }
}
