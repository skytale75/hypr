
import os

def update_submap_config():
    """
    Deletes everything between #-START and #-FINISH in main_submap.conf,
    and then adds the contents of inner_submaps.conf to that space.
    """
    home = os.path.expanduser("~")
    main_submap_path = os.path.join(home, ".config", "hypr", "sources", "main_submap.conf")
    inner_submaps_path = os.path.join(home, ".config", "hypr", "sources", "inner_submaps.conf")

    try:
        with open(inner_submaps_path, 'r') as f:
            inner_content = f.read()

        with open(main_submap_path, 'r') as f:
            main_lines = f.readlines()

        start_marker = "#-START\n"
        finish_marker = "#-FINISH\n"

        if start_marker in main_lines and finish_marker in main_lines:
            start_index = main_lines.index(start_marker)
            finish_index = main_lines.index(finish_marker)

            new_main_lines = main_lines[:start_index + 1]
            new_main_lines.append(inner_content)
            # Ensure there's a newline if inner_content doesn't end with one
            if not inner_content.endswith('\n'):
                new_main_lines.append('\n')
            new_main_lines.extend(main_lines[finish_index:])

            with open(main_submap_path, 'w') as f:
                f.writelines(new_main_lines)
            print("Successfully updated main_submap.conf")
        else:
            print("Error: #-START or #-FINISH marker not found in main_submap.conf")

    except FileNotFoundError as e:
        print(f"Error: {e.filename} not found.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    update_submap_config()
