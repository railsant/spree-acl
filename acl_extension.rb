# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class AclExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/acl"

  # Please use acl/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end

  def activate
    Admin::BaseController.class_eval do
      require 'ipaddr'
      before_filter :check_acl if RAILS_ENV == 'production'

      def check_acl
        netl = []
        # Example - Loopback IP
        netl << IPAddr.new('127.0.0.1')

        redirect_to root_url unless netl.include?(IPAddr.new(request.remote_ip))
      end
    end
    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end

