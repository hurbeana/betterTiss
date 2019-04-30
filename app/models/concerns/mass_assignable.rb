module MassAssignable
  extend ActiveSupport::Concern

  def assign_hash(hash)
    hash.each do |key, value|
      next if key == 'id'

      key = key.to_sym
      self.class.send(:attr_accessor, key) unless respond_to? "#{key}="
      send("#{key}=", value)
    end
  end

  def create_if_exists(hash, key, name: key.to_sym)
    return unless hash.key?(key)
    return if respond_to?(name) && !send(name).nil?

    self.class.send(:attr_accessor, name)
    send("#{name}=", hash[key])
  end
end