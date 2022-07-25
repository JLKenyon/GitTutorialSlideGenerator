# GitTutorialSlideGenerator
A set of slides for teaching Git, and the scripts and tools to generate those slides.

./run.sh will create a file called out.html which has the current form of the resulting slides.

# Dependencies

This requires GraphViz and TMux to be installed, as it uses both extensively.

# Theory of operation

The main component is a shell script which outputs an html file to stdout.  The HTML file is a combination of direct content from the script, inline SVG images created by the script via GraphViz, and snapshots of the terminal, created via tmux.

The last of these is the most interesting. Git makes complex use of the terminal, including invoking "less" and the users $EDITOR, which makes capturing each step of a complex process like interactive rebasing very complicated. By using tmux, we can create a virtual terminal running a shell, and script entering single key presses (including enter key presses), and capture and export the current contents of the virtual buffer. This allows us to "screenshot" a virtual terminal, which we can then display in HTML with a monospace font and treating white-space as "pre" (preformatted).

# Why is it so slow??!?

A drawback of the tmux approach is, at present, there can be a race condition between telling tmux to send a character, and when the shell/app has processed and updated the virtual terminal. So if you send a command and enter press, we need to sleep until that command has (probably?) finished.

I know of no way around this, it isn't as if Bash/Vim/Git/etc were designed to give us an IPC way of telling hwhen they are "done" processing an input... we are really abusing them in this way.

