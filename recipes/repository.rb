
case node["platform"]
  when "debian", "ubuntu"
    include_recipe 'apt'
    execute 'wget -O - http://download.newrelic.com/548C16BF.gpg | apt-key add -'
    execute 'sh -c \'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list\'' do
      notifies :run, 'execute[apt-get update]', :immediately
    end
  when 'redhat', 'centos', 'fedora'
    remote_file "#{Chef::Config[:file_cache_path]}/newrelic-repo-5-3.noarch.rpm" do
      source 'http://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm'
      action :create
    end

    rpm_package "newrelic-repo" do
      source "#{Chef::Config[:file_cache_path]}/newrelic-repo-5-3.noarch.rpm"
      action :install
    end
end