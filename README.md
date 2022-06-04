# Quick Environment Variable Switcher (Qevs)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Provides a quick way to switch between values for environment variables.

Demo:

[![asciicast](https://asciinema.org/a/bB5VxAi6AvqyBZ9ixFm4K7Nmo.svg)](https://asciinema.org/a/bB5VxAi6AvqyBZ9ixFm4K7Nmo)

## Usage

In the directory where you prepared the `_qevs/*_options.txt` files, run `qs`.

You can type to filter for the desired option (with fuzzy matching) or click on a choice with your mouse.
If you need to set a new value that is absent in the options provided, simply enter it, and Qevs will remember it for the next time.

To unset an environment variable, just hit `esc`.

## Setup

1. Install `fzf`.
2. For each environment variable `X` that you want to switch values, create a file named `_qevs/X_options.txt`, where each line is a possible value for this variable.
3. Run these lines:
   ```shell
   curl https://raw.githubusercontent.com/tslmy/qevs/main/qevs.sh --output ~/bin/qevs.sh && chmod +x ~/bin/qevs.sh
   echo 'alias qs="~/bin/qevs.sh && source /tmp/choices.sh && rm /tmp/choices.sh"' >> ~/.zprofile
   ```
   where `/path/to/envswitcher` should be the path to your Qevs.

## License

MIT.
