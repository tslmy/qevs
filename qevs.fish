function qs
    # Check if the _qevs directory exists
    if not test -d _qevs
        echo "The '_qevs' directory does not exist. Please create it and add your *_options.txt files before invoking the Quick Environment Variable Switcher (qevs) via `qs`."
        return 1
    end

    # Initialize an empty list to store the options files
    set options_files

    # Collect the list of *_options.txt files
    for file in _qevs/*_options.txt
        # Check if the file actually exists to avoid adding the wildcard pattern itself
        if test -f $file
            set options_files $options_files $file
        end
    end

    # Check if the list of options files is empty
    if not count $options_files > /dev/null
        echo "No *_options.txt files found in the '_qevs' directory. Please add them before invoking the Quick Environment Variable Switcher (qevs) via `qs`."
        return 1
    end

    # Iterate over each options file and update the corresponding environment variable
    for filename in $options_files
        # Extract the variable name from the filename
        set var_name (string replace -r '_qevs/(.*)_options.txt' '$1' -- $filename)

        # Get the current value of the variable, if set
        set -q $var_name
        and set current_value $$var_name
        or set current_value ''

        # Use fzf to select the new value
        set choice (fzf \
            --header "Pick a choice for $var_name (current: $current_value)" \
            --height 40% --layout=reverse \
            --query "$current_value" --print-query < $filename | tail -n 1)

        # Update the variable if a choice was made
        if test -n "$choice"
            set -gx $var_name $choice
            echo "Set $var_name to $choice."

            # If the choice is new, append it to the options file
            if not grep -qFx -- "$choice" $filename
                echo "Adding new value '$choice' to $filename."
                echo $choice >> $filename
            end
        end
    end
end
