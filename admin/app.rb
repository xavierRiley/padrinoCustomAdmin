class Admin < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register Padrino::Admin::AccessControl

  ##
  # Application configuration options
  #
  # set :raise_errors, true     # Raise exceptions (will stop application) (default for test)
  # set :dump_errors, true      # Exception backtraces are written to STDERR (default for production/development)
  # set :show_exceptions, true  # Shows a stack trace in browser (default for development)
  # set :logging, true          # Logging in STDOUT for development and file for production (default only for development)
  # set :public, "foo/bar"      # Location for static assets (default root/public)
  # set :reload, false          # Reload application files (default in development)
  # set :default_builder, "foo" # Set a custom form builder (default 'StandardFormBuilder')
  # set :locale_path, "bar"     # Set path for I18n translations (default your_app/locales)
  # disable :sessions           # Disabled sessions by default (enable if needed)
  # disable :flash              # Disables rack-flash (enabled by default if Rack::Flash is defined)
  # layout  :my_layout          # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
  #

  set :login_page, "/admin/sessions/new"

  enable  :sessions
  disable :store_location

  access_control.roles_for :any do |role|
    role.protect "/"
    role.allow "/sessions"
  end

  access_control.roles_for :admin do |role|
    role.project_module :musicians, "/musicians"
    role.project_module :accounts, "/accounts"
  end

  #override buttons in admin
  module Padrino::Helpers::AssetTagHelpers
    def button_to(*args, &block)
      name, url = args[0], args[1]
      options   = args.extract_options!
      desired_method = options[:method]
      options.delete(:method) if options[:method].to_s !~ /get|post/i
      options.reverse_merge!(:method => 'post', :action => url)
      options[:enctype] = "multipart/form-data" if options.delete(:multipart)
      options["data-remote"] = "true" if options.delete(:remote)
      if name == 'Edit'
        return link_to args[0], args[1], options
      end
      if name == 'Delete'
        options[:class] = 'delete'
        options[:onclick] = 'return confirm(\'Are you sure?\')'
        return link_to args[0], args[1], options
      end
      inner_form_html  = hidden_form_method_field(desired_method)
      inner_form_html += block_given? ? capture_html(&block) : submit_tag(name)
      content_tag('form', inner_form_html, options)
    end

    def link_to(*args, &block)
      options = args.extract_options!
      options = parse_js_attributes(options) # parses remote, method and confirm options
      anchor  = "##{CGI.escape options.delete(:anchor).to_s}" if options[:anchor]

      if block_given?
        url = args[0] ? args[0] + anchor.to_s : anchor || 'javascript:void(0);'
        options.reverse_merge!(:href => url)
        link_content = capture_html(&block)
        return '' unless parse_conditions(url, options)
        result_link = content_tag(:a, link_content, options)
        block_is_template?(block) ? concat_content(result_link) : result_link
      else
        name, url = args[0], (args[1] ? args[1] + anchor.to_s : anchor || 'javascript:void(0);')
        if name == 'Create' then options[:class] = 'create_button' end
        if name == 'Cancel' then options[:class] = 'cancel_button' end
        return name unless parse_conditions(url, options)
        options.reverse_merge!(:href => url)
        content_tag(:a, name, options)
      end
    end
  end
end
