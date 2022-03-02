class Forest::Feed::ItemPolicy < BlockRecordPolicy
  def sync?
    admin?
  end
end
