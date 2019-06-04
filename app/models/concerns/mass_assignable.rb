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

  def create_if_exists(hash, *args, name: key.to_sym)
    exists = false
    args.each do |key|
      exists = false
      break unless hash.is_a?(Hash)

      exists = hash.key?(key)
      break unless exists

      hash = hash[key]
    end
    return unless exists
    return if respond_to?(name) && !send(name).nil?

    self.class.send(:attr_accessor, name)
    send("#{name}=", hash)
  end

  def create_if_not_exists(hash, key, val, name: key.to_sym)
    return if hash.key?(key)

    self.class.send(:attr_accessor, name)
    send("#{name}=", val)
  end
end