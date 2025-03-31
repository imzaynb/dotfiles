# `imzaynb`'s Dotfiles.
Hey there! Thanks for checking out my dotfiles. 

# How to set up these dotfiles in WSL/Linux?
Follow the instructions [here](https://www.atlassian.com/git/tutorials/dotfiles)

# What tools do I use?
Some tools that I keep coming back to include Neovim, TMUX, Alacritty (as a minimal Windows Terminal Emulator), among others. Here is a brief explanation of each.

## Neovim
A text-based code editor. I think I picked this one up freshman year of highschool. Ever since I learned the JHKL-movement commands, I will find myself trying to move around any IDE (e.g. Arduino, 
this Github md editor) using the vimkey binds haha.

### Some configurations
I use Lazy.nvim to setup my configuration. Some absolute must have configuration is easy commenting with Commit.nvim and a nice colorscheme. Lately I have been enjoying Kanagawa Dragon.

### Todo
- [ ] Add configuration for easier tab movement instead of `:tabnext`/`:tabprev`
- [ ] Look into vim surround key binds?
- [ ] Look into persisting vim folds
- [ ] Look into cpp lsp/treesitter support
- [ ] move the tab menu to the bottom?

## TMUX
When not using Neovim, I use VSCode, and really appreciate the ability to set and dock different files as panes in the editor. However, VSCode's interface is really too cluttered for my liking, 
and I really only like using it to debug programs (until I learn how to integrate some cpp debugger into neovim that is!).

TMUX is able to give me not only paning but also different tabs (for instance, in one pane I will have my neovim editor and in another I will have bash to compile+execute programs).

### Some configurations
I primarily changed the status line and the colors that are used for each part. I think one of the other configurations is used to make TMUX play friendly with alacritty being translucent, but I don't recall which one(s)...

## Other

### Alacritty
I use alacritty on Windows, but I don't really know a great way of adding that to this repository. I might make a new branch and add that configuration there. It isn't too hard, just add the kanagawa theme and make it transluscent.

### Todo
- [ ] Add alacritty to this repository
- [ ] Move to fish as a shell
