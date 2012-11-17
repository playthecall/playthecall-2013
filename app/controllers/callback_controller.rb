class CallbackController < ApplicationController
  def fbrealtime
    puts "="*80
    puts YAML.dump(params)
    puts "="*80
    puts params.inspect
    render text: params['hub.challenge']
  end
end
