import pathlib
import shutil

config_path = pathlib.Path('~/.dotFiles/.conifig/hypr/').expanduser()
scripts_path = pathlib.Path("~/.config/hypr/scripts/").expanduser()
status = f"{scripts_path}/current_config.txt"
with open(status, 'w') as f:
    if status == "main.conf":
        f.write("project.conf")
        shutil.copy(f"{config_path}/hyprland.conf", f"{config_path}/main.conf")
        shutil.copy(f"{config_path}/project.conf", f"{config_path}/hyprland.conf")
