

class CountHash < Hash
  def self.from_hash h
    return CountHash.new.merge(h)
  end

  def get key
    return nil if !self[key]
    self[key] -= 1
    if self[key] == 0
      delete key
      return key
    end
    return key
  end
end
