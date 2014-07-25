
if node['platform_family'] == 'debian'
  include_recipe 'apt'
  execute 'wget -O - http://download.newrelic.com/548C16BF.gpg | sudo apt-key add -'
  execute 'sh -c \'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list\'' do
    notifies :run, 'execute[apt-get update]', :immediately
  end
end