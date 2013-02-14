module ApplicationHelper

  def active_site_links
    # Possible memcache candidate. needs refactor this is a down
    # dirty approach
    c = %w{web_apps nginx_vhosts web_app_instances machines web_servers}
    h = c.inject({}) {|a,x| a[x.to_sym] = {:name => x}; a }
    if h.has_key? controller.controller_name.to_sym
      h[controller.controller_name.to_sym][:active] = true
    end
    h
  end

  def beta_site_links
    # Possible memcache candidate. needs refactor this is a down
    # dirty approach
    c = %w{rails_dash port_tracker}
    h = c.inject({}) {|a,x| a[x.to_sym] = {:name => x}; a }
    if h.has_key? controller.controller_name.to_sym
      h[controller.controller_name.to_sym][:active] = true
    end
    h
  end

  # this method creates the link_to links for #site-nav
  def site_nav_links( kind )
    links = "#{kind}_site_links".to_sym
    if [:active_site_links, :beta_site_links].include?(links)
      capture_haml do
        (self.send links).each do |k,v|
          haml_tag(:li, :class => v.has_key?(:active) ? 'active' : "") do
            haml_concat link_to v[:name].titleize,
                                url_for(:controller => v[:name], :action => :index)
          end
        end
      end
    end
  end

  def explain_errors( model )
    if model.present? && model.errors.any?
      capture_haml do
        haml_tag :h4 do
          haml_concat <<-HERE_DOC
            #{pluralize( model.errors.count, "error")} prohibited this
            #{ model.class } from being saved:
          HERE_DOC
        end
        haml_tag :ul do
          model.errors.full_messages.each do |msg|
            haml_tag :li, msg
          end
        end
      end
    end
  end

  def port_picker( start_num = 60000, end_num = 60100)
    h = {'unknown' => [], 'socket' => [], '80' => [], '443' => []}
    start_num.upto(end_num).map {|x| h[x.to_s] = []}
    h = combine_web_app_and_nginx(h)
    h.symbolize_keys!
  end

  def combine_web_app_and_nginx( hash = {})
    hash = web_app_instances_ports( hash )
    hash = nginx_vhost_ports( hash )
    a = hash.keys.sort
    hash_sorted = {};
    a.map {|x| hash_sorted[x] = hash[x]}
    hash_sorted
  end

  def web_app_instances_ports( hash = {} )
    WebAppInstance.all.map do |x|
      dp = x.downstream_port.to_s
      if dp.blank? && hash.has_key?('unknown')
        hash['unknown'] << [x.class.to_s, x.id]
      elsif hash.has_key?( dp )
        hash[dp]        << [x.class.to_s, x.id]
      else
        hash[dp] = []   << [x.class.to_s, x.id]
      end
    end
    hash
  end

  def nginx_vhost_ports( hash = {} )
    NginxVhost.all.each do |x|
      up = x.upstream_port.to_s
      if up.blank?
        hash['unknown'] << [x.class.to_s, x.id]
      elsif hash.has_key?( up )
        hash[up]        << [x.class.to_s, x.id]
      else
        hash[up] = []   << [x.class.to_s, x.id]
      end
    end
    hash
  end

  # monkey patch Redcarpet gem
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      if Pygments::Lexer.find(language)
        Pygments.highlight(code, lexer: language, options: {encoding: 'utf-8'})
      else
        Pygments.highlight(code, options: {encoding: 'utf-8'})
      end
    end
  end


  def markdown(text)
    unless @markdown
      gitlab_renderer = Redcarpet::Render::GitlabHTML.new(self,
                          # see https://github.com/vmg/redcarpet#darling-i-packed-you-a-couple-renderers-for-lunch-
                          filter_html: true,
                          with_toc_data: true,
                          hard_wrap: true)
      @markdown = Redcarpet::Markdown.new(gitlab_renderer,
                      # see https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use
                      no_intra_emphasis: true,
                      tables: true,
                      fenced_code_blocks: true,
                      autolink: true,
                      strikethrough: true,
                      lax_html_blocks: true,
                      space_after_headers: true,
                      superscript: true)
    end

    @markdown.render(text).html_safe
  end

  def css_from_string( css )
    capture_haml do
      haml_tag :style, :type=>"text/css" do
        haml_concat css
      end
    end
  end

end
