# dotfiles

Assalamu Alaikum Wa Rahmatullah. <br />
Welcome to my dotfiles repo.


## :warning: Re~~fuck~~factor in progress :warning:
I'm currently refactoring my dotfiles to
be managed by stow. Don't pull until it's
finished, and `dots` will probably be
abandoned from now on.

stow needs to be patched with aspiers/stow#70.

## `dots` dotfile manager Usage

- Create a directory.
```sh
mkdir dotfiles
```
this `dotfiles` directory will be our local repo.

- cd into `dotfiles` directory and init a git repo.
```sh
cd dotfiles
git init
```

- Download `dots` into your `dotfiles` directory and make it executable.
```sh
curl -L https://github.com/ahmubashshir/dotfiles/raw/master/dots > dots
chmod +x dots
```

- For convenient access, add an alias into your `.bashrc` or `.zshrc`.
```sh
alias dots='$HOME/<your dotfile directory>/dots'
```

> :warning: **Warning:** Make sure to change `<your dotfile directory>`


- Track selected dotfiles to your local repo.
```sh
dots cp <~/.dotfile1>[ ~/.dotfile2[ ...]]
```

> :warning: **Example:** If I want to link my `.bashrc` to my local repo, I should run
> ```sh
> dots cp ~/.bashrc
> ```

- Now add, commit and push to origin!

## Usage of dot manager.

> You can find dot manager [here](dots)

| Command | Task |
| --- | --- |
| `dots` or `dots help` | Show the help message |
| `dots cp <file path>` | Track your dotfile |
| `dots ls` | List tracked dotfiles. |
| `dots systemd backup` | Backup systemd config. |
| `dots systemd restore` | Restore systemd config. |
| `dots rm <dotfile>` | unlink and delete dotfile from local repo. |
| `dots ln` | Link dotfiles. |
| `dots ps <chr>`| use chr as seperator. |


## LICENSE

This repo is licensed under [GPL-2.0](LICENSE)
