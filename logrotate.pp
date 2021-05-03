logrotate::rule { 'docker-logs':
  path         => '/tmp/docker/container*/*.log',
  su           => true,
  rotate       => 0,
  size         => '1M',
  rotate_every => 'hour',
  missingok    => true,
  postrotate   => 'echo "Date: $(date) - logrotate" >> /tmp/logrotate.log',
}
