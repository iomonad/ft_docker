postgresql['shared_buffers'] = '1MB'
manage_accounts['enable'] = false
host = `hostname`.strip
external_url "http://#{host}"
eval ENV["GITLAB_OMNIBUS_CONFIG"].to_s
from_file("/etc/gitlab/gitlab.rb")
unicorn['worker_processes'] = 2
