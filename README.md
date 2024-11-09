Assignment02_2420


Introductions 



Project 1

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

Project 2






