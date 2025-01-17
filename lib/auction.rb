class Auction
  attr_reader :items,
              :date

  def initialize
    @items = [],
    @date = Date.today
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map! {|item| item.name}
  end

  def unpopular_items
    unpopular_items = []
    @items.each do |item|
      unpopular_items << item if item.bids == {}
    end
    unpopular_items
  end

  def potential_revenue
    @items.map! { |item| item.current_high_bid }
    sum = 0
    @items.compact.map { |bid| sum += bid  }
    sum
  end

  # Was a little unsure if bidders was supposed to be an
  # attribute for auction, would have made it an array
  # that gets shoveled into each time a bid is placed
  # and then use something like .uniq to remove duplicates
  def bidders
    @items.flat_map do |item|
      item.bids.map do |bid|
        bid[0].name
      end
    end.uniq
  end

  def bidder_info
    bidder_hash = {}
    @items.map do |item|
      item.bids.map do |bid|
        bid[0]
      end
    end.flatten.uniq.each do |bidder|
      bidder_hash[bidder] = {
        :budget => bidder.budget,
        :items => []
      }
    end

    bidder_hash.each do |bidder, values|
      @items.map do |item|
        item.bids.map do |bid|
          #if bid != {}
            values[:items] << item if bid.include?(bidder)
          #end
        end
      end
    end
  end


end
