Simple Ruby
====
Download and extract or clone into your puppet modules directory. You can then include the *simple_ruby* and *simple_ruby::packages* class:

```puppet
include simple_ruby::packages
include simple_ruby
Class["Simple_Ruby::Packages"] -> Class["Simple_Ruby"]
```

This will install the default ruby version 1.9.3-p448. If you get a **package already installed** error, you can remove the *simple_ruby::packages* class and manually include the packages installed by it in your own manifests.

The *simple_ruby* also accepts a *version* and *full_version* parameter, which correlate to the source code available on the ruby website. The pattern for the source code archive is as follows:

[http://cache.ruby-lang.org/pub/ruby/*$version*/ruby-*$full_version*.tar.gz](#)

For example, the archive for version 2.1.1 is available at http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.gz

In that case, *version* would be **2.1** and *full_version* would be **2.1.1**, and in code would look like this:

```puppet
class { "simple_ruby":
  version => "2.1",
  full_version => "2.1.1"
}
```
