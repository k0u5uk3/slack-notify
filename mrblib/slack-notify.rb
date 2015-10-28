def usage()
   puts "Usage : " + File.basename(__FILE__) + ' [-v][-h] -u url -c channel -n name -m message'
end

def symbolize_keys(hash)
     hash.map{|k,v| [k.to_sym, v] }.to_h
end

def slack_notify(url, channel, name, message)
   hash = {
      "channel" => channel,
      "username" => name,
      "text" => message,
   }

   json = JSON::stringify(hash)
   urlenc = HTTP::URL::encode(json)
   res = HttpRequest.new.post url, "payload=" + urlenc, { "Content-Type" => "application/x-www-form-urlencoded"}
end

def __main__(argv)
   arg_hash = Getopts.getopts("vhu:c:n:m:", 'version', 'help')
   # getoptsは文字列のキーを持つハッシュを返すのでシンボルにしておく
   arg_hash = symbolize_keys(arg_hash)

   if arg_hash.has_key?(:v) or arg_hash.has_key?(:version)
      puts "v#{SlackNotify::VERSION}"
      exit
   elsif arg_hash.has_key?(:h) or arg_hash.has_key?(:help)
      usage
      exit
   elsif arg_hash.has_key?(:u) and arg_hash.has_key?(:c) and arg_hash.has_key?(:n) and arg_hash.has_key?(:m)
      slack_notify(arg_hash[:u], arg_hash[:c], arg_hash[:n], arg_hash[:m])
   else
      usage
      exit
   end
end
