tmuxstart
=========

Tmuxstart can be used to create reusable configurations for named tmux
sessions.  To use tmuxstart add a binding to your ``.tmux.conf`` file like::

    bind S command-prompt -p "Make/attach session:" "new-window 'tmuxstart \'%%\''"

With the above binding, pressing ``<PREFIX> S`` will prompt you for a session
name.  ``<PREFIX>`` is ``CTRL-b`` by default.


Installation
------------

Just copy the ``tmuxstart`` file to one of the directories in your ``$PATH``.
I suggest either ``/usr/bin``, ``/usr/local/bin``, or ``~/bin``.


Session Files
-------------

To create a default configuration for a named session create a file named after
the session under the directory ``~/.tmuxstart``.  These *session files* will
have the shell variable ``$session`` available to them.

Session files are just sourced shell scripts.  This makes them more flexible
than tmuxinator sessions.  There are no dependencies for tmuxstart so it can
easily be used on any machine with tmux installed.


Helper functions
----------------

To make the process of writing session files easier some helper functions are
included in the tmuxstart script.  The available helper functions are:

new_session
~~~~~~~~~~~
``new_session`` creates a new auto-named session.  This should usually be the
first command called in a session file.  This function accepts the same
arguments as ``tmux new-session``.  Examples::

    new_session  # Just create the session
    new_session -n top htop  # Initial window named "top" running htop

new_window
~~~~~~~~~~~
``new_window`` creates a new window in the new session.  This function accepts
the same arguments as ``tmux new-window``.  Examples::

    new_window  # Just create a new window
    new_window -n edit emacs  # Create a new window named "edit" running emacs
    
rename
~~~~~~
``rename`` renames an existing window.  This function accepts the same arguments
as ``tmux rename-window``.

send_keys
~~~~~~~~~
``send_keys`` sends keys to a given window number in the new session.  This
function accepts the same arguments as ``tmux send-keys``.  Examples::

    send_keys 1 "echo hello" "Enter"  # Run "echo hello" in window 1
    send_keys 2 C-c  # Send Ctrl-C key combination to window 2
    
send_line
~~~~~~~~~
``send_line`` sends a line of input to a given window number in the session.
This function accepts the same arguments as ``send_keys`` but adds "Enter" as
an additional argument to each call. Examples::

    send_line 1 "echo hello"  # Same as example above, but no need for "Enter"

select_window
~~~~~~~~~~~~~
``select_window`` selects the given window number in the new session.  This
function accepts the same arguments as ``tmux select-window``.  Example::

    select_window 1  # Select window 1

select_pane
~~~~~~~~~~~
``select_pane`` selects the given window and pane number in the new session.
This function accepts the same arguments as ``tmux select-pane``.  Examples::

    select_pane 2.1  # Select pane 1 in window 2
    select_pane 1.2  # Select pane 2 in window 1

select_layout
~~~~~~~~~~~~~
``select_layout`` applies a given layout to the selected window.  This
function accepts the same arguments as ``tmux select-layout``.  Example::

    select_layout 2 main-vertical # Arrange window 2 in the main-vertical layout

kill_window
~~~~~~~~~~~
``kill_window`` kills the given window number in the new session.  This
function accepts the same arguments as ``tmux kill-window``.  Example::

    kill_window 1  # Kills window 1

set_env
~~~~~~~
``set_env`` sets an environment variable for the new session.  This function
accepts the same arguments as ``tmux set-environment``.  Example::

    set_env EDITOR acme  # Set EDITOR environment variable to "acme"

set_path
~~~~~~~~
``set_path`` sets the default working directory for new panes in the new
session.  This function access the same arguments as ``tmux default-path``.
Example::

    set_path ~/repos/personal/my_project

split
~~~~~
``split`` splits the given window or pane based on the arguments given.  This
function accepts the same arguments as ``tmux split-window``.  Example::

    split 2 -h  # Split window 2 horizontally
    split 2.1 -l 2  # Split pane 1 in window 2 vertically using 2 text lines
    split 1 -p -v "10%"  # Split window 1 vertically using 10% of given space


swap
~~~~
``swap`` swaps the given pane with another pane.  This function accepts the
same arguments as ``tmux swap-pane``.  Example::

    swap 2.1 -D  # Swap pane 1 in window 2 with the next pane
    swap 3.2 -U  # Swap pane 2 in window 3 with the previous pane
    swap 4.3 -s 2.1  # Swap pane 3 in window 4 with pane 1 in window 2


Example session files
---------------------

The following session file will create a window called "htop" which will run
the ``htop`` command and then create a window containing a shell which will be
selected when the session starts::

    new_session -n htop htop
    new_window

This session file will start a session with a Django server in the first
window and open a vim browser and Django shell in the second window.
`Virtualenvwrapper`_ is used via the ``workon`` command for virtualenv
management::

    # Go to the Django repository directory and start the session
    cd "$HOME/repos/$session"
    new_session -n server

    # Run the Django server in the first window
    send_keys 1 "workon $session" "Enter"
    send_keys 1 "python manage.py runserver" "Enter"

    # Create a second window with a vim file browser open
    new_window -n edit "vim ."

    # Create 20% split at bottom of window 2 and run Django shell in it
    split 2 -v -p "20"
    send_keys 2.2 "workon $session" "Enter"
    send_keys 2.2 "python manage.py shell" "Enter"

    # Select pane 1 in window 2
    select_pane 2.1


Contributing & Help
-------------------

Feel free to contribute new helper functions, features/bug fixes,
documentation, or usage examples.  Pull requests are welcome.

If you need help please open an issue, or comment on my
`tmuxstart announcement`_ if you find a bug or you need help with tmuxstart.


License
-------

Tmuxstart is provided under an MIT license: http://th.mit-license.org/2012


Related Projects
----------------

Inspirations and similar projects:

- `tmuxinator`_
- `teamocil`_


.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/
.. _tmuxstart announcement: http://treyhunner.com/2012/12/tmuxstart/
.. _tmuxinator: https://github.com/aziz/tmuxinator
.. _teamocil: https://github.com/remiprev/teamocil
