import os
import pathlib

my_list = "/home/mike/.config/hypr/.bind_list.txt"

with open(my_list, "w") as f:
    f.write("")


def search_files_for_strings(start_dir, target_strings):
    """
    Recursively searches files in a directory for lines starting with any string
    in target_strings, ignoring the .git directory.

    Args:
        start_dir (str): The directory path to start the search from.
        target_strings (list): A list of strings to search for at the start of lines.
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
        if ".git" in dirs:
            dirs.remove(".git")

        for file_name in files:
            if file_name == ".bind_list.txt":
                continue
            file_path = os.path.join(root, file_name)
            # Try to open and read the file. Use a try-except block to handle
            # potential errors (e.g., permission issues, non-text files).
            try:
                with open(file_path, "r", encoding="utf-8") as f:
                    for line_num, line in enumerate(f, 1):
                        for target in target_strings:
                            if line.strip().startswith(target):
                                if not line.startswith("submap"):
                                    line = str(line.split(" =")[1])
                                line = line.replace(" , ", "")
                                line = line.replace("$mainMod", "SUPER")
                                count += 1
                                print(f"{line.strip()}")
                                with open(my_list, "a") as f:
                                    f.write(f"{line.strip()}\n")
                                break  # Move to the next line after finding a match
            except Exception as e:
                # Optional: print error if a file can't be read
                # print(f"Could not read file {file_path}: {e}")
                pass
    print(count)


def split_file():
    with open(my_list, "r") as f:
        for line in f:
            print(line, end="")


if __name__ == "__main__":
    # Specify the directory to start the search (e.g., current directory '.')
    # You can change '.' to any absolute path like '/home/user/project'
    search_directory = "/home/mike/.config/hypr/"

    # The strings to look for at the start of lines
    search_terms = ["bind", "submap"]

    search_files_for_strings(search_directory, search_terms)
    split_file()
