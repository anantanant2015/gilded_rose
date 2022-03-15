defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  @names_for_sell_in_update ["Sulfuras, Hand of Ragnaros"]

  @registered_names [
    "Aged Brie",
    "Backstage passes to a TAFKAL80ETC concert",
    "Sulfuras, Hand of Ragnaros"
  ]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(item) do
    item
    |> update_sell_in()
    |> update_quality_of_item()
  end

  defp update_sell_in(%{name: name} = item) when name not in @names_for_sell_in_update do
    %{item | sell_in: item.sell_in - 1}
  end

  defp update_sell_in(item), do: item

  defp update_quality_of_item(%{name: name} = item) when name not in @registered_names do
    case {item.quality > 0, item.sell_in < 0} do
      {false, false} ->
        item

      {true, true} ->
        %{item | quality: item.quality - 2}

      {_, _} ->
        %{item | quality: item.quality - 1}
    end
  end

  defp update_quality_of_item(%{name: name, quality: quality, sell_in: sell_in} = item) do
    case name do
      "Aged Brie" when quality < 50 ->
        if sell_in < 0 do
          %{item | quality: item.quality + 2}
        else
          %{item | quality: item.quality + 1}
        end

      "Aged Brie" when not quality < 50 ->
        item

      "Backstage passes to a TAFKAL80ETC concert" when quality < 50 ->
        if sell_in < 0 do
          %{item | quality: quality - quality}
        else
          %{item | quality: item.quality + 2}
        end

      "Backstage passes to a TAFKAL80ETC concert" when not quality < 50 ->
        if sell_in < 0 do
          %{item | quality: quality - quality}
        else
          item
        end

      "Sulfuras, Hand of Ragnaros" ->
        item

      _ ->
        item
    end
  end
end