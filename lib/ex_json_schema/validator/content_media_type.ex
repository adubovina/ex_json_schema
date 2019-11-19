defmodule ExJsonSchema.Validator.ContentMediaType do
  @moduledoc """
  `ExJsonSchema.Validator` implementation for `"contentMediaType"` attributes.

  See:
  https://tools.ietf.org/html/draft-handrews-json-schema-validation-01#section-8.4
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
  def validate(%{version: version}, schema, {"contentMediaType", content_media_type}, data)
      when version >= 7 do
    do_validate(schema, content_media_type, data)
  end

  def validate(_, _, _, _) do
    []
  end

  defp do_validate(%{"contentEncoding" => "base64"}, "application/json", data) do
    with {:ok, json} <- Base.decode64(data),
         {:ok, _} <- ExJsonSchema.Schema.decode_json(json) do
      []
    else
      _ ->
        [{"Invalid base64 encoded JSON string.", []}]
    end
  end

  defp do_validate(_, "application/json", data) do
    case ExJsonSchema.Schema.decode_json(data) do
      {:ok, _} ->
        []

      {:error, _} ->
        [{"Invalid JSON string.", []}]
    end
  end

  defp do_validate(_, _, _) do
    []
  end
end
