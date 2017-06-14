require 'bygpay/version'
require 'bygpay/configuration'
require 'bygpay/utils'
require 'bygpay/deposits'
require 'bygpay/deposit/mobile'

module Bygpay

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
