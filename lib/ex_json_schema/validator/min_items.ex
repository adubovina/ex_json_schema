defmodule ExJsonSchema.Validator.MinItems do
  @moduledoc """
  `ExJsonSchema.Validator` implementation for `"minItems"` attributes.

  See:

  """

  alias ExJsonSchema.Schema.Root
  alias ExJsonSchema.Validator

  @behaviour ExJsonSchema.Validator

  @impl ExJsonSchema.Validator
  @spec validate(
          root :: Root.t(),
          schema :: ExJsonSchema.data(),
          property :: {String.t(), ExJsonSchema.data()},
          data :: ExJsonSchema.data()
        ) :: Validator.errors_with_list_paths()
  def validate(_, _, {"minItems", min_items}, data) do
    do_validate(min_items, data)
  end

  def validate(_, _, _, _) do
    []
  end

  defp do_validate(min_items, items) when is_list(items) do
    count = Enum.count(items)

    if count >= min_items do
      []
    else
      [{"Expected a minimum of #{min_items} items but got #{count}.", []}]
    end
  end

  defp do_validate(_, _) do
    []
  end
end
