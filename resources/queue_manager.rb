
property :user, kind_of: String, default: 'mqm'

default_action :start

action :create do
  execute 'crtmqm' do
    command "crtmqm #{new_resource.name}"
    user new_resource.user
    group 'mqm'
    creates "/var/mqm/qmgrs/#{new_resource.name}/"
  end
end

action :start do
  execute 'strmqm' do
    command "strmqm #{new_resource.name}"
    user new_resource.user
    group 'mqm'
    not_if "dspmq -m #{new_resource.name} -n | grep RUNNING"
  end
end

