module Sidebars
  class Sidebars::Plugin < ApplicationController
    include ApplicationHelper

    helper :theme

    #  skip_before_filter :get_the_blog_object
    #  skip_after_filter :flush_the_blog_object

    @@subclasses = { }

    def self.inherited(child)
      @@subclasses[self] ||= []
      @@subclasses[self] |= [child]
      super
    end

    def self.subclasses
      @@subclasses[self] ||= []
      @@subclasses[self] + extra =
        @@subclasses[self].inject([]) {|list, subclass| list | subclass.subclasses }
    end

    def self.available_sidebars
      @@available_sidebars ||= Sidebars::Plugin.subclasses.select do |sidebar|
        sidebar.subclasses.empty?
      end
    end


    # The name that needs to be used when refering to the plugin's
    # controller in render statements
    def self.component_name
      if (self.to_s=~/::([a-zA-Z]+)Controller/)
        "plugins/sidebars/#{$1}".underscore
      else
        raise "I don't know who I am: #{self.to_s}"
      end
    end

    # The name that's stored in the DB.  This is the final chunk of the
    # controller name, like 'xml' or 'flickr'.
    def self.short_name
      component_name.split(%r{/}).last
    end

    # The name that shows up in the UI
    def self.display_name
      # This is the default, but it's best to override it
      short_name
    end

    def self.description
      short_name
    end

    def self.default_config
      {}
    end

    def index
      @sidebar=params['sidebar']
      @sb_config = @sidebar.config || self.class.default_config
      content
      render :action=>'content' unless performed?
    end

    def configure_wrapper
      @sidebar=params['sidebar']
      @sidebar.config ||= (self.class.default_config)
      configure
      render :action=>'configure' unless performed?
    end

    # This controller is used on to actually display sidebar items.
    def content
    end

    # This controller is used to configure the sidebar from /admin/sidebar
    def configure
      render_text ''
    end

    private
    def sb_config(key)
      config = @sidebar.class.default_config
      config.merge!(@sidebar.config || {})
      config[key.to_s]
    end

    # Horrid hack to make check_cache happy
    def controller
      self
    end

    def log_processing
      logger.info "\n\nProcessing #{controller_class_name}\##{action_name} (for #{request_origin})"
    end

    def self.default_helper_module!
    end
  end
end