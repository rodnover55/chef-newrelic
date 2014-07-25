include_recipe 'newrelic::repository'

package 'newrelic-php5'

case node["platform"]
  when "debian", "ubuntu"
    php_custom_config_path = '/etc/php5/conf.d/50-newrelic.ini'
    service = 'service[apache2]'
  when 'redhat', 'centos', 'fedora'
    php_custom_config_path = '/etc/php.d/newrelic.ini'
    service = 'service[httpd]'
end

directory File.dirname(php_custom_config_path)

template php_custom_config_path do
  source 'newrelic.ini.erb'
  notifies :restart, service, :delayed
  action :nothing
end


execute 'newrelic-install install' do
  notifies :create, "template[#{php_custom_config_path}]", :immediately
end

