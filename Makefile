all: tweets dependencies blog

setup:
    bundle exec rake setup_github_pages\[git@github.com:zhuhuihuihui/zhuhuihuihui.github.io.git\]

unpub:
    mou .
    fgrep -rIi "published: false" ./source/_posts | awk -F: '{print “mou " $$1}' |bash

tweets:
    bundle exec rake twitter
    make blog MSG="updated twitter"

comments:
    rake build_comments

dependencies:
    (cd ~/workspace/http://zhuhuihuihui.github.io 2>/dev/null || (cd ~/workspace && git clone git@github.com:zhuhuihuihui/http://zhuhuihuihui.github.io)) && git pull
    (cd ~/workspace/bash3boilerplate 2>/dev/null || (cd ~/workspace && git clone git@github.com:zhuhuihuihui/bash3boilerplate.git)) && git pull
    (cd ~/workspace/kvzlib 2>/dev/null || (cd ~/workspace && git clone git@github.com:zhuhuihuihui/kvzlib.git)) && git pull
    (cd ~/workspace/dotfiles 2>/dev/null || (cd ~/workspace && git clone git@github.com:zhuhuihuihui/dotfiles.git)) && git pull
    (cd ~/workspace/transloadit-api2 2>/dev/null || (cd ~/workspace && git clone git@github.com:transloadit/transloadit-api2.git)) && git pull
    (cd ~/workspace/nsfailover 2>/dev/null || (cd ~/workspace && git clone git@github.com:zhuhuihuihui/nsfailover)) && git pull
    (cd ~/workspace/logstreamer 2>/dev/null || (cd ~/workspace && git clone git@github.com:zhuhuihuihui/logstreamer)) && git pull

preview:
    bundle exec rake build && bundle exec rake generate && bundle exec rake preview

blog:
    git pull && \
    bundle install && \
    bundle exec rake integrate && \
    bundle exec rake build && \
    bundle exec rake generate && \
    bundle exec rake deploy && \
    git add .; \
    git commit -am "blog update $$(date +%Y-%m-%d)"; \
    git push origin master

.PHONY: blog%

