Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.hostname = "puppet.sandbox"
    config.vm.provision :shell, :inline => 'sudo su;\
    apt-get -y update &&\
    apt-get -y install puppet &&\
    echo -e "\n\n\n### O modulo do logrotate só é compatível com as seguintes versões de linux:\n### Ubuntu 18,16 Centos 6,7,9\n\n\n" &&\
    puppet module install puppet-logrotate --version 5.0.0 &&\
    mkdir -p /tmp/docker/container-{1..5}/ &&\
    truncate -s 10M log.log && for i in $(seq 1 5);do cp log.log /tmp/docker/container-$i/;done && rm log.log &&\
    sudo puppet apply /vagrant/logrotate.pp &&\
    cat /etc/logrotate.d/hourly/docker-logs'
    config.vm.define :puppet do |puppet|
        puppet.vm.network "private_network", ip: "192.168.99.103"
    end
end