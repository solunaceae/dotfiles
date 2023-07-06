# dotfiles
All my dotfiles, in one easy place.

Created using the following guide: https://www.atlassian.com/git/tutorials/dotfiles

Thanks to @durdn and @atlassiandev for this; I'm copying the guide here so I don't lose it.

## Requirements

- zsh (& by extension, oh-my-zsh)
- neovim (> 0.8.0-ish)
- (optional) thefuck (because it's fun)
- (optional) pyenv

## Future Plans

- [] Create some sort of branching strategy for each machine 
    - [?] Alternatively, create separate install scripts for each OS
- [] Make Packer bootstrapping less of a hackjob

## Packer

Packer's a lil wonky, and I definitely expect you to forget this. 

The first time you launch neovim after checking out this config, it'll break. hard. just run `PackerSync`, restart, rinse, and repeat.
Eventually it'll start working, once it's caught up.
I don't feel like finding a fix for that just yet, but eventually I will.

# Dotfiles: Best Way to Store in a Bare Git Repository

The technique consists in storing a Git bare repository in a "side" folder (like `$HOME/.cfg or $HOME/.myconfig`) using a specially crafted alias so that commands are run against that repository and not the usual .git local folder, which would interfere with any other Git repositories around.

## Starting from scratch

If you haven't been tracking your configurations in a Git repository before, you can start using this technique easily with these lines:

```shell
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

The first line creates a folder (`~/.cfg`) which is a Git bare repository that will track our files.
    Then we create an alias config which we will use instead of the regular git when we want to interact with our configuration repository.
    We set a flag - local to the repository - to hide files we are not explicitly tracking yet. This is so that when you type `config status` and other commands later, files you are not interested in tracking will not show up as untracked.
    Also you can add the alias definition by hand to your `.bashrc` or use the the fourth line provided for convenience.

After you've executed the setup any file within the `$HOME` folder can be versioned with normal commands, replacing git with your newly created config alias, like:

```shell
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

## Install your dotfiles onto a new system (or migrating to this setup)

If you already store your configuration/dotfiles in a Git repository, on a new system you can migrate to this setup with the following steps:

Prior to the installation make sure you have committed the alias to your `.bashrc` or `.zsh`:

```shell
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

And that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:

```shell
echo ".cfg" >> .gitignore
```

Now clone your dotfiles into a bare repository in a "dot" folder of your `$HOME`:

```shell
git clone --bare <git-repo-url> $HOME/.cfg
```

Define the alias in the current shell scope:

```shell
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Checkout the actual content from the bare repository to your `$HOME`:

```
config checkout
```

The step above might fail with a message like:

```shell
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```

This is because your `$HOME` folder might already have some stock configuration files which would be overwritten by Git. The solution is simple: back up the files if you care about them, remove them if you don't care. I provide you with a possible rough shortcut to move all the offending files automatically to a backup folder:

```shell
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

Re-run the check out if you had problems:

```shell
config checkout
```

Set the flag `showUntrackedFiles` to no on this specific (local) repository:

```shell
config config --local status.showUntrackedFiles no
```

You're done, from now on you can now type config commands to add and update your dotfiles:

```shell
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

## Wrapping up

I hope you find this technique useful to track your configuration. If you're curious, my dotfiles live here. Also please do stay connected by following @durdn or my awesome team at @atlassiandev.

