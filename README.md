# dotfiles

Assalamu Alaikum Wa Rahmatullah. Welcome to my dotfiles repo.

## Process

- First you need to create a directory. 
```
mkdir dotfiles
```
this ```dotfiles``` directory is our local repo.

- Now clone the dot manager into your ```dotfiles``` directory.
```
curl -L https://github.com/ahmubashshir/dotfiles/raw/master/dots > dots
```

- Now init your local repo.
```
git -C dotfiles init
```

- Change directory & enter into dotfiles directory.
```
cd dotfiles
```

- Now execute the dot manager.
```
chmod +x dots
```

- For easy use you should add this line into your ```.bashrc``` or ```.zshrc``` file.
```
alias dots='$HOME/<your dotfile directory>/dots'
```

> :warning: **Warning**
>
> Make sure to change ```<your dotfile directory>```


- Now link track dotfiles to your local repo one by one.
```
dots cp <dotfile path>
```

> :warning: **Example**
>
> If I want to link my ```.bashrc``` to my local repo, I should run -   
> ```dots cp ~/.bashrc```

- Now add, commit and push to your github!
  
  
## Usage of dot manager.

> You can find dot manager [here](https://github.com/ahmubashshir/dotfiles/blob/master/dots)

| Command | Work |
| --- | --- |
| ```dots``` or ```dots help``` | Show the help message |
| ```dots cp <file path>``` | Track your dotfile |
| ```dots ls``` | List tracked dotfiles. |
| ```dots systemd backup``` | Backup systemd config. |
| ```dots systemd restore``` | Restore systemd config. |
| ```dots rm <dotfile>``` | unlink and delete dotfile from local repo. | 
| ```dots ln``` | Link dotfiles. | 
| ```dots ps <chr>```| use chr as seperator. |
  
## LICENSE
  
This repo is licensed under [GPL-2.0](./LICENSE)
