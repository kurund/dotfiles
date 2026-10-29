rex.bind("cmd+alt+h", "pane.focus", { direction = "left" })
rex.bind("cmd+alt+j", "pane.focus", { direction = "down" })
rex.bind("cmd+alt+k", "pane.focus", { direction = "up" })
rex.bind("cmd+alt+l", "pane.focus", { direction = "right" })

rex.bind("cmd+alt+r", "client.tab.rename")
rex.bind("cmd+alt+s", "session.rename")

rex.bind("cmd+alt+n", "session.next")
rex.bind("cmd+alt+p", "session.previous")
