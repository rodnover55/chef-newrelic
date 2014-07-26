
case node["platform"]
  when "debian", "ubuntu"
    include_recipe 'apt'
    execute 'wget -O - http://download.newrelic.com/548C16BF.gpg | sudo apt-key add -'
    execute 'sh -c \'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list\'' do
      notifies :run, 'execute[apt-get update]', :immediately
    end
  when 'redhat', 'centos', 'fedora'
    package 'newrelic_repo' do
      source 'http://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm'
    end
end