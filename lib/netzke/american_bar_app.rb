module Netzke
  class AmericanBarApp < BasicApp
    def self.js_panels
      [{
        :region => 'center',
        :layout => 'border',
        :items => super
      }]
    end

    def actions
      fn = :load_widget_by_action
      super.merge({ 
        :products              => {:text => "Productos",                    :handler => fn},
        :clients               => {:text => "Clientes",                     :handler => fn},
        :invoices              => {:text => "Facturas/Remitos",             :handler => fn},
        :client_product        => {:text => "Clientes/Productos",           :handler => fn},
        :users                 => {:text => "Users",                        :handler => fn},
        :roles                 => {:text => "Roles",                        :handler => fn},
      })
    end

    def menu
      common_menu = [
        "-",
        :products,
        "-",
        :clients,
        "-",
        :invoices,
        "-",
        :client_product,
        "-",
      ]

      
      # only add the Admin menu when the user has role "administrator"
      current_user = User.find_by_id(session[:netzke_user_id])
      if current_user.try(:role).try(:name) == 'administrator'
        common_menu.unshift(:text => "Admin", :menu => %w{ users roles toggle_config_mode masquerade_selector})
      end
      common_menu + super
    end

    # Prevent access to UserManager and roles for anonimous users
    #
    def load_aggregatee_with_cache(params)
      widget = params[:id].underscore
      current_user = User.find_by_id(session[:netzke_user_id])
      if current_user.nil? && (widget == "users" || widget == 'roles')
        flash :error => "You don't have access to this widget"
        {:feedback => @flash}
      else
        super
      end
    end


    def initial_late_aggregatees
      {
        :products => {
          :class_name => "GridPanel",
          :model => "Product",
          :ext_config => {
            :title => "Productos",
            :rows_per_page => 20
          }
        },
        :clients => {
          :class_name => "GridPanel", 
          :model => "Client", 
          :ext_config => {
            :title => "Clientes",
            :rows_per_page => 20
          }
        },
        :invoices => {
          :class_name    => "InvoiceGridPanel",
          :model => "InvoiceForGridPanel",
          :ext_config => {
            :title => "Facturas/Remitos",
            :prohibit_update => true
          },
          
        },
        :client_product => {
          :class_name => "GridPanel",
          :model => "InvoiceProduct",
          :ext_config => {
            :title => "Clientes/Productos",
            :rows_per_page => 20
          },
          :columns => [
            :id, 
            {:name => :invoice__client__name,:label => "Cliente"},
            {:name => :invoice__date,:label => "Fecha"},
            {:name => :product__name,:label => "Producto"}, 
            {:name => :quantity,:label => "Cantidad"}, 
            {:name => :price,:label => "Precio"},
          ],
        },

        :masquerade_selector => {
          :class_name => "MasqueradeSelector"
        },
        
        :roles => {
          :class_name => "GridPanel",
          :model => "Role"
        },

        :users => {
          :class_name => "GridPanel",
          :model => "User",
          :columns => [:id, :login,:password,:password_confirmation, :role__name, :login_count, :last_login_at, :last_request_at, :active_recently]
        },
        
      }
    end

    def self.js_extend_properties
      {
        :panels => self.js_panels
      }
    end
  end
end
