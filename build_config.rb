def gem_config(conf)
  #conf.gembox 'default'
  conf.gembox 'full-core'

  # be sure to include this gem (the cli app)
  conf.gem File.expand_path(File.dirname(__FILE__))

  # オプション解析
  conf.gem :git => 'https://github.com/mttech/mruby-getopts.git'
  # HTTPとHTTPSリクエスト生成
  conf.gem :git => 'https://github.com/matsumoto-r/mruby-httprequest.git'
  conf.gem :git => 'https://github.com/luisbebop/mruby-polarssl.git'
  # URL encode
  conf.gem :git => 'https://github.com/mattn/mruby-http.git'
  # JSON生成
  conf.gem :git => 'https://github.com/mattn/mruby-json'
  # debug用関数
  conf.gem :github => "kou/mruby-pp"
end

MRuby::Build.new do |conf|
  toolchain :gcc
  conf.enable_bintest
  conf.enable_debug
  conf.enable_test
  gem_config(conf)
end

