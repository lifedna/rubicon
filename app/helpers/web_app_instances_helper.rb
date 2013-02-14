module WebAppInstancesHelper

  def services_icons( web_app_instance )
    capture_haml do
      if web_app_instance.ssl
        haml_tag :i, :class => 'icon-lock', :rel => 'tooltip', :title => 'ssl wrapped'
      end
      if web_app_instance.maint_page
        haml_tag :i, :class => 'icon-wrench', :rel => 'tooltip', :title => 'has a maint page'
      end
    end
  end

end