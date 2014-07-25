include_recipe 'newrelic::repository'

package 'newrelic-sysmond'

execute "nrsysmond-config --set license_key=#{node['newrelic']['license']}"

service 'newrelic-sysmond' do
  action [:enable, :start]
end