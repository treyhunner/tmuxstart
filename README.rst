tmuxstart
=========

Tmuxstart can be used to create reusable configurations for named tmux
sessions.  To use tmuxstart add a binding to your ``.tmux.conf`` file like::

    bind S command-prompt -p "Make/attach session" "new-window 'tmuxstart \'%%\''"

With the above binding, pressing ``<PREFIX> S`` will prompt you for a session
name.  ``<PREFIX>`` is ``CTRL-b`` by default.

Default session configurations
------------------------------

To create a default configuration for a named session create a file named after
the session under the directory ``~/.tmuxstart``.  These *session files* will
have the shell variable $session available to them.

Session files are simple
~~~~~~~~~~~~~~~~~~~~~~~~

Session files are just sourced shell scripts.  This makes them more flexible
than tmuxinator sessions.  There are no dependencies for tmuxstart so it can
easily be used on any machine with tmux installed.

Example session files
~~~~~~~~~~~~~~~~~~~~~

The following session file will create a window called "htop" which will run
the ``htop`` command and then create a window containing a shell which will be
selected when the session starts::

    tmux new-session -d -s $session -n htop htop
    tmux new-window -d -t $session

This session file will start a session with a Django server in the first pane
(using `virtualenvwrapper`_ for virtualenv management), open a vim browser in
the project directory in the second pane, and select the second pane::

    cd "$HOME/repos/$session"
    tmux new-session -d -s $session -n server
    tmux send-keys -t $session:1 "workon $session"
    tmux send-keys -t $session:1 "Enter"
    tmux send-keys -t $session:1 "python manage.py runserver"
    tmux send-keys -t $session:1 "Enter"
    tmux new-window -d -t $session -n edit "vim ."
    tmux select-window -t $session:2

.. _virtualenvwrapper: http://www.doughellmann.com/projects/virtualenvwrapper/


License
-------

Tmuxstart is provided under an MIT license: http://th.mit-license.org/2012
