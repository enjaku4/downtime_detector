module WebAddresses
  class PingDelegationJob < ApplicationJob
    def perform
      WebAddress.ready_to_ping.each do |web_address|
        PingJob.perform_later(web_address.id)
      end
    end
  end
end
