# Python Packages

| Package    | Version |
| ---------- | ------- |
| jupyterhub | 1.0.0   |

# OS Packages

This image is based on Ubuntu.

| Package        | Version |
| -------------- | ------- |
| git            | latest  |
| curl           | latest  |
| rsync          | latest  |
| unzip          | latest  |
| less           | latest  |
| nano           | latest  |
| vim            | latest  |
| openssh-client | latest  |
| cmake          | latest  |
| tmux           | latest  |
| screen         | latest  |
| gnupg          | latest  |
| wget           | latest  |

# Scripts

* install-utilities.sh - install various ubuntu utility packages
* install-ipywidgets.sh - install ipywidgets
* install-nbresuse.sh - install custom nbresuse
* install-nbgrader.sh - install nbgrader and extensions
* install-nbcluster-status.sh - install cluster status
* install-nbgitpuller.sh - install nbgitpuller

# Changelog

2019.4.6 (9/18/2019)

* Added script `install-nbgitpuller.sh` to install nbgitpuller

2019.4.4 (9/16/2019)

* Made `run_jupyter.sh` executable
