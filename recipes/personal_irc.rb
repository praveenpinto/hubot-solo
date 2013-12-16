#
# my personal irc recipe
#

package "git-core"

include_recipe "hubot-solo::nodejs"
include_recipe "hubot-solo::foreverjs"
include_recipe "hubot-solo::redis"

bash "install hubot-irc" do
  user "vagrant"
  cwd "/home/vagrant/"
  creates "maybe"
  code <<-EOH
  STATUS=0
  HOME=/home/vagrant
  export PATH=$HOME/local/bin:$PATH || STATUS=1
  npm install hubot-irc || STATUS=1
  exit $STATUS
  EOH
end

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

cookbook_file "/home/vagrant/repo/hubot/live_hubot.sh" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  source "live_hubot.sh"
end

file "/home/vagrant/repo/hubot/forever.log" do
  owner "vagrant"
  group "vagrant"
  mode "0644"
  action :delete
end

file "/home/vagrant/repo/hubot/out.log" do
  owner "vagrant"
  group "vagrant"
  mode "0644"
  action :delete
end

file "/home/vagrant/repo/hubot/err.log" do
  owner "vagrant"
  group "vagrant"
  mode "0644"
  action :delete
end

file "/home/vagrant/.forever/forever.log" do
  owner "vagrant"
  group "vagrant"
  mode "0644"
  action :delete
end

bash "run myhubot" do
  user "vagrant"
  cwd "/home/vagrant/repo/hubot"
  creates "maybe"
  code <<-EOH
  STATUS=0
  HOME=/home/vagrant
  export PATH=$HOME/local/bin:$PATH || STATUS=1
  export HUBOT_IRC_SERVER=irc.freenode.net || STATUS=1
  export HUBOT_IRC_ROOMS="#jjtesting-irc" || STATUS=1
  export HUBOT_IRC_NICK="jjhubot" || STATUS=1
  export HUBOT_IRC_UNFLOOD="true" || STATUS=1
  forever start -l forever.log -o out.log -e err.log \
     -c bash live_hubot.sh || STATUS=1
  exit $STATUS
  EOH
end

# stop the forever via
# forever stop bin/hubot

