import os
import pathlib
import subprocess
import submap_updater

my_list = os.path.expanduser("~/.config/hypr/.bind_list.txt")

with open(my_list, "w") as f:
    f.write("")

    def send_mako_notification(title, message, app_name=None, icon=None):
        """
        update complete notification
        """
        command = ["notify-send", title, message]

        if app_name:
            command.extend(["-a", app_name])
        if icon:
            command.extend(["-i", icon])

        try:
            subprocess.run(command, check=True)
            print(f"Notification sent: '{title}' - '{message}'")
        except subprocess.CalledProcessError as e:
            print(f"Error sending notification: {e}")
        except FileNotFoundError:
            print(
                "Error: 'notify-send' command not found. Please ensure it is installed."
            )


def remove_all_files_from_directory(directory_path):
    """
    cleans out guides directory to get ready for update
    """
    if not os.path.isdir(directory_path):
        print(f"Error: '{directory_path}' is not a valid directory.")
        return

    for filename in os.listdir(directory_path):
        if filename == "main": # New: Skip deletion of "main" file
            continue
        file_path = os.path.join(directory_path, filename)
        if os.path.isfile(file_path):
            try:
                os.remove(file_path)
                print(f"Removed file: {file_path}")
            except OSError as e:
                print(f"Error removing file {file_path}: {e}")
        # Note: This function only removes files, not subdirectories.
        # To remove subdirectories and their contents, use shutil.rmtree.


# Example usage:
directory_to_clear = os.path.expanduser("~/.config/hypr/guides/")
remove_all_files_from_directory(directory_to_clear)


def search_files_for_strings(start_dir, target_strings):
    """
    Builds list of binds and changes the format
    """
    count = 0
    start_path = pathlib.Path(start_dir)

    if not start_path.is_dir():
        print(f"Error: {start_dir} is not a valid directory.")
        return

    print(f"Starting search in: {start_dir}")

    # Use os.walk with topdown=True to prune directories (like .git)
    for root, dirs, files in os.walk(start_dir, topdown=True):
        # Exclude the '.git' directory from the current walk and further recursion
        exclude = [".git", "scripts", "guides", "listeners", "waybar"]
        for item in exclude:
            if item in dirs:
                dirs.remove(item)
        # if ".git" in dirs:
        #     dirs.remove(".git")
        # if "scripts" in dirs:
        #     dirs.remove("scripts")
        #
        for file_name in files:
            if file_name == ".bind_list.txt":
                continue
            if file_name == "main_submap.conf": # New: Skip this file entirely
                continue
            file_path = os.path.join(root, file_name)
            # Try to open and read the file. Use a try-except block to handle
            # potential errors (e.g., permission issues, non-text files).
            try:
                with open(file_path, "r", encoding="utf-8") as f:
                    for line_num, line in enumerate(f, 1):
                        if "#-d" in line:
                            continue
                        if "#-s" in line:
                            parts = line.split("#-s", 1)
                            text_after = parts[1].strip()
                            if text_after:
                                with open(my_list, "a") as f:
                                    f.write(f"{text_after}\n")
                            else:
                                with open(my_list, "a") as f:
                                    f.write("\n")
                            continue
                        for target in target_strings:
                            if line.strip().startswith(target):
                                # New logic to handle "exec" and "#->"
                                modified_line = line.strip()
                                if "#->" in modified_line:
                                    parts = modified_line.split("#->", 1)
                                    text_before_arrow = parts[0]
                                    text_after_arrow = (
                                        parts[1] if len(parts) > 1 else ""
                                    )  # The comment text after #->

                                    exec_idx = text_before_arrow.find("exec")
                                    if exec_idx != -1:
                                        # Keep everything before "exec" from text_before_arrow
                                        # and append text_after_arrow (the comment itself)
                                        # Then strip to clean up any extra spaces
                                        modified_line = (
                                            text_before_arrow[:exec_idx]
                                            + text_after_arrow
                                        ).strip()
                                    else:
                                        # If 'exec' not found, just take text_before_arrow, effectively removing '#->' and content after it
                                        modified_line = text_before_arrow.strip()
                                else:
                                    modified_line = (
                                        modified_line  # No change if "#->" not present
                                    )

                                line = (
                                    modified_line  # Assign the cleaned line to `line`
                                )

                                if not line.startswith("submap"):
                                    line = str(line.split(" =")[1])

                                line = line.replace("$mainMod", "SUPER")
                                # if count > 1:
                                line = line.replace(" , ", "")
                                track = len(line.split(","))
                                print(track)
                                if track > 2:
                                    line = line.replace(", ", " + ", 1)
                                    line = line.replace(", ", ": ", 1)
                                else:
                                    line = line.replace(" , ", "")
                                    line = line.replace(",", ":")
                                print(f"{line.strip()}")
                                with open(my_list, "a") as f:
                                    f.write(f"{line.strip()}\n")
                                break  # Move to the next line after finding a match
            except Exception as e:
                # Optional: print error if a file can't be read
                # print(f"Could not read file {file_path}: {e}")
                pass
    print(count)

print(my_list)
def extract_and_remove_submaps():
    """
    breaks up the bind list for submap guides
    """
    output_dir = os.path.expanduser("~/.config/hypr/guides")
    os.makedirs(output_dir, exist_ok=True)

    try:
        with open(my_list, "r") as f:
            lines = f.readlines()
    except FileNotFoundError:
        print(f"Warning: {my_list} not found. Skipping submap extraction.")
        return

    if not lines:
        return  # Nothing to process

    lines_to_remove = set()
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        # A submap section starts with "submap = <name>" where name is not "reset"
        if line.startswith("submap =") and "reset" or "main" not in line:
            try:
                submap_name = line.split("=", 1)[1].strip()
                if not submap_name:
                    i += 1
                    continue
            except IndexError:
                i += 1
                continue

            # Found a start, now find the end "submap = reset"
            j = i + 1
            while j < len(lines):
                if lines[j].strip() == "submap = reset" or lines[j].strip() == "submap = main":
                    # End of section found.
                    section_indices = range(i, j + 1)
                    section_content = lines[i + 1 : j]

                    if submap_name != "main": # Prevent writing for 'main' submap
                        # Create the new file for the submap
                        new_file_path = os.path.join(output_dir, submap_name)
                        try:
                            with open(new_file_path, "w") as f_out:
                                f_out.writelines(section_content)
                            print(f"Created submap file: {new_file_path}")
                            # Mark these lines to be removed from the original file
                            lines_to_remove.update(section_indices)
                        except IOError as e:
                            print(f"Error writing to {new_file_path}: {e}")

                    # Continue search after this section
                    i = j
                    break
                j += 1
        i += 1

    if lines_to_remove:
        final_lines = [
            line for idx, line in enumerate(lines) if idx not in lines_to_remove
        ]
        try:
            with open(my_list, "w") as f:
                f.writelines(final_lines)
            print(f"Removed extracted submaps from {my_list}")
        except IOError as e:
            print(f"Error updating {my_list}: {e}")


if __name__ == "__main__":
    submap_updater.update_submap_config()
    search_directory = os.path.expanduser("~/.config/hypr/")

    search_terms = ["bind", "submap"]

    search_files_for_strings(search_directory, search_terms)
    extract_and_remove_submaps()
    subprocess.run("hyprctl dispatch submap reset", shell=True)
    send_mako_notification("Bind List", "Updated")
