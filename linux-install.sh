#!/bin/bash

APP_NAME="/home/.local/opt/Chippies/Chippies.desktop"
KDE_HOTKEY="Meta+Shift+Space"
GNOME_HOTKEY="<Super><Shift><Space>"

chmod +x ./Chippies

mkdir ~/.local/opt/Chippies
mv ./Chippies.desktop ~/.local/share/applications/
echo "created .desktop file"
cp -r ./* ~/.local/opt/Chippies/
echo "Chippies installed to ~/.local/opt/Chippies"
ln -sf ~/.local/opt/Chippies/Chippies /home/ao/.local/bin/Chippies
echo "executable successfully symlinked"

if [ $XDG_SESSION_HOME == "KDE" ]; then
	echo "KDE desktop enviroment detected..."
	
	CONFIG_FILE="$HOME/.config/kglobalshortcutsrc"

	kwriteconfig5 --file "$CONFIG_FILE" --group "khotkeys" --key "$APP_NAME" "$KDE_HOTKEY,none,Launch $APP_NAME"
	qdbus org.kde.kglobalaccel /component/khotkeys org.kde.kglobalaccel.Component.reloadConfig

	echo "Chippies hotkey $KDE_HOTKEY set for KDE."
elif [ $XDG_SESSION_HOME == "GNOME" ]; then
	echo "GNOME desktop enviroment detected..."
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/Chippies-open/ binding "$GNOME_HOTKEY"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/Chippies-open/ name 'Open Chippies'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/Chippies-open/ command 'Chippies'
	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/Chippies-open/']"
	echo "Chippies hotkey $GNOME_HOTKEY set for GNOME."

elif [ $XDG_SESSION_HOME == "sway" ]; then
	echo "Sway desktop enviroment detected..."
	echo "Sway skipped..."
else
	echo "Err - this install script currently doesn't support '$XDG_SESSION_HOME'"
fi

echo "Chippies successfully installed."
exit 0
