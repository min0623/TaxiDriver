class AllocationSerializer
  class << self

    def serialize(allocation, include_root = true)
      allocation.as_json(root: include_root)
    end

    def serialize_all(allocations)
      {
        allocations: allocations.map do |allocation|
          serialize(allocation, false)
        end
      }.as_json
    end
  end
end