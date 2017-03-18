defmodule WikiEvent do
  @moduledoc """
  Documentation for WikiEvent.
  """

  @doc """
  Hello world.

  ## Examples

      iex> WikiEvent.hello
      :world

  """
  def main(opts) do
    {:ok, day}   = Timex.today |> Timex.format("{D}")
    {:ok, month} = Timex.today |> Timex.format("{M}")

    # url設定
    url = "https://ja.wikipedia.org/wiki/#{month}月#{day}日"

    %HTTPoison.Response{status_code: 200, body: body} = HTTPoison.get!(url)

    # 上から順にできごとまでのulの数を計算
    event_locate = body
                   |> Floki.parse
                   |> Floki.find("ul")
                   |> Enum.at(0)
                   |> Floki.find("ul")
                   |> Enum.count
    # Flokiでhtmlをパース
    # wikipedia全ての中のulをfind
    # 上からevent_locate番目のulを抽出(できごと の ul)
    # そのliをfind
    # そのそれぞれのテキストを抽出
    IO.inspect body
      |> Floki.parse
      |> Floki.find("ul")
      |> Enum.at(event_locate)
      |> Floki.find("li")
      |> Enum.map(&(&1 |> Floki.text))
      |> Enum.random
  end
end
