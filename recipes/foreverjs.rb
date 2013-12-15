#
#
# installing forever.js
#
#

include_recipe "hubot-solo::nodejs"

bash "install forever" do
  user "vagrant"
  cwd "/home/vagrant"
  creates "/home/vagrant/local/bin/forever"
  code <<-EOH
  STATUS=0
  HOME=/home/vagrant
  export PATH=$HOME/local/bin:$PATH || STATUS=1
  npm install forever -g || STATUS=1
  exit $STATUS
  EOH
end


