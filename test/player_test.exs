defmodule PlayerTest do
  use ExUnit.Case
  alias Servus.Serverutils
  alias Servus.Message

  setup_all do
    connect_opts = [
      :binary,
      packet: 4,
      active: false,
      reuseaddr: true
    ]

    {:ok, socket_alice} = :gen_tcp.connect('localhost', 3334, connect_opts)
    {:ok, [
      alice: %{raw: socket_alice, type: :tcp},
    ]}
  end

  test "integration test (TCP) for the Player Module", context do
    
    assert :ok == Serverutils.send(context.alice, ["player","register"], "Alice B. Cooper")

    assert(
      %Message{type: ["player", "registered"], value: 1, target: nil} == 
      Serverutils.recv(context.alice, parse: true, timeout: 100)
    )

    assert :ok == Serverutils.send(context.alice, ["player","anything"], nil)

    assert(
      %Message{type: ["player", "error"], value: "Unknown function: anything", target: nil} == 
      Serverutils.recv(context.alice, parse: true, timeout: 100)
    )
  end
end
