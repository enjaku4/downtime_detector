module PingingService
  class BulkPingWorker
    include Sidekiq::Worker

    def perform
      WebAddressRepository.new.ready_to_ping.each do |web_address|
        PingWorker.perform_async(web_address.id)
      end
    end
  end
end