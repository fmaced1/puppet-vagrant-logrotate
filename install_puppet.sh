# Intall vagrant
VAGRANT_BIN="${VAGRANT_BIN}"
curl -LO https://releases.hashicorp.com/vagrant/${VAGRANT_BIN}/vagrant_${VAGRANT_BIN}_linux_amd64.zip
unzip vagrant_${VAGRANT_BIN}_linux_amd64.zip
sudo mv vagrant /usr/local/bin && rm vagrant_${VAGRANT_BIN}_linux_amd64.zip

# Subindo a vm do puppet (Execute no mesmo diretório onde está o Vagrantfile)
vagrant up

# Acesse a vm do puppet
vagrant ssh

# Teste o funcionamento do seu puppet
sudo puppet apply -e 'service { "puppet": enable => true, }'

# O vagrant monta o diretório onde está o seu Vagrantfile dentro de /vagrant/ dentro da VM
cd /vagrant/
puppet apply logrotate.pp

# Logs de 10m para simular o ambiente de produção.
ls -la /tmp/docker/container-*/

# Os seguintes arquivos devem ter o seguinte conteúdo:
cat /etc/logrotate.d/hourly/docker-logs

# Forçando a execução do logrotate
sudo logrotate /etc/logrotate.d/hourly/docker-logs

# Veja que os arquivos foram apagados
ls -la /tmp/docker/container-*/

# Para deletar a VM
vagrant destroy