Puppet::Type.type(:oslo_config).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:openstack_config).provider(:ini_setting)
) do

  def create
    super
    warning('oslo_config is deprecated, and will be removed in a future release')
  end

  def self.file_path
    '/etc/oslo/oslo.conf'
  end

end
