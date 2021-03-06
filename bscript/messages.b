const MESSAGES_WIDTH = 16;
const MESSAGES_SIZE = 10;
longMessage := false;

def wordWrapMessage(message, width) {
    words := split(message, " ");
    t := 0;
    lines := [];
    line := "";
    while(t < len(words)) {
        if(len(words[t]) >= width) {
            words[t] := substr(words[t], 0, width - 1);
        }
        new := "";
        if(len(line) > 0) {
            new := new + " ";
        }
        new := new + words[t];
        if(len(line + new) < width) {
            line := line + new;
            t := t + 1;
        } else {
            lines[len(lines)] := line;
            line := "";
        }
    }
    if(len(line) > 0) {
        lines[len(lines)] := line;
    }
    return lines;
}

def splitGameMessage(message) {
    return wordWrapMessage(message, MESSAGES_WIDTH);
}

def pageGameMessages() {
    i := 0;
    while(i < MESSAGES_SIZE - 1 && len(player.messages) > MESSAGES_SIZE) {
        del player.messages[0];
        i := i + 1;
    }
    moreText := len(player.messages) > MESSAGES_SIZE;
}

def gameMessage(message, color) {
    addGameMessage(message, color, false);
}

def addGameMessage(message, color, isConvo) {
    #trace(message);
    lines := splitGameMessage(message);
    t := 0;
    while(t < len(lines)) {
        player.messages[len(player.messages)] := [lines[t], color];
        t := t + 1;
    }
    withPause := isConvo || longMessage;
    moreText := withPause && len(player.messages) > MESSAGES_SIZE;
    if(withPause = false) {
        while(len(player.messages) > MESSAGES_SIZE) {
            del player.messages[0];
        }   
    }
}

def replaceGameMessage(message, color, isConvo) {
    index := array_find_index(player.messages, s => s[0] = message);
    if(index >= 0) {
        player.messages[index][1] := color;
    } else {
        addGameMessage(message, color, isConvo);
    }
}

def drawGameMessages(x, y) {
    ty := y;
    i := len(player.messages) - 1;
    if(moreText) {
        i := MESSAGES_SIZE - 2;
        drawColoredText(x + 2, ty + 2, COLOR_YELLOW, COLOR_BLACK, "<<Press SPACE>>");
        ty := ty - 10;
    }

    minI := 0;
    if(isLargeUi() && len(player.messages) > 5) {
        minI := 5;
    }

    # show all messages
    while(i >= minI) {
        drawColoredText(x + 2, ty + 2, player.messages[i][1], COLOR_BLACK, player.messages[i][0]);
        ty := ty - 10;
        i := i - 1;
    }
}

def clearGameMessages() {
    player.messages := [];
    moreText := false;
}
