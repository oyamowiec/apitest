require "open-uri"

class PricingPolicyRequest

  FLEXIBLE_URL = "http://reuters.com"
  FIXED_URL = "https://developer.github.com/v3/#http-redirects"
  PRESTIGE_URL = "http://www.yourlocalguardian.co.uk/sport/rugby/rss/"

  class << self

    def flexible
      body = prepare_request(FLEXIBLE_URL)
      body.count("a") / 100
    end

    def fixed
      body = prepare_request(FIXED_URL)
      body.count("status")
    end

    def prestige
      body = prepare_request(PRESTIGE_URL)
      body.count("<pubDate>")
    end


    def prepare_request(url)
      URI.parse(url).read
    end

  end

end