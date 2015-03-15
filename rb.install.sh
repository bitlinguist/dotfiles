# RB ENVIRONMENT
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# RB BUILD
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# RUBY
rbenv install 2.2.1