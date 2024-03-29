require 'usage_tracker_server'
require 'json'

module UsageTrackerServer
  module Reactor
    # This method is called upon every data reception
    #
    def receive_data(data)
      doc = parse(data)
      if doc && check(doc)
        store(doc)
      end
    end

    private
      def parse(data)
        JSON(data).tap {|h| h.reject! {|k,v| v.nil?}}
      rescue JSON::ParserError
        UsageTrackerServer.log.error "Tossing out invalid JSON #{data.inspect} (#{$!.message.inspect})"
        return nil
      end

      def check(doc)
        error =
          if    !doc.kind_of?(Hash) then 'invalid'
          elsif doc.empty?          then 'empty'
          elsif !(missing = check_keys(doc)).empty?
            "#{missing.join(', ')} missing"
          end

        if error
          UsageTrackerServer.log.error "Tossing out invalid document #{doc.inspect}: #{error}"
          return nil
        else
          return true
        end
      end

      def check_keys(doc)
        %w( duration env status ).reject {|k| doc.has_key?(k)}
      end

      def store(doc)
        tries = 0

        begin
          UsageTrackerServer.log.debug "Received #{doc.inspect}"
          UsageTrackerServer.adapter.save_doc(doc)

        rescue RestClient::Conflict => e
          if (tries += 1) < 10
            UsageTrackerServer.log.warn "Retrying to save #{doc.inspect}, try #{tries}"
            retry
          else
            UsageTrackerServer.log.error "Losing '#{doc.inspect}' because of too many conflicts"
          end

        rescue
          UsageTrackerServer.log.error "Losing '#{doc.inspect}' because #$!"
        end
      end
  end

end
