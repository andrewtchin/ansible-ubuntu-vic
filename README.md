# ansible-ubuntu-vic

## VMware VIC developer environment

### Prepare

Create an Ubuntu 16.04 VM. Recommended minimum sizing is 2 vCPU and 4 GB RAM and 80 GB storage.

Tested on Ubuntu 16.04 Desktop and Ubuntu 16.04 Server.

This does not work on 18.04. See https://github.com/andrewtchin/ansible-ubuntu-vic/issues/1

### Run

Run the following commands:

1. Installs vim, emacs, development tools, docker, docker-compose, go, govc, drone cli, robot framework,
   delve, asciinema, Google Cloud SDK, cfssl, ShellCheck, changes shell to ZSH

   NOTE: Latest Docker client is installed by default. Use Docker Version Manager to install 1.13
   client required for VIC Engine in Step 6
   
   ```shell
   curl -L https://raw.githubusercontent.com/andrewtchin/ansible-ubuntu-vic/master/ubuntu-vmware.sh | bash
   ```

2. OPTIONAL install your dotfiles (a minimal zshrc from this repo is installed by default to ~/.zshrc)

3. Log out and log back in

4. Make sure you have forked the [VIC repo](https://github.com/vmware/vic) on Github and added a SSH
   key to your Github account

5. Add your Github SSH key to clone repos

   ```shell
   ssh-add ~/.ssh/id_rsa
   ```

6. Clone development repos

   ```shell
   export GITHUB_USER=<Github username>
   bash <(curl -L https://raw.githubusercontent.com/andrewtchin/ansible-ubuntu-vic/master/vmware-repos.sh)
   ```

7. Install Docker Client 1.13.0

   ```shell
    dvm install 1.13.0
   ```

8. Optional: Install `ovftool` if desired. https://www.vmware.com/support/developer/ovf/

   ```shell
   chmod +x VMware-ovftool-4.2.0-4586971-lin.x86_64.bundle
   sudo ./VMware-ovftool-4.2.0-4586971-lin.x86_64.bundle 
   ```
