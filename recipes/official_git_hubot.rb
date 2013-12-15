#
#
# Pull your hubot scripts down from github
#
#

include_recipe "hubot-solo::nodejs"
package "git-core"

bash "install hubot" do
  user "vagrant"
  cwd "/home/vagrant/"
  creates "/usr/local/bin/hubot"
  code <<-EOH
  STATUS=0
  HOME=/home/vagrant
  export PATH=$HOME/local/bin:$PATH || STATUS=1
  npm install -g hubot || STATUS=1
  exit $STATUS
  EOH
end

bash "install coffeescript" do
  user "vagrant"
  cwd "/home/vagrant/"
  #creates "maybe"
  code <<-EOH
  STATUS=0
  HOME=/home/vagrant
  export PATH=$HOME/local/bin:$PATH || STATUS=1
  npm install -g coffee-script || STATUS=1
  exit $STATUS
  EOH
end

bash "create hubot" do
  user "vagrant"
  cwd "/home/vagrant/"
  creates "/home/vagrant/myhubot-official"
  code <<-EOH
  STATUS=0
   HOME=/home/vagrant
  export PATH=$HOME/local/bin:$PATH || STATUS=1
  hubot --create myhubot-official || STATUS=1
  exit $STATUS
  EOH
end



bash "initialize git in hubot" do
  user "vagrant"
  cwd "/home/vagrant/myhubot-official"
  creates "/home/vagrant/myhubot-official/.git/"
  code <<-EOH
  STATUS=0
  git config --global user.name "I'm a fake name"
  git config --global user.email fake@notreal.gov
  git init || STATUS=1
  git add . || STATUS=1
  git commit -m "Gratz you have a hubot" || STATUS=1
  exit $STATUS
  EOH
end

