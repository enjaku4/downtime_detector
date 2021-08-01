module Mailers
  module Async
    def deliver_async(args)
      delay(queue: 'mailers').deliver(args)
    end
  end
end