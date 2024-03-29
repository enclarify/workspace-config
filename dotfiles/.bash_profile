. /etc/bash_completion

for file in ~/.{aliases,functions,path,exports}; do
	[[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
	-o "nospace" \
	-W "$(grep "^Host" ~/.ssh/config | \
	grep -v "[?*]" | cut -d " " -f2 | \
	tr ' ' '\n')" scp sftp ssh

# Natural scrolling vertical and horizontal for trackpad
DEVICE_ID=$(xinput list | grep aps | grep trackpad | awk '{print $5}' | cut -d "=" -f 2)
ATTR_ID_PLUS_OFFSETS=$(xinput list-props $DEVICE_ID | grep "Synaptics Scrolling Distance" | sed 's/^.*(\([0-9]*\)):.*-\([0-9]*\), \([0-9]*\)/\1 -\2 -\3/')
xinput set-prop $DEVICE_ID $ATTR_ID_PLUS_OFFSETS