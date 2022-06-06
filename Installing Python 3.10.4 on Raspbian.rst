Installing Python 3.10.4 on Raspbian
=================================

As of July 2018, Raspbian does not yet include the latest Python release, Python 3.10.4. This means we will have to build
it ourselves, and here is how to do it.

1. Install the required build-tools (some might already be installed on your system).

   .. code-block:: bash

        sudo apt-get update -y
        sudo apt-get install build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev -y

   If one of the packages cannot be found, try a newer version number (e.g. ``libdb5.4-dev`` instead of ``libdb5.3-dev``).

2. Download and install Python 3.10.4. When downloading the source code, select the most recent release of Python, available
   on the `official site <https://www.python.org/downloads/source/>`_. Adjust the file names accordingly.

   .. code-block:: bash

        wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tar.xz
        tar xf Python-3.10.4.tar.xz
        cd Python-3.10.4
        ./configure
        make -j 4
        sudo make altinstall

3. Optionally: Delete the source code and uninstall the previously installed packages. When
   uninstalling the packages, make sure you only remove those that were not previously installed
   on your system. Also, remember to adjust version numbers if necesarry.

   .. code-block:: bash

        sudo rm -r Python-3.10.4
        rm Python-3.10.4.tar.xz
        sudo apt-get --purge remove build-essential tk-dev -y
        sudo apt-get --purge remove libncurses5-dev libncursesw5-dev libreadline6-dev -y
        sudo apt-get --purge remove libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev -y
        sudo apt-get --purge remove libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev -y
        sudo apt-get autoremove -y
        sudo apt-get clean

or simply copy the setup.sh content to a file called setup.sh, do a chmod +x setup.sh and execute the script via sudo ./setup.sh

Afterwards, execute any of your scripts (`yourscript.py` is just a placeholder) using

   .. code-block:: bash

        python3.7 yourscript.py.


This guide is pretty much taken from the following tutorial:
https://liudr.wordpress.com/2016/02/04/install-python-on-raspberry-pi-or-debian/
and
https://gist.github.com/BMeu/af107b1f3d7cf1a2507c9c6429367a3b
