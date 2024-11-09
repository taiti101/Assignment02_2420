Assignment02_2420


Introductions 

Hello, we will talk about the Projects and their code

# Project 1

# Project Overview

This project includes a simple Bash script that peforms two main tasks on Arch Linux system, it verifys the root privileges and installs essential packages 

## Script

1. **Root Privilege Check**

The script first checks if it has root privileges, which are required to install packages. If it finds that it’s not running as root, it will display a message ("Run as root") and exit right away.

2. **Package Installation**

Afer the root has confirmed that it has it's root privileges, the script then moves next to install the packages that contains a list of using pacman

- kakoune: A text editor known for being fast and easy to use.

- tmux: A tool that lets you run multiple terminal sessions in one window.

## Running the script:
1. Make sure you have root privileges
2. Run the script in your terminal 

`sudo ./script_name.sh`

## The Code

Here is what my code does, 

```
if [ "$EUID" -ne 0 ]; then 
   echo "Run as root"
   exit 1
else
   echo "Running as root."
fi
```
- It double checks if the script is being run as root
- If it prints out as "Run as root" it will then, exit the script
- If it prints out as "Running as root" it continues

---

```
packages=("kakoune" "tmux")
```
- This one will install a list of packages in the script

---

```
for package in "${packages[@]}": do 
   pacman -S "$package"
   if [[ $? -ne 0 ]]; then
      echo "Failed to install $package"
   else
      echo "$package installed successfully"
   fi
done
```
- It will thoroughly check that each package is in the list
- pacman -s will just install each packages
- If it prints out as "Failed to install $packages" it means it was unsuccessful
- The other one is the opposite

---

This is the Symbolic Links:

```
if [ -d "dir_to_check" ]; then
    echo "Directory '$dir_to_check' already exists."
else
    mkdir "$dir_to_check"
    echo "Directory '$dir_to_check' has been created"
else 
    echo "Failed to create directory '$dir_to_check'"
    exit 1
fi	
```
- Checks if `dir_to_check` exist or not
- If it does, the directory will show that is has been created
- If not, it prints out "Failed to create directory"

---
```
mkdir -p ForTheAssignment2/bin
mkdir -p ForTheAssignment2/.config
```
- It will create a main directory along with bin and .config. The -p option is there to ensure that such directories will be created.

---
```
ln -sf "$(pwd)/2420-as2-starting-files/bin" ForTheAssignment2/bin
ln -sf "$(pwd)/2420-as2-starting-files/config" ForTheAssignment2/.config
ln -sf "$(pwd)/2420-as2-starting-files/home/bashrc" ForTheAssignment2/.bashrc
ln -sf "$(pwd)/2420-as2-starting-files/home/kakrc" ForTheAssignment2/.config/kak/kakrc
ln -sf "$(pwd)/2420-as2-starting-files/home/tmux.conf" ForTheAssignment2/.config/tmux/tmux.conf
```
- The -s creates a symbolic link and -f makes sure that the link to replace any files that exist with the same exact name.

---

# Project 2

# Project Overview

This project is contains a Bash script that would immediately set up a new user on Linux system. It verifies the root accesse, takes options for user setting, and handles tasks like setting the user shell, adding them to groups, and creating a home directory with default files

## Script Functionality

1. **Root Privilege check**

The script will check if it's being run as root. The script will show an error and exit out if it's not being run as root

2. **User Options** 

- Username or -u is the name of the account for the new user
- Shell or -s specifies the shell for the new user, if it does not specify, it will show up as /bin/bash
- Additional Groups or -g allows the addition of the user to groups 

3. **Usage Details**

The script has a function that shows how to use it. If options are incorrect or information is missing, it provides a quick guide on proper usage.

---

```
Root() {
  if [[$EUID -ne 0 ]]; then
      echo "Error: This script must be run as root"
      exit 1
  fi
}
```
- The root makes sure that the script is being run as root
- $EUID stores the ID of the user, if there's no 0, then the user is not root

---
```
username=" "
shell="/bin/bash"
groups=" "
```
- Username is for the user's that enter their new name
- Shell sets /bin/bash as the standard shell for the new user
- Groups are places to add users to.

---
```
User_Account() {
    echo "Usage: $0 -u <username> [-s <shell>] [-g <additional_group>]"
    echo "  -u  Specify the username for the new user (required)"
    echo "  -s  Specify the shell for the new user (optional, default: /bin/bash)"
    echo "  -g  Specify additional groups (optional, comma-separated, no spaces)" 
}
```
- The User_Account shows how to use a script

---
```
while getopts "u:s:g" opt; do
    case "$opt" in
        u) username="$OPTARG" ;;   # Sets the account name
        s) shell="$OPTARG" ;;      # Sets the user shell
        g) groups="$OPTARG" ;;     # Sets additional groups
        *) show_usage; exit 1 ;;   # Shows usage and exits if an invalid option is used
    esac
done
```
- `getopts` handles the options provided in the command line.
- -u, -s, and -g options let the user set a username, shell, and groups.

---
```
if [[ -z "$username" ]]; then
    echo "Error: Username is required."
    show_help
else
    echo "Username is set to $username."
    exit 1
fi
```
- It checks if username was provided, if it hasn't, it shows an error "show_help"

---
```
user_creation() {
   echo "Creating user '$username' with shell '$shell' and group '$groups'..."
   echo "Please enter a password for the new user:"
   passwd "$username"
   cp -r /etc/skel/. "/home/$username"
   chown -R "$username":"$username" "/home/$username"
   echo "Home directory and standard files set up for '$username'."
}
```
- The user_creation part creates the user with the settings that are chosen for them (user).
- It will ask for a password for the new user
- It will copy the files from /etc/skel to the user’s home directory.
- Sets the home directory ownership to the new user


