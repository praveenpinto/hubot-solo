#
#
# Pull your hubot scripts down from github
#
#

package "git-core"

directory "/home/vagrant/repo/" do
  owner "vagrant"
  group "vagrant"
  recursive true
end

directory "/home/vagrant/scripts" do
  owner "vagrant"
  group "vagrant"
  recursive true
end

git "/home/vagrant/repo/hubot" do
  repo "https://github.com/jjasghar/myhubot.git"
  user "vagrant"
  group "vagrant"
  action :sync
end
