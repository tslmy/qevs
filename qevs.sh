#!/usr/bin/env bash
tmp_file="/tmp/choices.sh"
[ -f $tmp_file ] && rm $tmp_file
echo "#!/usr/bin/env bash" >$tmp_file

set -- _qevs/*_options.txt
if [ ! -f "$1" ]; then
	echo "No options found."
	exit
fi

for filename in _qevs/*_options.txt; do
	item=${filename#_qevs/}
	item=${item%_options.txt}
	choice=$(fzf \
		--header "Pick a choice for ${item} (was ${!item})" \
		--height "40%" --preview "" --layout=reverse \
		--query "${!item}" --print-query <"${filename}" | tail -1)
	# --print-query: Return query if no match. (https://github.com/junegunn/fzf/issues/1937#issuecomment-603031722)
	# tail -1: Removes the line break.
	echo "export ${item}=${choice}" >>$tmp_file

	# Append the option to the file if and only if it does not exist: (https://stackoverflow.com/a/3557165/15154381)
	if grep -qxF "${choice}" "$filename"; then
		echo "You chose ${choice} for ${item}."
	else
		echo "You gave a new value, ${choice}, to ${item}."
		echo "${choice}" >>"${filename}"
	fi
done

chmod +x $tmp_file
