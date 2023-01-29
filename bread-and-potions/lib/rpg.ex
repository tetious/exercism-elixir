defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_item, %Character{} = character) do
      {nil, %Character{character | health: character.health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(%ManaPotion{strength: strength}, %Character{} = character) do
      {%EmptyBottle{}, %Character{character | mana: character.mana + strength}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_item, %Character{} = character) do
      {%EmptyBottle{}, %Character{character | health: 0}}
    end
  end
end
