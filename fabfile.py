from fabric.api import *
from fabric.colors import *
from fabric.contrib.console import confirm

import os

@task
def compile_and_install_package(package_path, package_name):
    """ Compile and install tar.gz or .tgz package """
    # [NOTE] use relative dir
    #with cd(os.path.abspath(os.path.dirname(package_path))):
    with cd(os.path.dirname(package_path)):
        run("tar -xzvf %s" % os.path.basename(package_path))
        with cd(package_name):
            run("./configure")
            run("make -j 8")
            sudo("make install", pty=False)
            sudo("ldconfig")

@task
def install_tmux():
    """ Install tmux on CentOS """
    libevent="libevent-2.0.22-stable"
    tmux="tmux-2.1"
    
    with settings(warn_only = True):
        # prepare install/ in advance
        if not os.path.exists("install"):
            print "Please prepare install directory and %s and %s tar.gz in advance." % (libevent, tmux)
            return
        local("tar -czvf tmux.tgz install/%s.tar.gz install/%s.tar.gz" % (libevent, tmux))
        put("tmux.tgz")
        run("tar -xzvf tmux.tgz")
        sudo("rpm -e --nodeps $(rpm -qa | grep libevent)")
        compile_and_install_package("install/%s.tar.gz" % libevent, libevent)
        compile_and_install_package("install/%s.tar.gz" % tmux, tmux)
        put("tmux/tmux.conf", "~/.tmux.conf")
        run("echo \"alias tmux='tmux -2'\" >> ~/.bashrc")
        sudo("rm -rf install")
        run("rm tmux.tgz")
        local("rm tmux.tgz")

