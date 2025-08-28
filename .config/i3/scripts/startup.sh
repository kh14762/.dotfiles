#!/bin/sh

exec --no-startup-id "i3-msg 'workspace 1; append_layout /home/kheritage/.config/i3/workspaces/workspace-1.json'"
exec --no-startup-id "i3-msg 'workspace 2; append_layout /home/kheritage/.config/i3/workspaces/workspace-2.json'"

