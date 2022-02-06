class PseInfo
  include ActiveModel::Model
  attr_accessor :banco, :nombre_del_titular, :tipo_de_cliente, :tipo_documento_de_idetificacion, :numero_de_identificacion,
                :telefono, :base, :tax, :value, :order_id

end