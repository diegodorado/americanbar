class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.string :nombre_fantasia
      t.string :cuit
      t.string :direccion
      t.string :localidad
      t.string :provincia
      t.string :cp
      t.string :condicion_venta
      t.string :condicion_iva
      t.boolean :descuento10
      t.boolean :descuento20
      t.string :remito_direccion
      t.string :remito_localidad
      t.string :remito_provincia
      t.string :remito_cp
      t.string :email
      t.string :tel_fax
      t.text :observaciones

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
