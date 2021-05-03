# LogRotate com Vagrant e Puppet

Imagem ubuntu com Vagrant para validar o funcionamento do modulo LogRotate com o Puppet

## Como instalar e executar

Instalando o Vagrant
```bash
VAGRANT_BIN="${VAGRANT_BIN}"
curl -LO https://releases.hashicorp.com/vagrant/${VAGRANT_BIN}/vagrant_${VAGRANT_BIN}_linux_amd64.zip
unzip vagrant_${VAGRANT_BIN}_linux_amd64.zip
sudo mv vagrant /usr/local/bin && rm vagrant_${VAGRANT_BIN}_linux_amd64.zip
```

Subindo a vm do puppet (Execute no mesmo diretório onde está o Vagrantfile)
```bash
vagrant up
```

Acesse a vm do puppet
```bash
vagrant ssh
```

Teste o funcionamento do seu puppet
```bash
sudo puppet apply -e 'service { "puppet": enable => true, }'
```

O vagrant monta o diretório onde está o seu Vagrantfile dentro de /vagrant/ dentro da VM
```bash
cd /vagrant/
puppet apply logrotate.pp
```

Logs de 10m para simular o ambiente de produção.
```bash
ls -la /tmp/docker/container-*/
```

Os seguintes arquivos devem ter o seguinte conteúdo:
```bash
> cat /etc/logrotate.d/hourly/docker-logs
# THIS FILE IS AUTOMATICALLY DISTRIBUTED BY PUPPET.  ANY CHANGES WILL BE
# OVERWRITTEN.

/tmp/docker/container*/*.log {
  hourly
  missingok
  rotate 0
  size 1M
  su root root
  postrotate
    echo "Date: $(date) - logrotate" >> /tmp/logrotate.log
  endscript
}
```

Forçando a execução do logrotate
```bash
sudo logrotate /etc/logrotate.d/hourly/docker-logs
```

Veja que os arquivos foram apagados
```bash
ls -la /tmp/docker/container-*/
```

Para deletar a VM
```bash
exit
vagrant destroy
```