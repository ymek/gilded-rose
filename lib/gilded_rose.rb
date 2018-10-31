class GildedRose
  attr_reader :name, :days_remaining, :quality

  STATIC_ITEMS = [
    'Sulfuras, Hand of Ragnaros'.freeze
  ]

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def is_item?(item_name)
    !!(@name == item_name)
  end

  def is_aged_brie?
    is_item?('Aged Brie'.freeze)
  end

  def is_backstage_passes?
    is_item?('Backstage passes to a TAFKAL80ETC concert'.freeze)
  end

  def should_decay?
    @days_remaining < 0
  end

  def is_sell_date?
    @days_remaining == 0
  end

  def should_update?
    !STATIC_ITEMS.include?(@name)
  end

  def update_aged_brie
    if @quality < 50
      @quality = @quality + 1
    end
  end

  def update_backstage_passes
    if @quality < 50
      @quality = @quality + 1

      if @days_remaining < 11
        if @quality < 50
          @quality = @quality + 1
        end
      end

      if @days_remaining < 6
        if @quality < 50
          @quality = @quality + 1
        end
      end
    end
  end

  def update_generic
    if @quality > 0
      @quality = @quality - 1
    end
  end

  def decay_aged_brie
    if @quality < 50
      @quality = @quality + 1
    end
  end

  def decay_backstage_passes
    @quality = 0
  end

  def decay_generic
    if @quality > 0
      @quality = @quality - 1
    end
  end

  def tick
    if should_update?
      if is_aged_brie?
        update_aged_brie
      elsif is_backstage_passes?
        update_backstage_passes
      else
        update_generic
      end

      @days_remaining = @days_remaining - 1

      if should_decay?
        if is_aged_brie?
          decay_aged_brie
        elsif is_backstage_passes?
          decay_backstage_passes
        else
          decay_generic
        end
      end
    end
  end
end
