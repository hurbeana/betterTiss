##
# A module that can be mixed in so that a hash can be used to dynamically create
# attr_accessor on the given objects of that class.
module MassAssignable
  extend ActiveSupport::Concern

  ##
  # Reads in the hash and dynamically assigns all key, values to the object with
  # the expection of the key 'id' which is not being assigned.
  # @param hash the given hash which contains the data and keys for the object
  def assign_hash(hash)
    hash.each do |key, value|
      next if key == 'id'

      key = key.to_sym
      self.class.send(:attr_accessor, key) unless respond_to? "#{key}="
      send("#{key}=", value)
    end
  end

  ##
  # Creates an attribute on the object with the value from the hash (if it exists).
  # The name given in name: will be used for the name on the object.
  # @param [Hash] hash the hash that contains the data
  # @param [Array<String>] args the keys that need to be followed in the hash
  # to get the value (if the hash has subhashes) e.g. a['key1']['key2']['etc']
  # @param [String] name the name that the value should get on the object
  def create_if_exists(hash, *args, name:)
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

  ##
  # Create key, value on the object if it not already exists in the hash
  # @param [Hash] hash the hash that has the key, value
  # @param [String] key the key that contains the value
  # @param [String] val the value that needs to be attached to the object
  # @option [Symbol] name the name that the value gets on the object
  def create_if_not_exists(hash, key, val, name: key.to_sym)
    return if hash.key?(key)

    self.class.send(:attr_accessor, name)
    send("#{name}=", val)
  end
end